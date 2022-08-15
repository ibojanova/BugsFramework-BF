using System.Diagnostics.CodeAnalysis;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BF
{
    public record NameDefinition(string Name, string? Definition) : IEqualityComparer<NameDefinition>
    {
        public bool Equals(NameDefinition? x, NameDefinition? y) => x?.Name == y?.Name;
        public int GetHashCode([DisallowNull] NameDefinition obj) => obj.Name.GetHashCode();
    }

    //CauseType is Bug, Weakness, or FinalError; Conseqeunce Type is Weakness, FinalError, or Risk; FinalError and Risk are only for Failure
    //xxx we may need to add one more state to Bug, Weakness, Failure xxx
    public enum BWF { Bug, Weakness, Failure };

    public record NameDefinitionBWF(string Name, string? Definition, BWF BWFType) : NameDefinition(Name, Definition);

}
