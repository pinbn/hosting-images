using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

[WebService(Namespace = "http://test.test/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TestService : System.Web.Services.WebService
{
    public TestService() { }

    [WebMethod]
    public TestResult Test()
    {
	    return new TestResult() { Content = "Success" };
    }
}

[Serializable]
public class TestResult {
    public string Content { get; set; }
}
