
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Database Connection</title>
</head>
<body>
		
		<% 
			  String username = request.getParameter("username");
		      String password = request.getParameter("password");
		      String email = request.getParameter("email");
		      
		       /*String password ="rajab";
		      String email = "abc@gmail.com"; */ 
		      out.println(username);
		      out.println(password);
		      out.println(email);
		      Class.forName("com.mysql.cj.jdbc.Driver");
		      Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/crypto","root","mubarak@786");
		      PreparedStatement pst = con.prepareStatement("insert into det values(?,?,?)");
		      pst.setString(1,username);
		      pst.setString(2,password);
		      pst.setString(3,email);
		      
		      int i = pst.executeUpdate();
		      if(i!=0){
		    	  response.sendRedirect("enc.html");
		      }
		      else{
		        out.println("failed to insert the data");
		      }
		%>
</body>
</html>