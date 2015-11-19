<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body>
<%  
String fname = request.getParameter("fname");
String mi = request.getParameter("mi") ; 
String lname = request.getParameter("lname");
String title = request.getParameter("title");
String grade = request.getParameter("grade");
String ssn = request.getParameter("ssn");        

%>


<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/student"
     user="root"  password=""/>

<sql:update dataSource="${snapshot}" var="result">
INSERT INTO student VALUES ("<%=fname %>","<%=mi %>","<%=lname %>","<%=title %>","<%=grade %>","<%=ssn %>");
</sql:update>

<sql:query dataSource="${snapshot}" var="result">
SELECT * FROM student;
</sql:query>

<table border="1" width="100%">
<tr>
   <th>First Name</th>
   <th>mi</th>
   <th>Last Name</th>
   <th>Title</th>
   <th>Grade</th>
   <th>SSN</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.firstName}"/></td>
   <td><c:out value="${row.mi}"/></td>
   <td><c:out value="${row.lastName}"/></td>
   <td><c:out value="${row.title}"/></td>
   <td><c:out value="${row.grade}"/></td>
   <td><c:out value="${row.ssn}"/></td>
</tr>
</c:forEach>
</table>
</body>
</html>
