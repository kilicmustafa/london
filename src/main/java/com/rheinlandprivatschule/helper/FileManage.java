package com.rheinlandprivatschule.helper;


import com.rheinlandprivatschule.repository.PreviligeManager;

public class FileManage {

    public String properName(String code) {
        String b = "";
        try {
            char[] ch = code.toCharArray();
            for (int i = 0; i < ch.length; i++) {
                String temp = "" + ch[i];
                if (temp.equalsIgnoreCase("ä")) {
                    b = b + "ae";
                } else if (temp.equalsIgnoreCase("ü")) {
                    b = b + "ue";
                } else if (temp.equalsIgnoreCase("ö")) {
                    b = b + "oe";
                } else if (temp.equalsIgnoreCase("ß")) {
                    b = b + "ss";
                } else {
                    b = b + ch[i];
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    public boolean canWorkWithFilesSystem(int loginUser){
        boolean flag= PreviligeManager.isSystemUserHasThisPrivilage(loginUser,"12.1");
        if(flag){
            return true;
        }else{
            setError("Ihnen wird nicht erlaubt, das zu tun");
            return false;
        }
    }

    /* Methods Related To Every Method */
    private void setError(String errorPara) {
        this.error=errorPara;
    }

    public String getError() {
        return error;
    }

    public Object replaceNull(Object o) {
        if (o == null) {
            return null;
        } else {
            return "'" + o + "'";
        }
    }

    /* End Methods Related To Every Method */

    //Instance Variables
    private String error;
}
