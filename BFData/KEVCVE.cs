using Microsoft.VisualBasic;

namespace BFData
{
    public record KEVCVE(string cve, string? vendorProject, string? product, string? vulnerabilityName, DateTime? dateAdded, string? shortDescription);
}
