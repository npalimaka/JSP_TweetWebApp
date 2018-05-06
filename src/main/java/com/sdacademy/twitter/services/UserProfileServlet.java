package com.sdacademy.twitter.services;

import com.sdacademy.twitter.dao.UserDao;
import com.sdacademy.twitter.model.Tweet;
import com.sdacademy.twitter.model.User;
import com.sdacademy.twitter.utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "editProfileServlet", value = "/editProfile")
public class UserProfileServlet extends HttpServlet {
    UserDao userDao = UserDao.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        final String email = req.getParameter("mail");
        final String pass1 = req.getParameter("pass1");
        final String pass2 = req.getParameter("pass2");
        final Optional<Long> userId = Utils.getUserIdFromSession(req);
        final Long id = Long.valueOf(req.getParameter("userId"));

        if (isNullOrEmpty(email)) {
            resp.sendRedirect("profile.jsp?err=nomail");
            return;
        }

        if (isNullOrEmpty(pass1) || isNullOrEmpty(pass2)) {
            resp.sendRedirect("profile.jsp?err=nopass");
            return;
        }

        if (!pass1.equals(pass2)) {
            resp.sendRedirect("profile.jsp?err=passnotmatch");
            return;
        }

        Optional<User> userFromDb = userDao.get(id);
        if (userFromDb.isPresent()) {
            final User user = userFromDb.get();
            if (userId.isPresent()) {
                if (userId.get().equals(user.getId())) {
                    user.setEmail(email);
                    user.setPassword(pass1);
                    userDao.update(user);
                }
            }
        }

        resp.sendRedirect("index.jsp");
    }
    private boolean isNullOrEmpty(final String val) {
        return (val == null || val == "");
    }
}
