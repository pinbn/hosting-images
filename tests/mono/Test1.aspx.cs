using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Test1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable ret = new DataTable();
        ret.Columns.Add(new DataColumn("Test1"));
        ret.AcceptChanges();
        DataRow dr = ret.NewRow();
        ret.Rows.Add(dr);
        dr["Test1"] = "Success";

        grid1.DataSource = ret;
        grid1.DataBind();
    }
}