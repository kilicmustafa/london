package com.rheinlandprivatschule.helper;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

public class MyCurrency {

    private String getDisplayString;

    public static String getCountry(){
        return LOCALE.getDisplayCountry();
    }

    public static String getCurrencySymbol(){
        return NumberFormat.getCurrencyInstance(LOCALE).getCurrency().getSymbol();
    }

    public static String getCurrencyCode(){
        return NumberFormat.getCurrencyInstance(LOCALE).getCurrency().getCurrencyCode();
    }

    public static double getDoubleValue(String input){
        double result = 0.00;
        try{
            if(MyCurrency.getDecimalCharacter(input)==MyCurrency.COMMA){
                result=NumberFormat.getInstance(LOCALE).parse(input).doubleValue();
            }else if(MyCurrency.getDecimalCharacter(input)==MyCurrency.DOT){
                result=NumberFormat.getInstance(Locale.US).parse(input).doubleValue();
            }else if(MyCurrency.getDecimalCharacter(input)==0){
                result=Double.parseDouble(input);
            }
        }catch(Exception e){
        }
        return result;
    }

    public static String getDisplayString(double input){
        NumberFormat f = NumberFormat.getInstance(LOCALE);
        ((DecimalFormat) f).setDecimalSeparatorAlwaysShown(true);
        ((DecimalFormat) f).applyPattern("###,###.00");
        return f.format(input);
    }

    public static String getDisplayString(int input){
        NumberFormat f = NumberFormat.getInstance(LOCALE);
        ((DecimalFormat) f).setDecimalSeparatorAlwaysShown(true);
        ((DecimalFormat) f).applyPattern("###,###.00");
        return f.format(input);
    }

    private static int getDecimalCharacter(String para){
        int result=0;
        try{
            if(para!=null){
                int cIndex=para.lastIndexOf(",");
                int dIndex=para.lastIndexOf(".");
                if(cIndex>dIndex){
                    result=MyCurrency.COMMA;
                }else if(dIndex>cIndex){
                    result=MyCurrency.DOT;
                }else{
                    result=0;
                }
            }
        }catch(Exception e){
        }
        return result;
    }

    // Class Variables
    private static Locale LOCALE=Locale.GERMANY;
    private static int COMMA=1;
    private static int DOT=2;


}
