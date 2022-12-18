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

        public Dictionary<string, IEnumerable<string>> GetClasses(string type) =>
            bfClasses.XPathSelectElements($"//Cluster[@Type='{type}']").ToDictionary(
                t => t.Attribute("Name")!.Value,
                t => t.XPathSelectElements("Class").Select(
                    n => n.Attribute("Name")!.Value));

        public Dictionary<string, IEnumerable<string>> GetClasses(Error errorType) =>
            GetClasses(errorType switch {Error.FinalError => "Failure", _ => "Weakness"});

        XElement? GetClass(string bfClass) => bfClasses.XPathSelectElement($"//Class[@Name='{bfClass}']");

        public IEnumerable<string> GetOperations(string bfClass) => 
            GetClass(bfClass)!.XPathSelectElements("Operations/Operation").Select(n => n.Attribute("Name")!.Value);

        public Dictionary<string, IEnumerable<string>> GetOperationAttributes(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Operations/Attribute").ToDictionary(
                t => t.Attribute("Name")!.Value,
                t => t.XPathSelectElements("Value").Select(v => v.Attribute("Name")!.Value));

        public Dictionary<string, Dictionary<string, IEnumerable<string>>> GetOperandAttributes(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Operands/Operand[Attribute]").ToDictionary(
                t => t.Attribute("Name")!.Value,
                t => t.XPathSelectElements("Attribute").ToDictionary(
                    n => n.Attribute("Name")!.Value,
                    n => n.XPathSelectElements("Value").Select(v => v.Attribute("Name")!.Value)));

        public Dictionary<ErrorName, IEnumerable<string>> GetCauses(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Causes/*").ToDictionary(
                n => new ErrorName(n.Attribute("Name")!.Value, n.Name.LocalName switch {
                    "Bug" => Error.Bug, "ImproperOperand" => Error.ImproperOperand, _ => Error.FinalError}),
                n => n.XPathSelectElements("Value").Select(v => v.Attribute("Name")!.Value));

        public Dictionary<ErrorName, IEnumerable<string>> GetConsequences(string bfClass) =>
            GetClass(bfClass)!.XPathSelectElements("Consequences/*").ToDictionary(
                n => new ErrorName(n.Attribute("Name")!.Value, n.Name.LocalName switch {
                    "ImproperOperand" => Error.ImproperOperand, _ => Error.FinalError}),
                n => n.XPathSelectElements("Value").Select(v => v.Attribute("Name")!.Value));
        public string? GetDefinition(string name) => definitions.TryGetValue(name, out var val) ? val : null;
    }
}
