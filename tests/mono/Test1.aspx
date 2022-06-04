<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test1.aspx.cs" Inherits="Test1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test1</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Test" DataField="Test" />
            </Columns>
        </asp:GridView>
    </div>
    </form>
    <a href="/TestService.asmx/Test">Test: SOAP WebService GET</a>
</body>
</html>
