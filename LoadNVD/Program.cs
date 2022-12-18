using BFData;
using BFDB;
using LoadNVD;

await new JsonDB<NVDCVE>(@"Server=PG906872\SQLEXPRESS;Database=BF;Integrated Security=True").SaveVulnerabilities(new LoaderNVD().GetVulnerabilities(), "nvd.loadCve");
