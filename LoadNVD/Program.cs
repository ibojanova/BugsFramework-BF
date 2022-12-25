using BFData;
using BFDB;
using LoadNVD;

/*@author Irena Bojanova(ivb)
 *@date - 12/20/2022 */

await new JsonDB<NVDCVE>(@"Server=PG906872\SQLEXPRESS;Database=BF;Integrated Security=True").SaveVulnerabilities(new LoaderNVD().GetVulnerabilities(), "nvd.loadCve");