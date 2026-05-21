package com.java_web_app.utils;

import org.mindrot.jbcrypt.BCrypt;

/** BCrypt password hashing helper. */
public class PasswordUtil {

    public static String hash(String plain) {
        return BCrypt.hashpw(plain, BCrypt.gensalt(12));
    }

    public static boolean verify(String plain, String hashed) {
        if (plain == null || hashed == null) return false;
        return BCrypt.checkpw(plain, hashed);
    }

    private PasswordUtil() {}
}