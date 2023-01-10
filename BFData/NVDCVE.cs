/*@author Irena Bojanova(ivb)
 *@date - 12/20/2022 */

namespace BFData
{
    public record NVDCVE(string cve, string? description, double? score, string[]? cwe);
}