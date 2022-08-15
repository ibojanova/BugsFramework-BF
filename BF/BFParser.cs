using System.Xml.Linq;
using System.Xml.XPath;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BF
{
    public class BFParser
    {
        public readonly static BFParser Parser = new();

        readonly XElement bfClasses;
        readonly Dictionary<string, string> definitions;
        public BFParser()
        {
            bfClasses = XElement.Parse(Properties.Resources.BF);
            definitions = bfClasses.XPathSelectElements("//Definitions/Definition")
                .ToDictionary(d => d.Attribute("Name")!.Value, d => d.Value);
        }

        public Dictionary<NameDefinition, IEnumerable<NameDefinition>> GetClasses(string type) =>
            bfClasses.XPathSelectElements($"//Cluster[@Type='{type}']").ToDictionary(
                t => new NameDefinition(t.Attribute("Name")!.Value, t.Attribute("Definition")?.Value),
                t => t.XPathSelectElements("Class").Select(
                    n => new NameDefinition(n.Attribute("Name")!.Value, n.Attribute("Definition")?.Value)));

        public Dictionary<NameDefinition, IEnumerable<NameDefinition>> GetClasses(BWF causeType) =>
            GetClasses(causeType switch {
                BWF.Failure => "Failure",
                _ => "Bug/Weakness"
            });

        XElement? GetClass(string bfClass) => bfClasses.XPathSelectElement($"//Class[@Name='{bfClass}']");

        public IEnumerable<string> GetOperations(string bfClass) => 
            GetClass(bfClass)!.XPathSelectElements("Operations/Operation").Select(n => n.Attribute("Name")!.Value);
        
        public Dictionary<NameDefinitionBWF, IEnumerable<string>> GetCauses(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Causes/*").ToDictionary(
                n => new NameDefinitionBWF(n.Attribute("Name")!.Value, n.Attribute("Definition")?.Value, n.Name.LocalName switch {
                "BugCauseType" => BWF.Bug, "WeaknessCauseType" => BWF.Weakness, _ => BWF.Failure}),
                n => n.XPathSelectElements("Cause").Select(v => v.Attribute("Name")!.Value));

        public Dictionary<NameDefinitionBWF, IEnumerable<string>> GetConsequences(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Consequences/*").ToDictionary(
                n => new NameDefinitionBWF(n.Attribute("Name")!.Value, n.Attribute("Definition")?.Value, n.Name.LocalName switch {
                    "WeaknessConsequenceType" => BWF.Weakness, "FinalErrorConsequenceType" => BWF.Failure, _ => BWF.Failure}),
                n => n.XPathSelectElements("Consequence").Select(v => v.Attribute("Name")!.Value));

        public Dictionary<NameDefinition, IEnumerable<string>> GetOperationAttributes(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Operations/AttributeType").ToDictionary(
                t => new NameDefinition(t.Attribute("Name")!.Value, t.Attribute("Definition")?.Value),
                t => t.XPathSelectElements("Attribute").Select(v => v.Attribute("Name")!.Value));

        public Dictionary<string, Dictionary<NameDefinition, IEnumerable<string>>> GetOperandAttributes(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Operands/Operand[AttributeType/Attribute]").ToDictionary(
                t => t.Attribute("Name")!.Value,
                t => t.XPathSelectElements("AttributeType").ToDictionary(
                    n => new NameDefinition(n.Attribute("Name")!.Value, t.Attribute("Definition")?.Value),
                    n => n.XPathSelectElements("Attribute").Select(v => v.Attribute("Name")!.Value)));

        public string? GetDefinition(string name) => definitions.TryGetValue(name, out var val) ? val : null;
    }
}
