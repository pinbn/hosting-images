<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="DefaultPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Default</title>
</head>
<body>
    <ul>
        <li><a class="testlink" href="/Test1.aspx">Test: WebForms</a></li>
        <li><a class="testlink" href="/TestService.asmx/Test">Test: SOAP WebService GET</a></li>
    </ul>
</body>
</html>
