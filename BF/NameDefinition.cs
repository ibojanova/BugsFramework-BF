using System.Diagnostics.CodeAnalysis;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BF
{
    public record CauseNameType(string Name, Cause CauseType); 
    public enum Cause { Bug, Fault, FinalError };

    //Error is parced, but not used for now -- it's the conseqeunce from Bug or Fault that becomes next fault.
    public record ConseqeunceNameType(string Name, Conseqeunce ConseqeunceType); 
    public enum Conseqeunce { Error, FinalError };

}
