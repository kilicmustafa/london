package com.rheinlandprivatschule.helper;

public class PasswordManager {

    public static boolean isPasswordSecure(String password){
        boolean result = false;
        try{
            if(password != null){
                boolean properLength = hasProperLength(password);
                if(properLength){
                    boolean weakStrength = isWeakStrength(password);
                    if(weakStrength){
                        boolean normalStrength = isNormalStrength(password);
                        if(normalStrength){
                            boolean strongStrength = isStrongStrength(password);
                            if(strongStrength){
                                result = true;
                            }
                        }
                    }
                }
            }
        }catch(Exception e){
        }
        return result;
    }

    private static boolean hasProperLength(String password){
        boolean result = false;
        try{
            if(password.length() >= PASSWORD_LENGTH){
                result = true;
            }
        }catch(Exception e){
        }
        return result;
    }

    private static boolean isWeakStrength(String password){
        boolean result = false;
        try{
            char[] passwordArray = password.toCharArray();
            int passwordLength = passwordArray.length;
            for(int i=0; i<passwordLength; i++){
                int code = (int)passwordArray[i];
                if(code >= START_LOWER && code <= END_LOWER){
                    result = true;
                }
            }
        }catch(Exception e){
        }
        return result;
    }

    private static boolean isNormalStrength(String password){
        boolean result = false;
        try{
            char[] passwordArray = password.toCharArray();
            int passwordLength = passwordArray.length;
            for(int i=0; i<passwordLength; i++){
                int code = (int)passwordArray[i];
                if(code >= START_UPPER && code <= END_UPPER){
                    result = true;
                }
            }
        }catch(Exception e){
        }
        return result;
    }

    private static boolean isStrongStrength(String password){
        boolean result = false;
        try{
            char[] passwordArray = password.toCharArray();
            int passwordLength = passwordArray.length;
            for(int i=0; i<passwordLength; i++){
                int code = (int)passwordArray[i];
                if(code >= START_NUMBER && code <= END_NUMBER){
                    result = true;
                }
            }
        }catch(Exception e){
        }
        return result;
    }

    // Class Variables
    private static int PASSWORD_LENGTH = 7;

    private static int START_LOWER = 97;
    private static int END_LOWER = 122;

    private static int START_UPPER = 65;
    private static int END_UPPER = 90;

    private static int START_NUMBER = 48;
    private static int END_NUMBER = 57;
}
