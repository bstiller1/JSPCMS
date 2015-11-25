<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
  Cookie cookie = null;
   Cookie[] cookies = null;
   boolean foundCookie = false;
   // Get an array of Cookies associated with this domain
   cookies = request.getCookies();
   if( cookies != null ){
       for (int i = 0; i < cookies.length; i++){
         cookie = cookies[i];
        if( cookie.getName().equals("email")){
             // out.print("Email Cookie found!");
             foundCookie = true;    
        } 
      }
   }
    else{
       out.print("No Cookies for you!");
   }
   if(!foundCookie){
       out.print("<script>window.location = 'login.html'</script>");
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CMS Update</title>
</head>
<body>
<%  
    
String home = request.getParameter("home");
String about = request.getParameter("about") ; 
String services = request.getParameter("services");
String contact = request.getParameter("contact");
      
%>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/cms"
     user="root"  password=""/>

<sql:update dataSource="${snapshot}" var="result">
UPDATE content SET home="<%=home %>", about="<%=about %>",services="<%=services %>",contact="<%=contact %>" WHERE id = '1';
</sql:update>

<sql:query dataSource="${snapshot}" var="result">
SELECT home, about, services, contact FROM content;
</sql:query>
<form method="post">
<table border="1" width="100%">
<c:forEach var="row" items="${result.rows}">
<tr>
    <td>Home:<br /><textarea name="home"><c:out value="${row.home}"/></textarea></td>
</tr>
<tr>
    <td>About:<br /><textarea name="about"><c:out value="${row.about}"/></textarea></td>
</tr>
<tr>
    <td>Services:<br /><textarea name="services"><c:out value="${row.services}"/></textarea></td>
</tr>
<tr>
    <td>Contact:<br /><textarea name="contact"><c:out value="${row.contact}"/></textarea></td>
</tr>
</c:forEach>
<tr>
    <td><input type="submit" />
</tr>
</table>
</form>
</body>
</html>
