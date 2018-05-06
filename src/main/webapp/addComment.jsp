<%@ page import="com.sdacademy.twitter.utils.Utils" %>
<%@ page import="com.sdacademy.twitter.dao.TweetDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <title>Add Comment</title>
</head>
<body>
<% Utils.activateSession(request);
    String id = request.getParameter("id");
    request.setAttribute("tweet", id);%>
<c:if test="${!sessionOk}">
    <h3 style="color: red">Aby dodawać komentarze należy się zalogować do systemu!</h3>
</c:if>
<c:if test="${sessionOk}">
    <form method="post" action="addComment">
        <textarea name="message"></textarea>
        <input type="hidden" name="tweetId" value='<c:out value="${tweet}"/>'>
        <input type="submit" name="submit" value="Add Comment" />
    </form>
</c:if>
</body>
</html>
