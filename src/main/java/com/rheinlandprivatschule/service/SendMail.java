package com.rheinlandprivatschule.service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {

	/*public SendMail() {
		this.username = "web12";
		this.password = "rheinland";
		this.host = "www.london-privat.com";
		this.from = "info@london-privat.com";
		this.too = "";
		this.subject = "My First Message";
		this.text = "Great! Its Working";
		this.files = new Vector();
		this.errorMsg = "No Msg";
	}*/

    public SendMail() {
        this.username = "info@unitutor.de";
        this.password = "Rami_2019";
        this.host = "smtp.ionos.de";
        this.from = "info@unitutor.de";
        this.too = "";
        this.subject = "My First Message";
        this.text = "Great! Its Working";
        this.files = new Vector();
        this.errorMsg = "No Msg";
    }


    public String getErrorMessage() {
        return this.errorMsg;
    }

    public String getRI() {
        return "" + System.getProperty("user.dir");
    }

    public static void main(String args1[]) {
        SendMail sendMail = new SendMail();
        sendMail.too = "dev.cemas@gmail.com";
        sendMail.sendMail();
    }

    public boolean sendMail() {
        boolean b = false;
        try {
            java.util.Properties props = System.getProperties();
            props.setProperty("mail.smtp.host", "smtp.office365.com");
            props.setProperty("mail.smtp.port", "587");
            props.setProperty("mail.smtp.auth", "true");
            props.setProperty("mail.smtp.starttls.enable", "true");

            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication()
                {
                    return new PasswordAuthentication(username, password);
                }
            };
            Session se = Session.getInstance(props, auth);
            Message message = new MimeMessage(se);
            javax.mail.Address fromAddress = new InternetAddress(from);
            message.setFrom(fromAddress);
            javax.mail.Address toAddresses[] = InternetAddress.parse(too);
            message.setRecipients(javax.mail.Message.RecipientType.BCC,
                    toAddresses);
            message.setSubject(subject);
            message.setSentDate(new Date());

            // Create the message part
            BodyPart messageBodyPart = new MimeBodyPart();


            // Fill the message
            //messageBodyPart.setText(text)
            messageBodyPart.setDataHandler(new DataHandler(new HTMLDataSource(text)));


            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);

            // Part two is attachment
            for (int i = 0; i < files.size(); i++) {
                String attachName = (String) files.elementAt(i);
                messageBodyPart = new MimeBodyPart();
                javax.activation.DataSource source = new FileDataSource(
                        this.relativePath + attachName);
                messageBodyPart.setDataHandler(new DataHandler(source));
                messageBodyPart.setFileName(attachName);
                multipart.addBodyPart(messageBodyPart);
            }

            message.setContent(multipart);
            Transport.send(message);
            b = true;
        } catch (Exception e) {
            errorMsg = e.toString();
        }

        return b;
    }

    //Setters

    public void setFiles(Vector code) {
        this.files = code;
    }

    public void setFrom(String code) {
        this.from = code;
    }

    static class HTMLDataSource implements DataSource {
        private String html;

        public HTMLDataSource(String htmlString) {
            html = htmlString;
        }

        // Return html string in an InputStream.
        // A new stream must be returned each time.
        public InputStream getInputStream() throws IOException {
            if (html == null) throw new IOException("Null HTML");
            return new ByteArrayInputStream(html.getBytes());
        }

        public OutputStream getOutputStream() throws IOException {
            throw new IOException("This DataHandler cannot write HTML");
        }

        public String getContentType() {
            return "text/html";
        }

        public String getName() {
            return "JAF text/html dataSource to send e-mail only";
        }
    }
    //End of class


    public void setHost(String code) {
        this.host = code;
    }

    public void setPassword(String code) {
        this.password = code;
    }

    public void setRelativePath(String code) {
        this.relativePath = code;
    }

    public void setSubject(String code) {
        this.subject = code;
    }

    public void setText(String code) {
        this.text = code;
    }

    public void setTo(String code) {
        this.too = code;
    }

    public void setUserName(String code) {
        this.username = code;
    }

    //Instance Varaiables
    private String errorMsg;

    private Vector files;

    private String from;

    private String host;

    private String password;

    private String relativePath;

    private String subject;

    private String text;

    private String too;

    private String username;

    private class SMTPAuthenticator extends javax.mail.Authenticator {
        public PasswordAuthentication getPasswordAuthentication() {
            String usr = username;
            String pass = password;
            return new PasswordAuthentication(usr, pass);
        }
    }

    public class MyAuthenticator extends Authenticator {

        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(sUsername, sPassword);
        }

        String sPassword;

        String sUsername;

        public MyAuthenticator(String username, String password) {
            super();
            sUsername = username;
            sPassword = password;
        }
    }

}
