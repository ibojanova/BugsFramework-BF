using BFData;
using BFDB;
using LoadKEV;

/*@author Irena Bojanova(ivb)
 *@date - 12/20/2022 */

await new JsonDB<KEVCVE>(@"Server=PG906872\SQLEXPRESS;Database=BF;Integrated Security=True").SaveVulnerabilities(new LoaderKEV().GetVulnerabilities(), "kev.loadCve");