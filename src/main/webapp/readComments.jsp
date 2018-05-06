<%@ page import="com.sdacademy.twitter.utils.Utils" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sdacademy.twitter.dao.CommentDao" %>
<%@ page import="com.sdacademy.twitter.model.Comment" %>
<%@ page import="com.sdacademy.twitter.dao.TweetDao" %>
<%@ page import="com.sdacademy.twitter.model.Tweet" %>
<%@ page import="java.util.Set" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All comments</title>

</head>
<body>
<%
    Utils.activateSession(request);
    TweetDao tweetDao = TweetDao.getInstance();
    Long id = Long.valueOf(request.getParameter("id"));
    Optional<Tweet> tweetFromDb = tweetDao.get(id);
    if (tweetFromDb.isPresent()) {
        Tweet tweet = tweetFromDb.get();
        request.setAttribute("commentList", tweet.getComments());
    }
//    CommentDao commentDao = CommentDao.getInstance();
//    Optional<List<Comment>> allComments = commentDao.getAll();
//    if (allComments.isPresent()) {
//        request.setAttribute("commentList", allComments.get());
//    }
%>
<jsp:useBean id="myDate" class="java.util.Date"/>
<div>
    <table border="1" style="width: 95%; text-align: center">
        <tr>
            <td>Author</td>
            <td>Comment</td>
            <td>Published</td>
            <c:if test="${sessionOk}">
                <td>Options</td>
            </c:if>
        </tr>
        <c:forEach items="${commentList}" var="comment">
            <tr>
                <td><c:out value="${comment.author.nick}"/></td>
                <td><c:out value="${comment.message}"/></td>
                <c:set target="${myDate}" property="time" value="${comment.creationTS}"/>
                <td><c:out value="${myDate}"/></td>
                <c:if test="${sessionOk}">
                    <c:if test="${userId == comment.author.id}">
                        <td>
                            <a href='removeComment?id=<c:out value="${comment.id}"/>'>Remove</a>
                            <a href='editComment.jsp?id=<c:out value="${comment.id}"/>'>Edit</a>
                        </td>
                    </c:if>
                    <c:if test="${userId != comment.author.id}">
                        <td>&nbsp;</td>
                    </c:if>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
