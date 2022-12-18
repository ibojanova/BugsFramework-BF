using BFData;
using BFDB;
using LoadKEV;

await new JsonDB<KEVCVE>(@"Server=PG906872\SQLEXPRESS;Database=BF;Integrated Security=True").SaveVulnerabilities(new LoaderKEV().GetVulnerabilities(), "kev.loadCve");