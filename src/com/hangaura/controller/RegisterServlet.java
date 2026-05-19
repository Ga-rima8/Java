package com.hangaura.controller;

import com.hangaura.DAO.UserDAO;
import com.hangaura.Model.UserModel;
import com.hangaura.utils.PasswordUtil;
import com.hangaura.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/Pages/register.jsp")
                .forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {

            // ───── INPUTS ─────
            String firstName = ValidationUtil.clean(req.getParameter("first_name"));
            String lastName  = ValidationUtil.clean(req.getParameter("last_name"));
            String username  = ValidationUtil.clean(req.getParameter("username"));
            String email     = ValidationUtil.clean(req.getParameter("email"));
            String number    = ValidationUtil.clean(req.getParameter("number"));
            String gender    = ValidationUtil.clean(req.getParameter("gender"));
            String dobStr    = ValidationUtil.clean(req.getParameter("dob"));
            String password  = req.getParameter("password");

            // ✅ NEW FIELD: PROGRAM ID
            String programIdStr = req.getParameter("program_id");

            int programId = 0;
            if (!ValidationUtil.isNullOrBlank(programIdStr)) {
                programId = Integer.parseInt(programIdStr);
            }

            // ───── VALIDATION ─────
            if (ValidationUtil.isNullOrBlank(firstName)
                    || ValidationUtil.isNullOrBlank(lastName)
                    || ValidationUtil.isNullOrBlank(username)
                    || ValidationUtil.isNullOrBlank(password)) {

                req.setAttribute("error", "Required fields missing.");
                req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
                return;
            }

            // ───── DUPLICATE CHECK ─────
            if (userDAO.usernameExists(username)) {
                req.setAttribute("error", "Username already exists.");
                req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
                return;
            }

            if (!ValidationUtil.isNullOrBlank(email) && userDAO.emailExists(email)) {
                req.setAttribute("error", "Email already exists.");
                req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
                return;
            }

            // ───── CREATE USER OBJECT ─────
            UserModel user = new UserModel();

            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setUserName(username);
            user.setEmail(ValidationUtil.isNullOrBlank(email) ? null : email);
            user.setNumber(ValidationUtil.isNullOrBlank(number) ? null : number);
            user.setGender(ValidationUtil.isNullOrBlank(gender) ? null : gender);

            // DOB
            if (!ValidationUtil.isNullOrBlank(dobStr)) {
                user.setDob(Date.valueOf(dobStr));
            }

            user.setPassword(PasswordUtil.hash(password));

            // ✅ NEW: SET PROGRAM ID
            user.setProgramId(programId);

            // ───── SAVE USER ─────
            boolean success = userDAO.registerUser(user);

            if (!success) {
                req.setAttribute("error", "Registration failed.");
                req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
                return;
            }

            res.sendRedirect(req.getContextPath() + "/login?registered=true");

        } catch (NumberFormatException e) {

            req.setAttribute("error", "Invalid Program ID.");
            req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);

        } catch (Exception e) {

            e.printStackTrace(); // 🔥 IMPORTANT: check console
            req.setAttribute("error", "Server error occurred.");
            req.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(req, res);
        }
    }
}