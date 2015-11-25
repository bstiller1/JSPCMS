<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%  
String gemail = request.getParameter("email");
String pword = request.getParameter("pword");     
%>
 <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/cms"
     user="root"  password=""/>
 <sql:query dataSource="${snapshot}" var="result">
SELECT fname, lname, email, pword FROM users WHERE email = '<%= gemail %>';
</sql:query>
<c:forEach var="row" items="${result.rows}">
    <c:set var="fname" scope="session" value="${row.fname}"/>
    <c:set var="lname" scope="session" value="${row.lname}"/>
    <c:set var="email" scope="session" value="${row.email}"/>
    <c:set var="checkPword" scope="session" value="${row.pword}"/>
    </c:forEach>
<c:set var="gemail" scope="session" value="<%= gemail %>"/>
 <% //First Name: ${fname} Last Name: ${lname} EMail: ${email}  EMail:<%= gemail %> ${checkPword} %>

 <c:choose>
    <c:when test="${email.equals(gemail)}">
         <p>Welcome, ${fname} ${lname}<p>
<%
    // Create cookies for first and last names.      
   Cookie email = new Cookie("email",
   request.getParameter("email"));
      // Set expiry date after 24 Hrs for both the cookies.
   email.setMaxAge(60*60*24); 

   // Add both the cookies in the response header.
   response.addCookie( email );
                 out.print("<script>window.location = 'edit.jsp'; </script>");
                 
                 %>
    </c:when>    
    <c:otherwise>
    <p>That Email and Password is not registered, please <a href="register.html" title="Register">Register</a>.</p>
    </c:otherwise>
</c:choose>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMS Login</title>
    </head>
    <body>

        <h1>Hello World!</h1>
    </body>
</html>
