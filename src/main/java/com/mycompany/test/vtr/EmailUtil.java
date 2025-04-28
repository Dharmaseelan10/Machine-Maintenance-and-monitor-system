package com.mycompany.test.vtr;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    public static String getEmailSender() {
        return "infosystem.mme@murata.com"; // Change to your desired sender email
    }

    public static Session getSmtpSession() {
        String host = "172.24.128.80"; // SMTP server address
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "false");
        properties.put("mail.smtp.port", "25");
        properties.put("mail.smtp.starttls.enable", "true");
        
        // Use Session.getInstance instead of Session.getDefaultInstance
        return Session.getInstance(properties);
    }

    public static void sendEmail(String to, String subject, String body) {
        try {
            Session session = getSmtpSession();
            // Create a MimeMessage using the session
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(getEmailSender()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}