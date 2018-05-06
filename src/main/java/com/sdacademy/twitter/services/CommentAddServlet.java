package com.sdacademy.twitter.services;

import com.sdacademy.twitter.dao.CommentDao;
import com.sdacademy.twitter.dao.TweetDao;
import com.sdacademy.twitter.dao.UserDao;
import com.sdacademy.twitter.model.Comment;
import com.sdacademy.twitter.model.Tweet;
import com.sdacademy.twitter.model.User;
import com.sdacademy.twitter.utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Servlet responsible for adding comments
 */

@WebServlet(name = "addCommentServlet" , value = "/addComment")
public class CommentAddServlet extends HttpServlet {

    private UserDao userDao;
    private TweetDao tweetDao;
    private CommentDao commentDao;

    public CommentAddServlet() {
        userDao = UserDao.getInstance();
        tweetDao = TweetDao.getInstance();
        commentDao = CommentDao.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String message = req.getParameter("message");
        final String tweetId = req.getParameter("tweetId");
        final Long lId = Long.valueOf(tweetId);

        final Optional<Long> userId = Utils.getUserIdFromSession(req);
        if (userId.isPresent()) {
            Optional<User> user = userDao.get(userId.get());
            Optional<Tweet> tweet = tweetDao.get(lId);
            if (user.isPresent() && tweet.isPresent()) {
                final Comment comment = Comment.builder()
                        .message(message)
                        .tweet(tweet.get())
                        .author(user.get())
                        .creationTS(System.currentTimeMillis())
                        .build();
                commentDao.add(comment);
            }
        }
        resp.sendRedirect("index.jsp");
    }
}
