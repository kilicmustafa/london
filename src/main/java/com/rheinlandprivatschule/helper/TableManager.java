package com.rheinlandprivatschule.helper;

import com.rheinlandprivatschule.model.Table;

import java.util.Hashtable;

public class TableManager {

    private static void tableConstructor(){
        //Call Tables Constructor//

        //complaints//
        rps_complaints();
        rps_complaintstudent();

        //inventory//
        rps_inventory();
        rps_inventorycat();

        //Start Sch�ler//
        rps_user();
        rps_onlinestudent();
        rps_vertraglist();
        rps_bildlist();
        rps_placephoto();
        rps_sysuserbild();
        rps_coursevertrag();
        rps_residencevertrag();
        rps_residentvertrag();
        //End Sch�ler//

        //Start SystemUser//
        rps_systemuser();
        rps_usercat();
        rps_addressbook();
        rps_userplaces();
        rps_usertype();
        rps_privatremarks();
        rps_teacherhandbook();
        rps_employeehandbook();
        rps_login();
        rps_privatelohn();
        rps_grouplohn();
        //End SystemUser//

        //Start Courses//
        rps_courses();
        rps_module();
        //End Courses//

        //Start CourseRegistration//
        rps_courseregistration();
        rps_tran();
        rps_tran_xtra();
        rps_xtracosts();
        rps_int_tran();
        rps_integrationcost();
        rps_nullgebuhr();
        rps_printregrecord();
        rps_cer();
        rps_cernp();
        rps_mulcer();
        rps_mulcernp();
        rps_eunterricht();
        rps_eunterbalance();
        rps_eunterstudenttran();
        rps_eunterstudentstatus();
        rps_kasse();
        //End CourseRegistration//

        //Start StundenPlan//
        rps_stundenplan();
        //rps_timetable();
        rps_anwesen();
        rps_stundendetail();
        rps_unterrichtstunden();
        rps_employeestunden();
        //End StundenPlan//

        //Start Werbung AND Insurance//
        rps_werbung();
        rps_werbungrelated();
        rps_adminwerbung();
        rps_group();
        rps_grouprelated();
        rps_admingroup();
        rps_messe();
        rps_messestudent();
        rps_consultant();
        rps_consultantstudent();
        rps_insurance();
        rps_insurancerelated();
        rps_agentstudent();
        rps_groupstudent();
        rps_emailtext();
        //End Werbung//

        //Start ExpenseCategory//
        rps_expensecategory();
        rps_expensecategorycity();
        //End ExpenseCategory//

        rps_inventorcategory();
        rps_inventorcategorycity();

        //Start Mahnung//
        rps_mahnunginterval();
        rps_mahnung();
        rps_mahndatum();
        //End Mahnung//

        //Start Befugnis//
        rps_userprevilige();
        rps_allowedbefugmis();
        //End Befugnis//

        //Start Books//
        rps_books();
        rps_booklimit();
        rps_bookstock();
        rps_booksold();
        rps_bookrechnung();
        //End Books//

        //Start Ausgabe//
        rps_expcategory();
        rps_expenditure();
        //End Ausgabe//

        //Start Vocabulary//
        rps_vocabal();
        rps_languages();
        rps_lecture();
        //End Vocabulary//

        //Start Place//
        rps_place();
        //End Place//

        //Start Pictures Slideshow//
        rps_picture();
        rps_slideshow();
        //End Pictures Slideshow//

        // Start DSH Termin//
        rps_dshtermin();
        // End DSH Termin//

        // Start Residence//
        rps_residenceownner();
        rps_resident();
        rps_elecreading();
        rps_residence();
        rps_residencemieten();
        rps_rentoutgoing();
        rps_rentincoming();
        rps_rentpaymode();
        // End Residence//


        //Start Countries//
        rps_countries();
        // End Countries//

        //Start User Identity//
        rps_useridentity();
        //End User identity//

        //Set Constructor Flag//
        constructorFlag=true;
    }

    //Construct Tables//

    private static void rps_complaintstudent(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_COMPLAINTSTUDENT);
        table.addColumn("comstudentID");
        table.addColumn("studentID");
        table.addColumn("complaintID");
        table.addColumn("remarks");
        table.addColumn("adminID");
        table.addColumn("placeID");
        table.addColumn("complaintDate");
        table.addColumn("status");

        tablesList.put(TableManager.RPS_COMPLAINTSTUDENT,table);
    }

    private static void rps_complaints(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_COMPLAINTS);
        table.addColumn("complaintID");
        table.addColumn("complaintName");
        table.addColumn("status");

        tablesList.put(TableManager.RPS_COMPLAINTS,table);
    }

    private static void rps_inventory(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_INVENTORY);
        table.addColumn("inventoryID");
        table.addColumn("categoryID");
        table.addColumn("inventoryName");
        table.addColumn("remarks");
        table.addColumn("adminID");
        table.addColumn("placeID");
        table.addColumn("inventoryDate");
        table.addColumn("status");

        tablesList.put(TableManager.RPS_INVENTORY,table);
    }

    private static void rps_inventorycat(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_INVENTORYCAT);
        table.addColumn("categoryID");
        table.addColumn("categoryName");
        table.addColumn("status");

        tablesList.put(TableManager.RPS_INVENTORYCAT,table);
    }

    private static void rps_user(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_USER);
        table.addColumn("userID");
        table.addColumn("userFirstName");
        table.addColumn("userLastName");
        table.addColumn("userBirthDate");
        table.addColumn("userGender");
        table.addColumn("userBirthPlace");
        table.addColumn("userNationality");
        table.addColumn("userAddress");
        table.addColumn("userPostCode");
        table.addColumn("userCity");
        table.addColumn("userCountry");
        table.addColumn("userHomePhone");
        table.addColumn("userMobilePhone");
        table.addColumn("userFax");
        table.addColumn("userEmail");
        table.addColumn("userLoginName");
        table.addColumn("userPassword");
        table.addColumn("userRemark");
        table.addColumn("userActive");
        table.addColumn("userCO");
        table.addColumn("userCountryID");
        table.addColumn("userHomeCode");
        table.addColumn("userHomeRegion");
        table.addColumn("userMobileCode");
        table.addColumn("userMobileRegion");
        table.addColumn("userFaxCode");
        table.addColumn("userFaxRegion");
        table.addColumn("userBamfNumber");
        table.addColumn("userBamfChoice");
        table.addColumn("userHours");
        table.addColumn("userLastVisit");
        table.addColumn("userBamfNrSchool");
        table.addColumn("userAcademicPoints");
        table.addColumn("userSchoolingYears");
        table.addColumn("userIntTest");
        table.addColumn("userIntTestCheck");
        table.addColumn("userProficency");
        table.addColumn("userSponsorShip");
        table.addColumn("userIdentityID");
        table.addColumn("userCostSharing");
        table.addColumn("userClassification");
        table.addColumn("userConclusion");
        table.addColumn("userConcCourse");
        table.addColumn("userRegDate");
        table.addColumn("userVerifiedNumber");
        table.addColumn("userGradingDate");
        table.addColumn("userModuleNr");
        table.addColumn("userPassport");
        table.addColumn("userFahrtKosten");
        table.addColumn("freigabeStatus");
        table.addColumn("freigabeDate");

        tablesList.put(TableManager.RPS_USER,table);
    }

    private static void rps_onlinestudent(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_ONLINESTUDENT);
        table.addColumn("userID");
        tablesList.put(TableManager.RPS_ONLINESTUDENT,table);
    }

    private static void rps_systemuser(){
        //Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_SYSTEMUSER);
        table.addColumn("userID");
        table.addColumn("userFirstName");
        table.addColumn("userLastName");
        table.addColumn("userBirthDate");
        table.addColumn("userGender");
        table.addColumn("userBirthPlace");
        table.addColumn("userNationality");
        table.addColumn("userAddress");
        table.addColumn("userPostCode");
        table.addColumn("userCity");
        table.addColumn("userCountry");
        table.addColumn("userHomePhone");
        table.addColumn("userMobilePhone");
        table.addColumn("userFax");
        table.addColumn("userEmail");
        table.addColumn("userAccountNo");
        table.addColumn("userBLZ");
        table.addColumn("userBankName");
        table.addColumn("userType");
        table.addColumn("userLoginName");
        table.addColumn("userPassword");
        table.addColumn("userRemark");
        table.addColumn("stdLohn");
        table.addColumn("userCompany");
        table.addColumn("userBamfNumber");
        tablesList.put(TableManager.RPS_SYSTEMUSER,table);
    }

    private static void rps_usercat(){
        //Primary Key catID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_SYSTEMUSERCAT);
        table.addColumn("catID");
        table.addColumn("catname");
        table.addColumn("catowner");
        tablesList.put(TableManager.RPS_SYSTEMUSERCAT,table);
    }

    private static void rps_addressbook(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_ADDRESSBOOK);
        table.addColumn("userID");
        table.addColumn("catID");
        tablesList.put(TableManager.RPS_ADDRESSBOOK,table);
    }

    private static void rps_userplaces(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_SYSTEMUSERPLACES);
        table.addColumn("userID");
        table.addColumn("placeID");
        tablesList.put(TableManager.RPS_SYSTEMUSERPLACES,table);
    }

    private static void rps_usertype(){
        //Primary Key typeID//
        Table table=new Table(TableManager.RPS_SYSTEMUSERTYPE);
        table.addColumn("typeID");
        table.addColumn("typeName");
        tablesList.put(TableManager.RPS_SYSTEMUSERTYPE,table);
    }

    private static void rps_privatremarks(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_PRIVATREMARKS);
        table.addColumn("userID");
        table.addColumn("remarks");
        tablesList.put(TableManager.RPS_PRIVATREMARKS,table);
    }

    private static void rps_teacherhandbook(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_TEACHERHANDBOOK);
        table.addColumn("userID");
        table.addColumn("remarks");
        tablesList.put(TableManager.RPS_TEACHERHANDBOOK,table);
    }

    private static void rps_employeehandbook(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_EMPLOYEEHANDBOOK);
        table.addColumn("userID");
        table.addColumn("remarks");
        tablesList.put(TableManager.RPS_EMPLOYEEHANDBOOK,table);
    }

    private static void rps_login(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_LOGIN);
        table.addColumn("userID");
        table.addColumn("userlogindate");
        table.addColumn("userlogintime");
        table.addColumn("userStatus");
        table.addColumn("userloggedcity");
        tablesList.put(TableManager.RPS_LOGIN,table);
    }

    private static void rps_privatelohn(){
        //Primary Key userID,startDate,endDate//
        Table table=new Table(TableManager.RPS_PRIVATELOHN);
        table.addColumn("userID");
        table.addColumn("startDate");
        table.addColumn("endDate");
        table.addColumn("lohn");
        tablesList.put(TableManager.RPS_PRIVATELOHN,table);
    }

    private static void rps_grouplohn(){
        //Primary Key userID,startDate,endDate//
        Table table=new Table(TableManager.RPS_GROUPLOHN);
        table.addColumn("userID");
        table.addColumn("startDate");
        table.addColumn("endDate");
        table.addColumn("lohn");
        tablesList.put(TableManager.RPS_GROUPLOHN,table);
    }

    private static void rps_courses(){
        //Primary Key courseID//
        //Auto No courseID//
        Table table=new Table(TableManager.RPS_COURSES);
        table.addColumn("courseID");
        table.addColumn("courseName");
        table.addColumn("courseDesc");
        table.addColumn("courseStartDate");
        table.addColumn("courseEndDate");
        table.addColumn("courseFee");
        table.addColumn("coursePlace");
        table.addColumn("courseTiming");
        table.addColumn("courseStrength");
        table.addColumn("courseHours");
        table.addColumn("courseType");
        table.addColumn("courseTH");
        table.addColumn("courseDuration");
        table.addColumn("courseBamfNr");
        table.addColumn("courseDailyHrs");
        table.addColumn("remarks");
        table.addColumn("courseInit");
        tablesList.put(TableManager.RPS_COURSES,table);
    }

    private static void rps_module(){
        //Primary Key courseID//
        //Auto No courseID//
        Table table=new Table(TableManager.RPS_MODULE);
        table.addColumn("moduleID");
        table.addColumn("moduleName");
        tablesList.put(TableManager.RPS_MODULE,table);
    }

    private static void rps_courseregistration(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_COURSEREGISTRATION);
        table.addColumn("courseID");
        table.addColumn("studentID");
        table.addColumn("registrationDate");
        table.addColumn("registrationType");
        table.addColumn("courseBalance");
        table.addColumn("courseFee");
        table.addColumn("firstPayDate");
        table.addColumn("registrationStatus");
        tablesList.put(TableManager.RPS_COURSEREGISTRATION,table);
    }

    private static void rps_vertraglist(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_VERTRAGLIST);
        table.addColumn("studentID");
        table.addColumn("vertrag");
        tablesList.put(TableManager.RPS_VERTRAGLIST,table);
    }

    private static void rps_bildlist(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_BILDLIST);
        table.addColumn("studentID");
        table.addColumn("bild");
        table.addColumn("bildID");
        tablesList.put(TableManager.RPS_BILDLIST,table);
    }

    private static void rps_placephoto(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_PLACEPHOTO);
        table.addColumn("placeID");
        table.addColumn("bild");
        table.addColumn("bildID");
        tablesList.put(TableManager.RPS_PLACEPHOTO,table);
    }

    private static void rps_sysuserbild(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_SYSUSERBILD);
        table.addColumn("userID");
        table.addColumn("bild");
        tablesList.put(TableManager.RPS_SYSUSERBILD,table);
    }

    private static void rps_coursevertrag(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_COURSEVERTRAG);
        table.addColumn("courseID");
        table.addColumn("vertrag");
        tablesList.put(TableManager.RPS_COURSEVERTRAG,table);
    }

    private static void rps_residencevertrag(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_RESIDENCEVERTRAG);
        table.addColumn("residenceID");
        table.addColumn("vertrag");
        tablesList.put(TableManager.RPS_RESIDENCEVERTRAG,table);
    }

    private static void rps_residentvertrag(){
        //Primary Key courseID,userID//
        Table table=new Table(TableManager.RPS_RESIDENTVERTRAG);
        table.addColumn("residentID");
        table.addColumn("vertrag");
        tablesList.put(TableManager.RPS_RESIDENTVERTRAG,table);
    }

    private static void rps_tran(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_TRAN);
        table.addColumn("tranNo");
        table.addColumn("tranPay");
        table.addColumn("tranDate");
        table.addColumn("tranType");
        table.addColumn("tranStudent");
        table.addColumn("tranCourse");
        table.addColumn("tranPlace");
        table.addColumn("tranAdmin");
        table.addColumn("initialTest");
        tablesList.put(TableManager.RPS_TRAN,table);
    }

    private static void rps_kasse(){
        //Primary Key kasseNo//
        Table table=new Table(TableManager.RPS_KASSE);
        table.addColumn("kasseNo");
        table.addColumn("kassePay");
        table.addColumn("kasseDate");
        table.addColumn("kassePlace");
        table.addColumn("kasseAdmin");
        tablesList.put(TableManager.RPS_KASSE,table);
    }

    private static void rps_nullgebuhr(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_NULLGEBUHR);
        table.addColumn("tranNo");
        table.addColumn("tranPay");
        table.addColumn("tranDate");
        table.addColumn("tranType");
        table.addColumn("tranStudent");
        table.addColumn("tranCourse");
        table.addColumn("tranPlace");
        table.addColumn("tranAdmin");
        tablesList.put(TableManager.RPS_NULLGEBUHR,table);
    }

    private static void rps_printregrecord(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_PRINTREGRECORD);
        table.addColumn("tranNo");
        table.addColumn("tranPay");
        table.addColumn("tranDate");
        table.addColumn("tranType");
        table.addColumn("tranStudent");
        table.addColumn("tranCourse");
        table.addColumn("tranPlace");
        table.addColumn("tranAdmin");
        tablesList.put(TableManager.RPS_PRINTREGRECORD,table);
    }

    private static void rps_tran_xtra(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_TRAN_XTRA);
        table.addColumn("tranNo");
        table.addColumn("costID");
        table.addColumn("tranPay");
        table.addColumn("tranPayType");
        table.addColumn("tranDate");
        table.addColumn("tranBalance");
        table.addColumn("tranStudent");
        table.addColumn("tranPlace");
        table.addColumn("tranAdmin");
        tablesList.put(TableManager.RPS_TRAN_XTRA,table);
    }

    private static void rps_xtracosts(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_XTRACOSTS);
        table.addColumn("costID");
        table.addColumn("userID");
        table.addColumn("costDesc");
        table.addColumn("actualFee");
        table.addColumn("registrationDate");
        tablesList.put(TableManager.RPS_XTRACOSTS,table);
    }

    private static void rps_int_tran(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_INT_TRAN);
        table.addColumn("tranNo");
        table.addColumn("costID");
        table.addColumn("tranPay");
        table.addColumn("tranPayType");
        table.addColumn("tranDate");
        table.addColumn("tranBalance");
        table.addColumn("tranStudent");
        table.addColumn("tranPlace");
        table.addColumn("tranAdmin");
        tablesList.put(TableManager.RPS_INT_TRAN,table);
    }

    private static void rps_integrationcost(){
        //Primary Key tranNo//
        Table table=new Table(TableManager.RPS_INTEGRATIONCOST);
        table.addColumn("costID");
        table.addColumn("userID");
        table.addColumn("costDesc");
        table.addColumn("actualFee");
        table.addColumn("registrationDate");
        tablesList.put(TableManager.RPS_INTEGRATIONCOST,table);
    }

    private static void rps_cer(){
        //Primary Key cerID//
        Table table=new Table(TableManager.RPS_CERTIFICATE);
        table.addColumn("cerID");
        table.addColumn("sid");
        table.addColumn("cid");

        table.addColumn("hv");
        table.addColumn("tp");
        table.addColumn("lv");
        table.addColumn("ws");
        table.addColumn("mp");

        table.addColumn("std");
        table.addColumn("per");
        table.addColumn("d");
        table.addColumn("admin");
        tablesList.put(TableManager.RPS_CERTIFICATE,table);
    }

    private static void rps_cernp(){
        //Primary Key cerID//
        Table table=new Table(TableManager.RPS_CERTIFICATENP);
        table.addColumn("cerID");
        table.addColumn("sid");
        table.addColumn("cid");

        table.addColumn("hv");
        table.addColumn("tp");
        table.addColumn("lv");
        table.addColumn("ws");
        table.addColumn("mp");

        table.addColumn("std");
        table.addColumn("per");
        table.addColumn("d");
        table.addColumn("admin");
        tablesList.put(TableManager.RPS_CERTIFICATENP,table);
    }

    private static void rps_mulcer(){
        //Primary Key cerID//
        Table table=new Table(TableManager.RPS_MULCERTIFICATE);
        table.addColumn("cerID");
        table.addColumn("sid");
        table.addColumn("cid");
        tablesList.put(TableManager.RPS_MULCERTIFICATE,table);
    }

    private static void rps_mulcernp(){
        //Primary Key cerID//
        Table table=new Table(TableManager.RPS_MULCERTIFICATENP);
        table.addColumn("cerID");
        table.addColumn("sid");
        table.addColumn("cid");
        tablesList.put(TableManager.RPS_MULCERTIFICATENP,table);
    }

    private static void rps_eunterricht(){
        //Primary Key eunterID//
        Table table=new Table(TableManager.RPS_EUNTERRICHT);
        table.addColumn("eunterID");
        table.addColumn("studentID");
        table.addColumn("courseName");
        table.addColumn("teacherID");
        table.addColumn("courseDate");
        table.addColumn("courseTime");
        table.addColumn("courseFee");
        table.addColumn("coursePlace");
        tablesList.put(TableManager.RPS_EUNTERRICHT,table);
    }

    private static void rps_eunterbalance(){
        //Primary Key studentID//
        Table table=new Table(TableManager.RPS_EUNTERBALANCE);
        table.addColumn("studentID");
        table.addColumn("balance");
        tablesList.put(TableManager.RPS_EUNTERBALANCE,table);
    }

    private static void rps_eunterstudenttran(){
        //Primary Key studentID//
        Table table=new Table(TableManager.RPS_EUNTERSTUDENTTRAN);
        table.addColumn("studentID");
        table.addColumn("tranID");
        tablesList.put(TableManager.RPS_EUNTERSTUDENTTRAN,table);
    }

    private static void rps_eunterstudentstatus(){
        //Primary Key studentID//
        Table table=new Table(TableManager.RPS_EUNTERSTUDENTSTATUS);
        table.addColumn("studentID");
        table.addColumn("studentStatus");
        tablesList.put(TableManager.RPS_EUNTERSTUDENTSTATUS,table);
    }

    private static void rps_stundenplan(){
        //Primary Key stdDate,stdCID//
        Table table=new Table(TableManager.RPS_STUNDENPLAN);
        table.addColumn("stdDate");
        table.addColumn("stdCID");
        table.addColumn("stdTID");
        table.addColumn("stdSTD");
        table.addColumn("stdStatus");
        table.addColumn("teaSTD");
        table.addColumn("descr");
        tablesList.put(TableManager.RPS_STUNDENPLAN,table);
    }

	/*private static void rps_timetable(){
		//Primary Key teacherID,timing,d//
		Table table=new Table(TableManager.RPS_TIMETABLE);
		table.addColumn("teacherID");
		table.addColumn("timing");
		table.addColumn("d");
		tablesList.put(TableManager.RPS_TIMETABLE,table);
	}*/

    private static void rps_anwesen(){
        //Primary Key teacherID,timing,d//
        Table table=new Table(TableManager.RPS_ANWESEN);
        table.addColumn("anwDate");
        table.addColumn("anwCID");
        table.addColumn("anwSID");
        table.addColumn("anwATT");
        table.addColumn("anwPER");
        table.addColumn("stunden");
        tablesList.put(TableManager.RPS_ANWESEN,table);
    }

    private static void rps_stundendetail(){
        //Primary Key stunde,descr//
        Table table=new Table(TableManager.RPS_STUNDENDETAIL);
        table.addColumn("stunde");
        table.addColumn("stufe");
        table.addColumn("descr");
        tablesList.put(TableManager.RPS_STUNDENDETAIL,table);
    }

    private static void rps_unterrichtstunden(){
        //Primary Key stunde,descr//
        Table table=new Table(TableManager.RPS_UNTERRICHTSTUNDEN);
        table.addColumn("morFrom");
        table.addColumn("morTo");
        table.addColumn("morFirstBreakFrom");
        table.addColumn("morFirstBreakTo");
        table.addColumn("morSecBreakFrom");
        table.addColumn("morSecBreakTo");
        table.addColumn("eveFrom");
        table.addColumn("eveTo");
        table.addColumn("eveFirstBreakFrom");
        table.addColumn("eveFirstBreakTo");
        table.addColumn("eveSecBreakFrom");
        table.addColumn("eveSecBreakTo");
        tablesList.put(TableManager.RPS_UNTERRICHTSTUNDEN,table);
    }

    private static void rps_employeestunden(){
        //Primary Key stunde,descr//
        Table table=new Table(TableManager.RPS_EMPLOYEESTUNDEN);
        table.addColumn("userID");
        table.addColumn("workDate");
        table.addColumn("month");
        table.addColumn("year");
        table.addColumn("timeStart");
        table.addColumn("timeEnd");
        table.addColumn("breakTimeStart");
        table.addColumn("breakTimeEnd");
        table.addColumn("placeID");
        table.addColumn("count");
        tablesList.put(TableManager.RPS_EMPLOYEESTUNDEN,table);
    }

    private static void rps_expensecategorycity(){
        //Primary Key expenseID,placeID//
        Table table=new Table(TableManager.RPS_EXPENSECATEGORYCITY);
        table.addColumn("expenseID");
        table.addColumn("placeID");
        tablesList.put(TableManager.RPS_EXPENSECATEGORYCITY,table);
    }

    private static void rps_expensecategory(){
        //Primary Key expenseID//
        Table table=new Table(TableManager.RPS_EXPENSECATEGORY);
        table.addColumn("expenseID");
        table.addColumn("expenseName");
        table.addColumn("expensePayType");
        table.addColumn("expenseStartDate");
        table.addColumn("expenseEndDate");
        table.addColumn("expenseAmount");
        table.addColumn("expenseParent");
        tablesList.put(TableManager.RPS_EXPENSECATEGORY,table);
    }

    private static void rps_inventorcategorycity(){
        //Primary Key expenseID,placeID//
        Table table=new Table(TableManager.RPS_INVENTORCATEGORYCITY);
        table.addColumn("inventorID");
        table.addColumn("placeID");
        tablesList.put(TableManager.RPS_INVENTORCATEGORYCITY,table);
    }

    private static void rps_inventorcategory(){
        //Primary Key inventoryID//
        Table table=new Table(TableManager.RPS_INVENTORCATEGORY);
        table.addColumn("inventorID");
        table.addColumn("inventorName");
        table.addColumn("inventorPayType");
        table.addColumn("inventorStartDate");
        table.addColumn("inventorEndDate");
        table.addColumn("inventorAmount");
        table.addColumn("inventorParent");
        tablesList.put(TableManager.RPS_INVENTORCATEGORY,table);
    }

    private static void rps_werbung(){
        //Primary Key werbungID//
        Table table=new Table(TableManager.RPS_WERBUNG);
        table.addColumn("werbungID");
        table.addColumn("werbungName");
        table.addColumn("werbungDetail");
        table.addColumn("werbungParent");
        table.addColumn("status");
        table.addColumn("werbungActive");
        tablesList.put(TableManager.RPS_WERBUNG,table);
    }
    private static void rps_werbungrelated(){
        //Composite Primary Key cleintID,werbungID//
        Table table=new Table(TableManager.RPS_WERBUNGRELATED);
        table.addColumn("clientID");
        table.addColumn("werbungID");
        table.addColumn("studentStatus");
        tablesList.put(TableManager.RPS_WERBUNGRELATED,table);
    }
    private static void rps_adminwerbung(){
        //Composite Primary Key adminID,werbungID//
        Table table=new Table(TableManager.RPS_ADMINWERBUNG);
        table.addColumn("adminID");
        table.addColumn("werbungID");
        tablesList.put(TableManager.RPS_ADMINWERBUNG,table);
    }

    private static void rps_group(){
        //Primary Key groupID//
        Table table=new Table(TableManager.RPS_GROUP);
        table.addColumn("groupID");
        table.addColumn("groupName");
        table.addColumn("groupDetail");
        table.addColumn("groupParent");
        table.addColumn("status");
        table.addColumn("groupActive");
        tablesList.put(TableManager.RPS_GROUP,table);
    }
    private static void rps_grouprelated(){
        //Composite Primary Key cleintID,groupID//
        Table table=new Table(TableManager.RPS_GROUPRELATED);
        table.addColumn("clientID");
        table.addColumn("groupID");
        table.addColumn("studentStatus");
        tablesList.put(TableManager.RPS_GROUPRELATED,table);
    }
    private static void rps_admingroup(){
        //Composite Primary Key adminID,GROUPID//
        Table table=new Table(TableManager.RPS_ADMINGROUP);
        table.addColumn("adminID");
        table.addColumn("groupID");
        tablesList.put(TableManager.RPS_ADMINGROUP,table);
    }

    private static void rps_messe(){
        //Composite Primary Key adminID,werbungID//
        Table table=new Table(TableManager.RPS_MESSE);
        table.addColumn("messeID");
        table.addColumn("messePlace");
        table.addColumn("messeCountry");
        table.addColumn("messeOrg");
        table.addColumn("messeDate");
        table.addColumn("messeUser");
        tablesList.put(TableManager.RPS_MESSE,table);
    }

    private static void rps_messestudent(){
        //Composite Primary Key adminID,werbungID//
        Table table=new Table(TableManager.RPS_MESSESTUDENT);
        table.addColumn("studentID");
        table.addColumn("messeID");
        table.addColumn("firstName");
        table.addColumn("lastName");
        table.addColumn("email");
        table.addColumn("studyReason");
        table.addColumn("beginDate");
        table.addColumn("intendedLanguage");
        table.addColumn("remarks");
        table.addColumn("telephone");
        table.addColumn("studentActive");
        tablesList.put(TableManager.RPS_MESSESTUDENT,table);
    }

    private static void rps_consultant(){
        //Composite Primary Key adminID,werbungID//
        Table table=new Table(TableManager.RPS_CONSULTANT);
        table.addColumn("consultantID");
        table.addColumn("consultantPlace");
        table.addColumn("consultantCountry");
        table.addColumn("consultantOrg");
        table.addColumn("consultantDate");
        table.addColumn("consultantUser");
        tablesList.put(TableManager.RPS_CONSULTANT,table);
    }

    private static void rps_consultantstudent(){
        //Composite Primary Key adminID,werbungID//
        Table table=new Table(TableManager.RPS_CONSULTANTSTUDENT);
        table.addColumn("companyID");
        table.addColumn("consultantID");
        table.addColumn("firstName");
        table.addColumn("lastName");
        table.addColumn("email");
        table.addColumn("beginDate");
        table.addColumn("remarks");
        table.addColumn("telephone");
        table.addColumn("studentActive");
        table.addColumn("fax");
        table.addColumn("mobile");
        table.addColumn("web");
        table.addColumn("address");
        tablesList.put(TableManager.RPS_CONSULTANTSTUDENT,table);
    }

    private static void rps_emailtext(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_EMAILTEXT);
        table.addColumn("textID");
        table.addColumn("textDesc");
        tablesList.put(TableManager.RPS_EMAILTEXT,table);
    }

    private static void rps_insurance(){
        //Primary Key insuranceID//
        //Auto No insuranceID//
        Table table=new Table(TableManager.RPS_INSURANCE);
        table.addColumn("insuranceID");
        table.addColumn("insuranceName");
        table.addColumn("insuranceDescription");
        tablesList.put(TableManager.RPS_INSURANCE,table);
    }
    private static void rps_insurancerelated(){
        //Composite Primary Key cleintID,insuranceID//
        Table table=new Table(TableManager.RPS_INSURANCERELATED);
        table.addColumn("studentID");
        table.addColumn("insuranceID");
        table.addColumn("insuranceDetail");
        tablesList.put(TableManager.RPS_INSURANCERELATED,table);
    }
    private static void rps_agentstudent(){
        //Composite Primary Key cleintID,insuranceID//
        Table table=new Table(TableManager.RPS_AGENTSTUDENT);
        table.addColumn("agentID");
        table.addColumn("werbungID");
        table.addColumn("studentID");
        table.addColumn("university");
        table.addColumn("wohnung");
        table.addColumn("travel");
        table.addColumn("detail");
        table.addColumn("registrationDate");
        tablesList.put(TableManager.RPS_AGENTSTUDENT,table);
    }

    private static void rps_groupstudent(){
        //Composite Primary Key cleintID,insuranceID//
        Table table=new Table(TableManager.RPS_GROUPSTUDENT);
        table.addColumn("agentID");
        table.addColumn("groupID");
        table.addColumn("studentID");
        table.addColumn("university");
        table.addColumn("wohnung");
        table.addColumn("travel");
        table.addColumn("detail");
        table.addColumn("registrationDate");
        tablesList.put(TableManager.RPS_GROUPSTUDENT,table);
    }

    private static void rps_mahnung(){
        //Primary Key mahnungID//
        Table table=new Table(TableManager.RPS_MAHNUNG);
        table.addColumn("mahnungID");
        table.addColumn("courseID");
        table.addColumn("userID");
        table.addColumn("date");
        table.addColumn("status");
        table.addColumn("adminID");
        table.addColumn("balance");
        table.addColumn("sendDate");
        tablesList.put(TableManager.RPS_MAHNUNG,table);
    }
    private static void rps_mahndatum(){
        //Composite Primary Key CourseID ,userID//
        Table table=new Table(TableManager.RPS_MAHNDATUM);
        table.addColumn("courseID");
        table.addColumn("userID");
        table.addColumn("mahnDate");
        table.addColumn("mahnDesc");
        tablesList.put(TableManager.RPS_MAHNDATUM,table);
    }
    private static void rps_mahnunginterval(){
        //Primary Key intervalID//
        Table table=new Table(TableManager.RPS_MAHNUNGINTERVAL);
        table.addColumn("intervalID");
        table.addColumn("mahnungInterval");
        table.addColumn("inkassoInterval");
        tablesList.put(TableManager.RPS_MAHNUNGINTERVAL,table);
    }

    private static void rps_userprevilige(){
        //Composite Primary Key userID,activityID//
        Table table=new Table(TableManager.RPS_USERPREVILIGE);
        table.addColumn("userID");
        table.addColumn("activityID");
        tablesList.put(TableManager.RPS_USERPREVILIGE,table);
    }
    private static void rps_allowedbefugmis(){
        //Primary Key userID//
        Table table=new Table(TableManager.RPS_ALLOWEDBEFUGNIS);
        table.addColumn("userID");
        tablesList.put(TableManager.RPS_ALLOWEDBEFUGNIS,table);
    }

    private static void rps_place(){
        //Primary Key placeID//
        Table table=new Table(TableManager.RPS_PLACE);
        table.addColumn("placeID");
        table.addColumn("placeName");
        table.addColumn("placeAddress");
        table.addColumn("postCode");
        table.addColumn("placeCity");
        table.addColumn("placeCountry");
        table.addColumn("placeTelephone");
        table.addColumn("placeFax");
        table.addColumn("placeEmail");
        table.addColumn("bamfNumber");
        table.addColumn("businessNumber");
        table.addColumn("taxNumber");
        table.addColumn("firmaName");
        table.addColumn("billSchool");
        table.addColumn("billURL");
        table.addColumn("billAddress");
        table.addColumn("comment1");
        table.addColumn("comment2");
        table.addColumn("comment3");
        table.addColumn("comment4");
        table.addColumn("comment5");
        table.addColumn("comment6");
        table.addColumn("comment7");
        table.addColumn("comment8");
        tablesList.put(TableManager.RPS_PLACE,table);
    }

    private static void rps_books(){
        //Primary Key bookID//
        Table table=new Table(TableManager.RPS_BOOKS);
        table.addColumn("bookID");
        table.addColumn("bookName");
        table.addColumn("isbn");
        table.addColumn("price");
        table.addColumn("stufe");
        tablesList.put(TableManager.RPS_BOOKS,table);
    }

    private static void rps_booklimit(){
        //Primary Key serial//
        Table table=new Table(TableManager.RPS_BOOKLIMIT);
        table.addColumn("serial");
        table.addColumn("startID");
        table.addColumn("endID");
        table.addColumn("rechID");
        table.addColumn("ausID");
        tablesList.put(TableManager.RPS_BOOKLIMIT,table);
    }

    private static void rps_bookstock(){
        //Primary Key bookTrack,bookID//
        Table table=new Table(TableManager.RPS_BOOKSTOCK);
        table.addColumn("bookTrack");
        table.addColumn("bookID");
        table.addColumn("schule");
        table.addColumn("status");
        tablesList.put(TableManager.RPS_BOOKSTOCK,table);
    }

    private static void rps_booksold(){
        //Primary Key bookTrack,bookRech//
        Table table=new Table(TableManager.RPS_BOOKSOLD);
        table.addColumn("bookTrack");
        table.addColumn("bookRech");
        tablesList.put(TableManager.RPS_BOOKSOLD,table);
    }

    private static void rps_bookrechnung(){
        //Primary Key rechID//
        Table table=new Table(TableManager.RPS_BOOKRECHNUNG);
        table.addColumn("rechID");
        table.addColumn("sID");
        table.addColumn("sName");
        table.addColumn("admin");
        table.addColumn("pay");
        table.addColumn("buyerType");
        table.addColumn("rechDate");
        table.addColumn("rechPlaceID");
        tablesList.put(TableManager.RPS_BOOKRECHNUNG,table);
    }

    private static void rps_expenditure(){
        //Primary Key expID//
        Table table=new Table(TableManager.RPS_EXPENDITURE);
        table.addColumn("expID");
        table.addColumn("expDesc");
        table.addColumn("firstDate");
        table.addColumn("enterDate");
        table.addColumn("bill");
        table.addColumn("placeID");
        table.addColumn("expCatID");
        table.addColumn("expAdmin");
        tablesList.put(TableManager.RPS_EXPENDITURE,table);
    }

    private static void rps_expcategory(){
        //Primary Key catID//
        Table table=new Table(TableManager.RPS_EXPCATEGORY);
        table.addColumn("catID");
        table.addColumn("catName");
        table.addColumn("catDesc");
        tablesList.put(TableManager.RPS_EXPCATEGORY,table);
    }

    private static void rps_vocabal(){
        //Primary Key srNo//
        Table table=new Table(TableManager.RPS_VOCABAL);
        table.addColumn("srNo");
        table.addColumn("word");
        table.addColumn("sprachID");
        table.addColumn("lectureID");
        table.addColumn("wordTrack");
        table.addColumn("descr");
        tablesList.put(TableManager.RPS_VOCABAL,table);
    }

    private static void rps_languages(){
        //Primary Key sprachID//
        Table table=new Table(TableManager.RPS_LANGUAGES);
        table.addColumn("sprachID");
        table.addColumn("sprachName");
        tablesList.put(TableManager.RPS_LANGUAGES,table);
    }

    private static void rps_lecture(){
        //Primary Key lectureID//
        Table table=new Table(TableManager.RPS_LECTURE);
        table.addColumn("lectureID");
        table.addColumn("lectureName");
        tablesList.put(TableManager.RPS_LECTURE,table);
    }

    private static void rps_picture(){
        //Primary Key picID//
        Table table=new Table(TableManager.RPS_RPSPICTURE);
        table.addColumn("picureID");
        table.addColumn("pictureName");
        table.addColumn("pictureDetail");
        tablesList.put(TableManager.RPS_RPSPICTURE,table);
    }

    private static void rps_slideshow(){
        //Primary Key configID//
        Table table=new Table(TableManager.RPS_SLIDESHOW);
        table.addColumn("configID");
        table.addColumn("slideShowInterval");
        tablesList.put(TableManager.RPS_SLIDESHOW,table);
    }

    private static void rps_dshtermin(){
        //Primary Key srID//
        Table table=new Table(TableManager.RPS_DSHTERMIN);
        table.addColumn("srID");
        table.addColumn("a1");
        table.addColumn("a2");
        table.addColumn("b1");
        table.addColumn("b2");
        table.addColumn("c1");
        tablesList.put(TableManager.RPS_DSHTERMIN,table);
    }

    private static void rps_residenceownner(){
        Table table=new Table(TableManager.RPS_RESIDENCEOWNER);
        table.addColumn("resOwnerID");
        table.addColumn("resOwnCompany");
        table.addColumn("resOwnFirstName");
        table.addColumn("resOwnerLastName");
        table.addColumn("resOwnerBirthdate");
        table.addColumn("resOwnerGender");

        table.addColumn("resOwnerAddress");
        table.addColumn("resOwnerPostCode");
        table.addColumn("resOwnerCity");
        table.addColumn("resOwnerCountry");
        table.addColumn("resOwnerHomePhone");
        table.addColumn("resOwnerOfficePhone");
        table.addColumn("resOwnerMobilePhone");
        table.addColumn("resOwnerFax");
        table.addColumn("resOwnerEmail");

        table.addColumn("resOwnerAccountNo");
        table.addColumn("resOwnerBLZ");
        table.addColumn("resOwnerBankName");

        table.addColumn("resOwnerLoginName");
        table.addColumn("resOwnerPassword");

        tablesList.put(TableManager.RPS_RESIDENCEOWNER,table);
    }

    private static void rps_resident(){
        // Primary Key userID//
        //Auto No userID//
        Table table=new Table(TableManager.RPS_RESIDENT);
        table.addColumn("userID");
        table.addColumn("userFirstName");
        table.addColumn("userLastName");
        table.addColumn("userBirthDate");
        table.addColumn("userGender");
        table.addColumn("userBirthPlace");
        table.addColumn("userNationality");
        table.addColumn("userAddress");
        table.addColumn("userPostCode");
        table.addColumn("userCity");
        table.addColumn("userCountry");
        table.addColumn("userHomePhone");
        table.addColumn("userMobilePhone");
        table.addColumn("userFax");
        table.addColumn("userEmail");
        table.addColumn("userLoginName");
        table.addColumn("userPassword");
        table.addColumn("userRemark");
        table.addColumn("userActive");
        table.addColumn("userCO");
        table.addColumn("isStudent");
        table.addColumn("studentReference");
        table.addColumn("mietStart");
        table.addColumn("mietEnd");
        table.addColumn("mieterCountStart");
        table.addColumn("mieterCountEnd");
        table.addColumn("residentID");

        tablesList.put(TableManager.RPS_RESIDENT,table);
    }

    private static void rps_residence(){
        // Primary Key residenceID//
        //Auto No residenceID//
        Table table=new Table(TableManager.RPS_RESIDENCE);
        table.addColumn("residenceID");
        table.addColumn("residenceAddress");
        table.addColumn("residencePostCode");
        table.addColumn("residenceCity");
        table.addColumn("residenceCountry");
        table.addColumn("residenceSize");
        table.addColumn("residenceDescription");
        table.addColumn("residenceRent");
        table.addColumn("residenceSideCosts");
        table.addColumn("residenceMeterNumber");
        table.addColumn("residenceStatus");
        table.addColumn("residenceOwner");
        table.addColumn("residenceMark");
        table.addColumn("residenceVWM");
        table.addColumn("residenceVKation");
        table.addColumn("residenceVKationDatum");
        table.addColumn("residenceKation");
        table.addColumn("residenceMietStart");
        table.addColumn("residenceMietEnd");
        table.addColumn("residenceType");

        tablesList.put(TableManager.RPS_RESIDENCE,table);
    }

    private static void rps_elecreading(){
        // Primary Key userID//
        Table table=new Table(TableManager.RPS_ELECREADING);
        table.addColumn("residenceID");
        table.addColumn("readingStartDate");
        table.addColumn("readingStartValue");
        table.addColumn("readingEndDate");
        table.addColumn("readingEndValue");

        tablesList.put(TableManager.RPS_ELECREADING,table);
    }

    private static void rps_residencemieten(){
        // Primary Key userID//
        Table table=new Table(TableManager.RPS_RESIDENCEMIETEN);
        table.addColumn("residenceID");
        table.addColumn("residentID");
        table.addColumn("mietStart");
        table.addColumn("mietEnd");
        table.addColumn("userBirthDate");

        tablesList.put(TableManager.RPS_RESIDENCEMIETEN,table);
    }

    private static void rps_rentoutgoing(){
        // Primary Key userID//
        Table table=new Table(TableManager.RPS_RENTOUTGOING);
        table.addColumn("residenceID");
        table.addColumn("rentMonth");
        table.addColumn("rentYear");
        table.addColumn("amountPaid");
        table.addColumn("deleteFunction");
        table.addColumn("rentDate");
        table.addColumn("paymentModeID");
        table.addColumn("rentOutID");
        table.addColumn("loginName");
        table.addColumn("placeName");
        table.addColumn("amountBalance");
        table.addColumn("residentID");

        tablesList.put(TableManager.RPS_RENTOUTGOING,table);
    }

    private static void rps_rentincoming(){
        // Primary Key userID//
        Table table=new Table(TableManager.RPS_RENTINCOMING);
        table.addColumn("residenceID");
        table.addColumn("rentMonth");
        table.addColumn("rentYear");
        table.addColumn("amountPaid");
        table.addColumn("deleteFunction");
        table.addColumn("rentDate");
        table.addColumn("paymentModeID");
        table.addColumn("rentIncomingID");
        table.addColumn("loginName");
        table.addColumn("placeName");
        table.addColumn("amountBalance");
        table.addColumn("rentPlaceID");
        table.addColumn("rentLoginID");

        tablesList.put(TableManager.RPS_RENTINCOMING,table);
    }

    private static void rps_rentpaymode(){
        // Primary Key userID//
        Table table=new Table(TableManager.RPS_RENTPAYMODE);
        table.addColumn("paymentModeID");
        table.addColumn("paymentModeDesc");
        tablesList.put(TableManager.RPS_RENTPAYMODE,table);
    }

    private static void rps_countries(){
        //Primary Key countryID//
        Table table=new Table(TableManager.RPS_COUNTRIES);
        table.addColumn("countryID");
        table.addColumn("CountryName");
        tablesList.put(TableManager.RPS_COUNTRIES,table);
    }

    private static void rps_useridentity(){
        //Primary Key countryID//
        Table table=new Table(TableManager.RPS_USERIDENTITY);
        table.addColumn("identityID");
        table.addColumn("identityName");
        tablesList.put(TableManager.RPS_USERIDENTITY,table);
    }

    //Get Tables Defination//
    public static Table getTable(String tableName){
        if(!constructorFlag){
            tableConstructor();
        }
        return tablesList.get(tableName);
    }

    //Class Variables
    private static Hashtable<String,Table> tablesList=new Hashtable<String,Table>();
    private static boolean constructorFlag=false;

    //Table Names//
    public static String RPS_COMPLAINTS="rps_complaints";
    public static String RPS_COMPLAINTSTUDENT="rps_complaintstudent";
    public static String RPS_INVENTORY="rps_inventory";
    public static String RPS_INVENTORYCAT="rps_inventorycat";
    public static String RPS_USER="rps_user";
    public static String RPS_ONLINESTUDENT="rps_onlinestudent";
    public static String RPS_VERTRAGLIST="rps_vertraglist";
    public static String RPS_BILDLIST="rps_bildlist";
    public static String RPS_PLACEPHOTO="rps_placephoto";
    public static String RPS_SYSUSERBILD="rps_sysuserbild";
    public static String RPS_COURSEVERTRAG="rps_coursevertrag";
    public static String RPS_RESIDENCEVERTRAG="rps_residencevertrag";
    public static String RPS_RESIDENTVERTRAG="rps_residentvertrag";
    public static String RPS_COURSES="rps_courses";
    public static String RPS_MODULE="rps_module";
    public static String RPS_COURSEREGISTRATION="rps_courseregistration";
    public static String RPS_TRAN="rps_tran";
    public static String RPS_NULLGEBUHR="rps_nullgebuhr";
    public static String RPS_PRINTREGRECORD="rps_printregrecord";
    public static String RPS_TRAN_XTRA="rps_tran_xtra";
    public static String RPS_XTRACOSTS="rps_xtracosts";
    public static String RPS_INT_TRAN="rps_int_tran";
    public static String RPS_INTEGRATIONCOST="rps_integrationcost";
    public static String RPS_CERTIFICATE="rps_cer";
    public static String RPS_CERTIFICATENP="rps_cernp";
    public static String RPS_MULCERTIFICATE="rps_mulcer";
    public static String RPS_MULCERTIFICATENP="rps_mulcernp";
    public static String RPS_EUNTERRICHT="rps_eunterricht";
    public static String RPS_EUNTERBALANCE="rps_eunterbalance";
    public static String RPS_EUNTERSTUDENTTRAN="rps_eunterstudenttran";
    public static String RPS_EUNTERSTUDENTSTATUS="rps_eunterstudentstatus";
    public static String RPS_KASSE="rps_kasse";

    public static String RPS_WERBUNG="rps_werbung";
    public static String RPS_WERBUNGRELATED="rps_werbungrelated";
    public static String RPS_ADMINWERBUNG="rps_adminwerbung";
    public static String RPS_GROUP="rps_group";
    public static String RPS_GROUPRELATED="rps_grouprelated";
    public static String RPS_ADMINGROUP="rps_admingroup";
    public static String RPS_AGENTSTUDENT="rps_agentstudent";
    public static String RPS_GROUPSTUDENT="rps_groupstudent";
    public static String RPS_MESSE="rps_messe";
    public static String RPS_MESSESTUDENT="rps_messestudent";
    public static String RPS_CONSULTANT="rps_consultant";
    public static String RPS_CONSULTANTSTUDENT="rps_consultantstudent";
    public static String RPS_EMAILTEXT="rps_emailtext";


    public static String RPS_INSURANCE="rps_insurance";
    public static String RPS_INSURANCERELATED="rps_insurancerelated";

    public static String RPS_BOOKS="rps_books";
    public static String RPS_BOOKLIMIT="rps_booklimit";
    public static String RPS_BOOKSTOCK="rps_bookstock";
    public static String RPS_BOOKSOLD="rps_booksold";
    public static String RPS_BOOKRECHNUNG="rps_bookrechnung";

    public static String RPS_STUNDENPLAN="rps_stundenplan";
    //public static String RPS_TIMETABLE="rps_timetable";
    public static String RPS_ANWESEN="rps_anwesen";
    public static String RPS_STUNDENDETAIL="rps_stundendetail";
    public static String RPS_UNTERRICHTSTUNDEN="rps_unterrichtstunden";
    public static String RPS_EMPLOYEESTUNDEN="rps_employeestunden";

    public static String RPS_MAHNUNG="rps_mahnung";
    public static String RPS_MAHNDATUM="rps_mahndatum";
    public static String RPS_MAHNUNGINTERVAL="rps_mahnunginterval";

    public static String RPS_SYSTEMUSER="rps_systemuser";
    public static String RPS_USERPREVILIGE="rps_userprevilige";
    public static String RPS_ALLOWEDBEFUGNIS="rps_allowedbefugnis";
    public static String RPS_SYSTEMUSERCAT="rps_usercat";
    public static String RPS_ADDRESSBOOK="rps_addressbook";
    public static String RPS_SYSTEMUSERPLACES="rps_userplaces";
    public static String RPS_SYSTEMUSERTYPE="rps_usertype";
    public static String RPS_PRIVATREMARKS="rps_privatremarks";
    public static String RPS_TEACHERHANDBOOK="rps_teacherhandbook";
    public static String RPS_EMPLOYEEHANDBOOK="rps_employeehandbook";
    public static String RPS_LOGIN="rps_login";


    public static String RPS_EXPCATEGORY="rps_expcategory";
    public static String RPS_EXPENDITURE="rps_expenditure";

    public static String RPS_VOCABAL="rps_vocabal";
    public static String RPS_LANGUAGES="rps_languages";
    public static String RPS_LECTURE="rps_lecture";

    public static String RPS_PLACE="rps_place";

    public static String RPS_RPSPICTURE="rps_picture";
    public static String RPS_SLIDESHOW="rps_slideshow";

    public static String RPS_EXPENSECATEGORY="rps_expensecategory";
    public static String RPS_EXPENSECATEGORYCITY="rps_expensecategorycity";

    public static String RPS_INVENTORCATEGORY="rps_inventorcategory";
    public static String RPS_INVENTORCATEGORYCITY="rps_inventorcategorycity";

    public static String RPS_PRIVATELOHN="rps_privatelohn";
    public static String RPS_GROUPLOHN="rps_grouplohn";

    public static String RPS_DSHTERMIN="rps_dshtermin";

    public static String RPS_RESIDENCEOWNER="rps_residenceownner";
    public static String RPS_RESIDENT="rps_resident";
    public static String RPS_RESIDENCE="rps_residence";
    public static String RPS_ELECREADING="rps_elecreading";
    public static String RPS_RESIDENCEMIETEN="rps_residencemieten";
    public static String RPS_RENTOUTGOING="rps_rentoutgoing";
    public static String RPS_RENTINCOMING="rps_rentincoming";
    public static String RPS_RENTINACTIVE_VW="rps_rentinactdisplay_vw";
    public static String RPS_RENTINNOTACTIVE_VW="rps_rentinnotactdisplay_vw";
    public static String RPS_RENTPAYMODE="rps_rentpaymode";

    public static String RPS_COUNTRIES="rps_countries";
    public static String RPS_USERIDENTITY="rps_useridentity";
}
