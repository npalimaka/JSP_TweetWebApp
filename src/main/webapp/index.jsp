<%@ page pageEncoding="UTF-8" contentType="text/html" %>
<%@ page import="com.sdacademy.twitter.utils.Utils" %>
<%@ page import="com.sdacademy.twitter.dao.TweetDao" %>
<%@ page import="com.sdacademy.twitter.model.Tweet" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

    <title>SDA Twitter Registration Form</title>
</head>
<body>
<%
    Utils.activateSession(request);
    TweetDao tweetDao = TweetDao.getInstance();
    Optional<List<Tweet>> allTweets = tweetDao.getAll();
    if (allTweets.isPresent()) {
        request.setAttribute("tweetList", allTweets.get());
    }
%>
<jsp:useBean id="myDate" class="java.util.Date"/>
<div style="text-align: right;">
    <h6>
        <c:if test="${sessionOk}">
            <a href='profile.jsp?id=<c:out value="${userId}"/>'>Profile</a> / <a href="logout">Logout</a>
        </c:if>
        <c:if test="${!sessionOk}">
            <a href="login.jsp">Login</a> / <a href="register.jsp">Register</a>
        </c:if>
    </h6>
</div>

<div style="text-align: center">
    <h1>Tweets</h1>
    <c:if test="${sessionOk}">
        <h4><a href="addTweet.jsp">Add</a></h4>
    </c:if>
    <table border="1" style="width: 95%; text-align: center">
        <tr>
            <td>Author</td>
            <td>Message</td>
            <td>Published</td>
            <td>Comments</td>
            <c:if test="${sessionOk}">
                <td>Options</td>
            </c:if>
        </tr>
        <c:forEach items="${tweetList}" var="tweet">
            <tr>
                <td><c:out value="${tweet.user.nick}"/></td>
                <td><c:out value="${tweet.message}"/></td>
                <c:set target="${myDate}" property="time" value="${tweet.creationTS}"/>
                <td><c:out value="${myDate}"/></td>
                <td>
                    <a href='readComments.jsp?id=<c:out value="${tweet.id}"/>'>Read</a>
                    <a href='addComment.jsp?id=<c:out value="${tweet.id}"/>'>Add</a>
                </td>
                <c:if test="${sessionOk}">
                    <c:if test="${userId == tweet.user.id}">
                        <td>
                            <a href='removeTweet?id=<c:out value="${tweet.id}"/>'>Remove</a>
                            <a href='editTweet.jsp?id=<c:out value="${tweet.id}"/>'>Edit</a>
                        </td>
                    </c:if>
                    <c:if test="${userId != tweet.user.id}">
                        <td>&nbsp;</td>
                    </c:if>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
