<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.Web.Http" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        
        ' instantiate paypal variables
        Application.Add("paypalUser", "alan_1345295613_biz_api1.functionfirst.co.uk")
        Application.Add("paypalPwd", "1345295653")
        Application.Add("paypalSignature", "ARXIhtcX7pMA7.bx2ERwIEeOnZnxAppM9Z63ZNdnJQJwyIDewS.RUztt")
        
        RouteTable.Routes.MapHttpRoute("API", "api/{controller}/{action}", New With {.id = System.Web.Http.RouteParameter.Optional})
        

        GlobalConfiguration.Configuration.Formatters.Clear()
        GlobalConfiguration.Configuration.Formatters.Add(New System.Net.Http.Formatting.JsonMediaTypeFormatter())
    End Sub
 
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Session("filepath") = "C:\HostingSpaces\getbuild\buildmateapp.com\wwwroot\"
        
        ' Set a Session Start Time
        ' This is only important to assure we start a session
        Session("Start") = Now()
        Session("sessionid") = Day(Now()) & Month(Now()) & Year(Now()) & Session.SessionID
        Session("lockedAccount") = False
  
        ' Set the Locale Identifier
        ' Converts currency, date and time to British English format (£) (dd/mm/yyyy) (hh:mm:ss)
        Session.LCID = 2057
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
       
</script>