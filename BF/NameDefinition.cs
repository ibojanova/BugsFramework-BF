using System.Diagnostics.CodeAnalysis;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BF
{
    public record ErrorName(string Name, Error CauseType); 

    public enum Error { Bug, OperandError, FinalError };

}
