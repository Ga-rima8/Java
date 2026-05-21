package com.java_web_app.utils;

import java.util.regex.Pattern;

/**
 * Utility class for validation and sanitization.
 */
public class ValidationUtil {

    private static final Pattern EMAIL_RE =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final Pattern PHONE_RE =
            Pattern.compile("^[+]?[0-9]{7,15}$");

    private static final Pattern USERNAME_RE =
            Pattern.compile("^[A-Za-z0-9_]{3,30}$");

    public static boolean isBlank(String s) {

        return s == null || s.trim().isEmpty();
    }

    public static boolean isNullOrBlank(String s) {

        return s == null || s.trim().isEmpty();
    }

    /**
     * Removes leading and trailing spaces safely.
     */
    public static String clean(String s) {

        if (s == null) {
            return "";
        }

        return s.trim();
    }

    /**
     * Sanitizes HTML special characters.
     */
    public static String sanitize(String s) {

        if (s == null) {
            return "";
        }

        return s.trim()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }


    public static boolean isValidEmail(String s) {

        return s != null
                && EMAIL_RE.matcher(s.trim()).matches();
    }


    public static boolean isValidPhone(String s) {

        return s == null
                || s.trim().isEmpty()
                || PHONE_RE.matcher(s.trim()).matches();
    }


    public static boolean isValidUsername(String s) {

        return s != null
                && USERNAME_RE.matcher(s.trim()).matches();
    }

    /**
     * Strong password validation.
     * Minimum 6 characters.
     */
    public static boolean isStrongPassword(String s) {

        return s != null
                && s.length() >= 6;
    }

    /**
     * Alias for compatibility with old code.
     */
    public static boolean isValidPassword(String s) {

        return isStrongPassword(s);
    }

    private ValidationUtil() {

    }
}