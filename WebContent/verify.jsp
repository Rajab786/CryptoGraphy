<%@page import ="java.sql.*" %>
<%@page import ="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.io.*"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>

    <html> 
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login Check</title> 
        </head> 
        <body> 
        <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        String driver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/crypto";
        String dbuser = "root";
        String dbpassword = "mubarak@786";
        Connection theConnection = null;
        PreparedStatement theStatement = null;


            try{  
                Class.forName(driver);
                theConnection=DriverManager.getConnection(dbURL,dbuser,dbpassword);  
                theStatement = theConnection.prepareStatement("select * from det where username=? and password=?");
                theStatement.setString(1,request.getParameter("username"));
                theStatement.setString(2,request.getParameter("password"));
                ResultSet theResult = theStatement.executeQuery();

                if(theResult.next())
                	 response.sendRedirect("enc.html");
                 
                else
                	 response.sendRedirect("errorpage.html");

                }catch(Exception e){
                    System.out.println("Exception occured! "+e.getMessage()+" "+e.getStackTrace());
                }  
        %>
</body>
    </html>