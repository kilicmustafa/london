package com.rheinlandprivatschule.helper;

import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class MyDate {

    private static String processDate(Date code, int returnValue) {
        String s = code.toString();
        int index = s.indexOf("-");
        String yearStr = s.substring(0, index);
        s = s.substring(index + 1, s.length());
        index = s.indexOf("-");
        String monthStr = "" + Integer.parseInt(s.substring(0, index));
        String dayStr = s.substring(index + 1, s.length());
        if (MyDate.DAY == returnValue) {
            return dayStr;
        } else if (MyDate.MONTH == returnValue) {
            return monthStr;
        } else if (MyDate.YEAR == returnValue) {
            return yearStr;
        } else {
            return null;
        }
    }

    public static String getDay(Date paraDate) {
        return MyDate.processDate(paraDate, MyDate.DAY);
    }

    public static String getMonth(Date paraDate) {
        return MyDate.processDate(paraDate, MyDate.MONTH);
    }

    public static String getYear(Date paraDate) {
        return MyDate.processDate(paraDate, MyDate.YEAR);
    }

    public static Date getCurrentSQLDate() {
        Date d = new Date((new java.util.Date()).getTime());
        return d;
    }

    public static String formateDate(Date paraDate, int format, int systemConfig) {
        if (MyDate.ALPHANUMERIC == format) {
            return MyDate.getAlphaNumericDate(paraDate, systemConfig);
        } else if (MyDate.NUMERIC == format) {
            return MyDate.getNumericDate(paraDate, systemConfig);
        } else {
            return null;
        }
    }

    public static String getNumericDate(Date paraDate, int systemConfig) {

        String returnDate = "";
        String myDay = "";
        String myMonth = "";
        String myYear = MyDate.getYear(paraDate);

        int tempDay = Integer.parseInt(MyDate.getDay(paraDate));
        if (tempDay >= 1 && tempDay <= 9) {
            myDay = "0" + tempDay;
        } else {
            myDay = "" + tempDay;
        }
        int tempMonth = Integer.parseInt(MyDate.getMonth(paraDate));// pd.valueOfMonth(MyDate.getMonth(paraDate));
        if (tempMonth >= 1 && tempMonth <= 9) {
            myMonth = "0" + tempMonth;
        } else {
            myMonth = "" + tempMonth;
        }
        returnDate = myDay + "." + myMonth + "." + myYear;
        return returnDate;
    }

    public static String getNumberFromDate(Date paraDate, int systemConfig) {

        String returnDate = "";
        String myDay = "";
        String myMonth = "";
        String myYear = MyDate.getYear(paraDate);

        int tempDay = Integer.parseInt(MyDate.getDay(paraDate));
        if (tempDay >= 1 && tempDay <= 9) {
            myDay = "0" + tempDay;
        } else {
            myDay = "" + tempDay;
        }
        int tempMonth = Integer.parseInt(MyDate.getMonth(paraDate));// pd.valueOfMonth(MyDate.getMonth(paraDate));
        if (tempMonth >= 1 && tempMonth <= 9) {
            myMonth = "0" + tempMonth;
        } else {
            myMonth = "" + tempMonth;
        }
        returnDate = myDay + "" + myMonth + "" + myYear;
        return returnDate;
    }

    private static String getAlphaNumericDate(Date paraDate, int systemConfig) {
        String returnDate = "";
        int myDay = 0;
        String myMonth = "";
        String myYear = MyDate.getYear(paraDate);

        myDay = Integer.parseInt(MyDate.getDay(paraDate));
        String tempMonth = MyDate.getMonthName(Integer.parseInt(MyDate
                .getMonth(paraDate)), systemConfig);
        myMonth = tempMonth.substring(0, 3);

        if (myDay >= 1 && myDay <= 9) {
            returnDate = "0" + myDay + "." + myMonth + "." + myYear;
        } else {
            returnDate = myDay + "." + myMonth + "." + myYear;
        }
        return returnDate;
    }

    public static String getMonthNameSmall(int code, int systemConfig) {

        String resultMonth = "";
        if (systemConfig == MyDate.DEUTSCH) {
            if (code == 1) {
                resultMonth = "Jan";
            } else if (code == 2) {
                resultMonth = "Feb";
            } else if (code == 3) {
                resultMonth = "Mär";
            } else if (code == 4) {
                resultMonth = "Apr";
            } else if (code == 5) {
                resultMonth = "Mai";
            } else if (code == 6) {
                resultMonth = "Jun";
            } else if (code == 7) {
                resultMonth = "Jul";
            } else if (code == 8) {
                resultMonth = "Aug";
            } else if (code == 9) {
                resultMonth = "Sep";
            } else if (code == 10) {
                resultMonth = "Okt";
            } else if (code == 11) {
                resultMonth = "Nov";
            } else if (code == 12) {
                resultMonth = "Dez";
            }
        } else if (systemConfig == MyDate.ENGLISH) {
            if (code == 1) {
                resultMonth = "Jan";
            } else if (code == 2) {
                resultMonth = "Feb";
            } else if (code == 3) {
                resultMonth = "Mar";
            } else if (code == 4) {
                resultMonth = "Apr";
            } else if (code == 5) {
                resultMonth = "May";
            } else if (code == 6) {
                resultMonth = "Jun";
            } else if (code == 7) {
                resultMonth = "Jul";
            } else if (code == 8) {
                resultMonth = "Aug";
            } else if (code == 9) {
                resultMonth = "Sep";
            } else if (code == 10) {
                resultMonth = "Oct";
            } else if (code == 11) {
                resultMonth = "Nov";
            } else if (code == 12) {
                resultMonth = "Des";
            }
        }
        return resultMonth;
    }

    public static String getMonthName(int code, int systemConfig) {

        String resultMonth = "";
        if (systemConfig == MyDate.DEUTSCH) {
            if (code == 1) {
                resultMonth = "Januar";
            } else if (code == 2) {
                resultMonth = "Februar";
            } else if (code == 3) {
                resultMonth = "März";
            } else if (code == 4) {
                resultMonth = "April";
            } else if (code == 5) {
                resultMonth = "Mai";
            } else if (code == 6) {
                resultMonth = "Juni";
            } else if (code == 7) {
                resultMonth = "Juli";
            } else if (code == 8) {
                resultMonth = "August";
            } else if (code == 9) {
                resultMonth = "September";
            } else if (code == 10) {
                resultMonth = "Oktober";
            } else if (code == 11) {
                resultMonth = "November";
            } else if (code == 12) {
                resultMonth = "Dezember";
            }
        } else if (systemConfig == MyDate.ENGLISH) {
            if (code == 1) {
                resultMonth = "January";
            } else if (code == 2) {
                resultMonth = "February";
            } else if (code == 3) {
                resultMonth = "March";
            } else if (code == 4) {
                resultMonth = "April";
            } else if (code == 5) {
                resultMonth = "May";
            } else if (code == 6) {
                resultMonth = "June";
            } else if (code == 7) {
                resultMonth = "July";
            } else if (code == 8) {
                resultMonth = "August";
            } else if (code == 9) {
                resultMonth = "September";
            } else if (code == 10) {
                resultMonth = "October";
            } else if (code == 11) {
                resultMonth = "November";
            } else if (code == 12) {
                resultMonth = "Desember";
            }
        }
        return resultMonth;
    }

    public static int getMonthNumber(String code, int systemConfig) {
        int monthNumber = 0;
        if (systemConfig == MyDate.DEUTSCH) {
            if (code.equalsIgnoreCase("Januar")) {
                monthNumber = 1;
            } else if (code.equalsIgnoreCase("Februar")) {
                monthNumber = 2;
            } else if (code.equalsIgnoreCase("März")) {
                monthNumber = 3;
            } else if (code.equalsIgnoreCase("April")) {
                monthNumber = 4;
            } else if (code.equalsIgnoreCase("Mai")) {
                monthNumber = 5;
            } else if (code.equalsIgnoreCase("Juni")) {
                monthNumber = 6;
            } else if (code.equalsIgnoreCase("Juli")) {
                monthNumber = 7;
            } else if (code.equalsIgnoreCase("August")) {
                monthNumber = 8;
            } else if (code.equalsIgnoreCase("September")) {
                monthNumber = 9;
            } else if (code.equalsIgnoreCase("Oktober")) {
                monthNumber = 10;
            } else if (code.equalsIgnoreCase("November")) {
                monthNumber = 11;
            } else if (code.equalsIgnoreCase("Dezember")) {
                monthNumber = 12;
            }

        } else if (systemConfig == MyDate.ENGLISH) {
            if (code.equalsIgnoreCase("January")) {
                monthNumber = 1;
            } else if (code.equalsIgnoreCase("February")) {
                monthNumber = 2;
            } else if (code.equalsIgnoreCase("March")) {
                monthNumber = 3;
            } else if (code.equalsIgnoreCase("April")) {
                monthNumber = 4;
            } else if (code.equalsIgnoreCase("May")) {
                monthNumber = 5;
            } else if (code.equalsIgnoreCase("June")) {
                monthNumber = 6;
            } else if (code.equalsIgnoreCase("July")) {
                monthNumber = 7;
            } else if (code.equalsIgnoreCase("August")) {
                monthNumber = 8;
            } else if (code.equalsIgnoreCase("September")) {
                monthNumber = 9;
            } else if (code.equalsIgnoreCase("October")) {
                monthNumber = 10;
            } else if (code.equalsIgnoreCase("November")) {
                monthNumber = 11;
            } else if (code.equalsIgnoreCase("Desember")) {
                monthNumber = 12;
            }
        }
        return monthNumber;
    }

    public static int getDayNumber(String paraDay, int systemConfig) {
        String dayName = paraDay;
        int code = 0;
        try {
            if (systemConfig == MyDate.DEUTSCH || systemConfig == MyDate.ENGLISH) {
                if (dayName.equalsIgnoreCase("Mon") ||dayName.equalsIgnoreCase("Mon")) {
                    code = 1;
                } else if (dayName.equalsIgnoreCase("Die") || dayName.equalsIgnoreCase("Tue")) {
                    code = 2;
                } else if (dayName.equalsIgnoreCase("Mit") || dayName.equalsIgnoreCase("Wed")) {
                    code = 3;
                } else if (dayName.equalsIgnoreCase("Don") || dayName.equalsIgnoreCase("Thu")) {
                    code = 4;
                } else if (dayName.equalsIgnoreCase("Fre") || dayName.equalsIgnoreCase("Fri")) {
                    code = 5;
                } else if (dayName.equalsIgnoreCase("Sam") || dayName.equalsIgnoreCase("Sat")) {
                    code = 6;
                } else if (dayName.equalsIgnoreCase("Son") || dayName.equalsIgnoreCase("Sun")) {
                    code = 7;
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return code;
    }

    @SuppressWarnings("unused")
    public static String getDayName(int paraDay, int systemConfig) {
        String resultDay = "";
        try {
            if (systemConfig == MyDate.DEUTSCH) {
                if (paraDay == 1) {
                    resultDay = "Montag";
                } else if (paraDay == 2) {
                    resultDay = "Dienstag";
                } else if (paraDay == 3) {
                    resultDay = "Mittwoch";
                } else if (paraDay == 4) {
                    resultDay = "Donnerstag";
                } else if (paraDay == 5) {
                    resultDay = "Freitag";
                } else if (paraDay == 6) {
                    resultDay = "Samstag";
                } else if (paraDay == 7) {
                    resultDay = "Sonntag";
                }
            } else if (systemConfig == MyDate.ENGLISH) {
                if (paraDay == 1) {
                    resultDay = "Monday";
                } else if (paraDay == 2) {
                    resultDay = "Tuesday";
                } else if (paraDay == 3) {
                    resultDay = "Wednessday";
                } else if (paraDay == 4) {
                    resultDay = "Thursday";
                } else if (paraDay == 5) {
                    resultDay = "Friday";
                } else if (paraDay == 6) {
                    resultDay = "Saturday";
                } else if (paraDay == 7) {
                    resultDay = "Sunday";
                }
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return resultDay;
    }

    public static Date getSQLDateFromDashFormatString(String code,
                                                      int systemConfig) {

        String year = "";
        String month = "";
        String day = "";
        String tempDate;
        try {
            tempDate = code;
            year = tempDate.substring(0, tempDate.indexOf("-"));
            tempDate = tempDate.substring(tempDate.indexOf("-") + 1, tempDate
                    .length());
            month = tempDate.substring(0, tempDate.indexOf("-"));
            tempDate = tempDate.substring(tempDate.indexOf("-") + 1, tempDate
                    .length());
            day = tempDate;

            if (month.length() == 1) {
                month = "0" + month;
            }
            if (day.length() == 1) {
                day = "0" + day;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return MyDate.getSQLDateFromStrings(day, month, year, systemConfig);
    }

    public static Date getSQLDateFromStrings(String day, String month,
                                             String year, int systemConfig) {
        boolean ok = false;
        // Numeric Check
        try {
            Integer.parseInt(month);
            ok = true;
        } catch (Exception e) {
            ok = false;
        }

        Calendar gc1 = new GregorianCalendar();
        gc1.clear();
        try {
            gc1.set(Calendar.YEAR, (int) Integer.parseInt(year));
            if (ok) {
                gc1.set(Calendar.MONTH, (int) Integer.parseInt(month) - 1);
            } else {
                int tempMonth = getMonthNumber(month, systemConfig);
                gc1.set(Calendar.MONTH, tempMonth - 1);
            }
            gc1.set(Calendar.DATE, Integer.parseInt(day));
        } catch (Exception e) {
            setError(e.toString());
        }
        return new Date(gc1.getTime().getTime());
    }

    public static boolean isEqual(Date date1, Date date2) {
        boolean b = false;
        try {
            if (MyDate.getDay(date1).equalsIgnoreCase(MyDate.getDay(date2))
                    && MyDate.getMonth(date1).equalsIgnoreCase(
                    MyDate.getMonth(date2))
                    && MyDate.getYear(date1).equalsIgnoreCase(
                    MyDate.getYear(date2))) {
                b = true;
            }
        } catch (Exception e) {
            setError(e.toString());
        }
        return b;
    }

    private static Date makeWeek(int systemConfig, int returnType) {
        Calendar gc = new GregorianCalendar();
        String a = gc.getTime().toString();
        int value = MyDate.getDayNumber(a.substring(0, 3), systemConfig);
        int trackP = 0;
        int trackF = 0;
        if (value == 1) {
            trackP = 0;
            trackF = 6;
        } else if (value == 2) {
            trackP = -1;
            trackF = 5;
        } else if (value == 3) {
            trackP = -2;
            trackF = 4;
        } else if (value == 4) {
            trackP = -3;
            trackF = 3;
        } else if (value == 5) {
            trackP = -4;
            trackF = 2;
        } else if (value == 6) {
            trackP = -5;
            trackF = 1;
        } else if (value == 7) {
            trackP = -6;
            trackF = 0;
        }

        Calendar gc1 = new GregorianCalendar();
        gc1.setTime(getCurrentSQLDate());
        Calendar gc2 = new GregorianCalendar();
        gc2.setTime(getCurrentSQLDate());

        if (returnType == MyDate.FIRST) {
            gc1.add(Calendar.DATE, trackP);
            return new Date(gc1.getTime().getTime());
        } else if (returnType == MyDate.LAST) {
            gc2.add(Calendar.DATE, trackF);
            return new Date(gc2.getTime().getTime());
        } else {
            return null;
        }
    }

    public static Date getWeekFirstDate(int systemConfig) {

        return makeWeek(systemConfig, MyDate.FIRST);
    }

    public static Date getWeekLastDate(int systemConfig) {
        return makeWeek(systemConfig, MyDate.LAST);
    }

    private static Date makeWeek(Date code, int systemConfig, int returnType) {
        Calendar gc = new GregorianCalendar();
        gc.setTime(code);
        String a = gc.getTime().toString();
        int value = MyDate.getDayNumber(a.substring(0,3), systemConfig);
        int trackP = 0;
        int trackF = 0;

        if (value == 1) {
            trackP = 0;
            trackF = 6;
        } else if (value == 2) {
            trackP = -1;
            trackF = 5;
        } else if (value == 3) {
            trackP = -2;
            trackF = 4;
        } else if (value == 4) {
            trackP = -3;
            trackF = 3;
        } else if (value == 5) {
            trackP = -4;
            trackF = 2;
        } else if (value == 6) {
            trackP = -5;
            trackF = 1;
        } else if (value == 7) {
            trackP = -6;
            trackF = 0;
        }
        Calendar gc1 = new GregorianCalendar();
        gc1.setTime(code);
        Calendar gc2 = new GregorianCalendar();
        gc2.setTime(code);

        if (returnType == MyDate.FIRST) {
            gc1.add(Calendar.DATE, trackP);
            return new Date(gc1.getTime().getTime());
        } else if (returnType == MyDate.LAST) {
            gc2.add(Calendar.DATE, trackF);
            return new Date(gc2.getTime().getTime());
        } else {
            return null;
        }
    }

    public static Date getWeekFirstDate(Date planDate, int systemConfig) {
        return makeWeek(planDate, systemConfig,MyDate.FIRST);
    }

    public static Date getWeekLastDate(Date planDate, int systemConfig) {
        return makeWeek(planDate, systemConfig, MyDate.LAST);
    }

    private static Date makeWeekFuture(int week, int systemConfig,
                                       int returnType) {
        Date tempFirst = MyDate.getWeekFirstDate(systemConfig);
        Calendar gc1 = new GregorianCalendar();
        gc1.setTime(tempFirst);
        if (returnType == MyDate.FIRST) {
            gc1.add(Calendar.DATE, week * 7);
            return new Date(gc1.getTime().getTime());
        } else if (returnType == MyDate.LAST) {
            gc1.add(Calendar.DATE, week * 7);
            gc1.add(Calendar.DATE, 6);
            return new Date(gc1.getTime().getTime());
        } else {
            return null;
        }
    }

    public static Date getWeekFirstDateFuture(int week, int systemConfig) {
        return MyDate.makeWeekFuture(week, systemConfig, MyDate.FIRST);
    }

    public static Date getWeekLastDateFuture(int week, int systemConfig) {
        return MyDate.makeWeekFuture(week, systemConfig,MyDate.LAST);
    }

    public static String getDateForHint(Date date,int addition,int systemConfig){
        try{
            Calendar gc1 = new GregorianCalendar();
            gc1.setTime(date);
            gc1.add(Calendar.DATE,addition);
            String dateString=formateDate(new Date(gc1.getTime().getTime()),NUMERIC,systemConfig);
            return dateString.substring(0,dateString.length()-5);
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }


    public static Date getFirstCurrentMonthDate(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-1));
            calendar.set(Calendar.DAY_OF_MONTH,1);
            calendar.set(Calendar.YEAR,Integer.parseInt(getYear(currentDate)));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastCurrentMonthDate(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));

            calendar.set(Calendar.MONTH,(currentMonth-1));
            calendar.set(Calendar.DATE,1);
            calendar.add(Calendar.MONTH,1);
            calendar.add(Calendar.DAY_OF_MONTH,-1);
            calendar.set(Calendar.YEAR,Integer.parseInt(getYear(currentDate)));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getFirstMonthDate(String month,String year,int systemConfig){
        try{
            Calendar calendar = new GregorianCalendar();
            Date processDate=getSQLDateFromStrings("01", month, year, systemConfig);
            int processMonth=Integer.parseInt(getMonth(processDate));
            calendar.set(Calendar.MONTH,(processMonth-1));
            calendar.set(Calendar.DAY_OF_MONTH,1);
            calendar.set(Calendar.YEAR,Integer.parseInt(getYear(processDate)));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonthDate(String month,String year,int systemConfig){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getSQLDateFromStrings("01", month, year, systemConfig);
            int processMonth=Integer.parseInt(getMonth(currentDate));

            calendar.set(Calendar.MONTH,(processMonth-1));
            calendar.set(Calendar.DATE,1);
            calendar.add(Calendar.MONTH,1);
            calendar.add(Calendar.DAY_OF_MONTH,-1);
            calendar.set(Calendar.YEAR,Integer.parseInt(getYear(currentDate)));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static boolean isHoliday(Date date,int systemConfig){
        boolean result = false;
        try{
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            String tempTime = calendar.getTime().toString();
            String dayName = tempTime.substring(0,3);
            int dayNumber = getDayNumber(dayName,systemConfig);
            if(dayNumber == 6 || dayNumber == 7){
                result = true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return result;
    }

    public static boolean isSelectedDatesCorrect(Date firstDate,Date lastDate){
        boolean flag = false;
        try{
            if(lastDate.after(firstDate)){
                flag = true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return flag;
    }

    public static boolean isLeapYear(int year){
        boolean flag = false;
        try{
            GregorianCalendar calendar = new GregorianCalendar();
            if(calendar.isLeapYear(year)){
                flag = true;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return flag;
    }

    public static int countDaysWithSupposition(Date firstDate,Date lastDate,int supposeMonthDays){
        int days = 0;
        try{
            boolean flag = true;
            boolean flagControl = false;
            int leapYearCheck = 0;

            Calendar calendar = new GregorianCalendar();
            calendar.setTime(firstDate);
            Date conditionDate = new Date(calendar.getTime().getTime());
            int windCurrent = Integer.parseInt(MyDate.getDay(conditionDate));
            int februaryCount = 0;
            while(flag){
                if(windCurrent <= 30){
                    if(Integer.parseInt(MyDate.getMonth(conditionDate)) == 2){
                        februaryCount++;
                        if(leapYearCheck == 0){
                            leapYearCheck =Integer.parseInt(MyDate.getYear(conditionDate));
                        }
                    }
                    days++;
                }
                calendar.add(Calendar.DATE,1);
                conditionDate = new Date(calendar.getTime().getTime());
                windCurrent = Integer.parseInt(MyDate.getDay(conditionDate));
                if(flagControl){
                    flag = false;
                }
                if(MyDate.isEqual(conditionDate,lastDate)){
                    flagControl = true;
                }
            }
            if(februaryCount == 28){
                if(!MyDate.isLeapYear(leapYearCheck)){
                    days++;
                    days++;
                }
            }else if(februaryCount == 29){
                days++;
            }
        }catch(Exception e){
            setError(e.toString());
        }
        return days;
    }


    public static Date getLastMonth(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-1));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getFutureMonth3rd(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth+1));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth1st(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-2));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth2nd(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-3));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth3rd(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-4));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth4th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-5));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth5th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-6));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth6th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-7));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth7th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-8));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth8th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-9));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth9th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-10));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth10th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-11));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    public static Date getLastMonth11th(){
        try{
            Calendar calendar = new GregorianCalendar();
            Date currentDate=getCurrentSQLDate();
            int currentMonth=Integer.parseInt(getMonth(currentDate));
            calendar.set(Calendar.MONTH,(currentMonth-12));
            Date result=new Date(calendar.getTime().getTime());
            return result;
        }catch(Exception e){
            setError(e.toString());
            return null;
        }
    }

    private static void setError(String errorPara) {
        error = errorPara;
    }

    public static String getError() {
        String returnError = error;
        return returnError;
    }

    // Class Variables
    private static String error;
    public static int ALPHANUMERIC = 1;
    public static int NUMERIC = 2;
    public static int DAY = 1;
    public static int MONTH = 2;
    public static int YEAR = 3;
    public static int DEUTSCH = 1;
    public static int ENGLISH = 2;
    public static int FIRST = 1;
    public static int LAST = 2;
}
