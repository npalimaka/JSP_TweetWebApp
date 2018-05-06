<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Natalia
  Date: 22-Apr-18
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.sdacademy.twitter.utils.Utils" %>
<%@ page import="com.sdacademy.twitter.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <title>User Profile</title>
</head>
<body>
<%
    Utils.activateSession(request);
    UserDao user = UserDao.getInstance();
    Long id = Long.valueOf(request.getParameter("id"));
    request.setAttribute("user", user.get(id).get());
%>
<c:if test="${!sessionOk}">
    <h3 style="color: red">Aby edytować profil należy się zalogować do systemu!</h3>
</c:if>
<h1>User Profile</h1>
<c:if test="${sessionOk}">
    <c:set var="error" value="${param['err']}"/>
    <h6 style="color: red">
        <c:choose>
            <c:when test="${error eq 'nomail'}">Nie podano adresu email</c:when>
            <c:when test="${error eq 'nopass'}">Nie podano hasła</c:when>
            <c:when test="${error eq 'passnotmatch'}">Podane hasła nie są zgodne</c:when>
        </c:choose>
    </h6>
    <c:choose>
        <c:when test="${user != null}">
            <form method="post" action="editProfile">
            <table border="0">
                <tr>
                    <td>Nick:</td>
                    <td><c:out value="${user.nick}"/></td>
                </tr>
                <tr>
                    <td>E-mail:</td>
                    <td><input type="text" name="mail" id="mail" value="<c:out value='${user.email}'/>"></td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="pass1" id="pass1" value="<c:out value='${user.password}'/>"></td>
                </tr>
                <tr>
                   <td>Repeat Password:</td>
                   <td><input type="password" name="pass2" id="pass2" value="<c:out value='${user.password}'/>"></td>
                    </tr>
            </table>
            <input type="hidden" name="userId" value='<c:out value="${user.id}"/>'>
            <input type="submit" name="submit" value="Save">
            </form>
        </c:when>
        <c:otherwise>
            <h2 style="color: brown">User o podanym ID nie istnieje!</h2>
        </c:otherwise>
    </c:choose>
</c:if>
</body>
</html>
