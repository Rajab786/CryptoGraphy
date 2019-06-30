<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import=" java.io.BufferedReader"%>
<%@ page import=" java.io.FileNotFoundException"%>
<%@ page import=" java.io.FileReader"%>
<%@ page import=" java.io.UnsupportedEncodingException"%>
<%@ page import=" java.security.MessageDigest"%>
<%@ page import=" java.security.NoSuchAlgorithmException"%>
<%@ page import=" java.util.Arrays"%>
<%@ page import=" java.util.Base64"%>
<%@ page import=" javax.crypto.Cipher"%>
<%@ page import=" javax.crypto.spec.SecretKeySpec"%>
<%@ page import=" java.nio.file.Files"%>
<%@ page import=" java.nio.file.Paths"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ENC-DEC</title>
</head>
<body>

<%!
private static SecretKeySpec secretKey;
private static byte[] key;

public static void setKey(String myKey)
{
    MessageDigest sha = null;
    try {
        key = myKey.getBytes("UTF-8");
        sha = MessageDigest.getInstance("SHA-1");
        key = sha.digest(key);
        key = Arrays.copyOf(key, 16);
        secretKey = new SecretKeySpec(key, "AES");
    }
    catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
    }
    catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }
}
public static String readfile(FileReader fr) {
	StringBuilder sb= new StringBuilder();
	try {    
     BufferedReader br=new BufferedReader(fr);    
        
     int ch;
     while((ch=br.read())!=-1)
     sb.append((char)ch);
     br.close();    
     fr.close(); 
}
	catch(Exception e) {
		
	}
	return  sb.toString();
	
}

public static String encrypt(String strToEncrypt, String secret)
{  
    try
    {
        setKey(secret);
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
    }
    catch (Exception e)
    {
        System.out.println("Error while encrypting: " + e.toString());
    }
    return null;
}

public static String decrypt(String strToDecrypt, String secret)
{
    try
    {
        setKey(secret);
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
    }
    catch (Exception e)
    {
        System.out.println("Error while decrypting: " + e.toString());
    }
    return null;
}

%>

<%
FileReader fr = null;

%>
<%
try{
fr =new FileReader("C:\\Users\\rajab\\Desktop\\islands.txt");	
}catch(Exception e){
	e.printStackTrace();
}
String secretKe = "ssshhhhhhhhhhh!!!!";

%>

<%
	 String originalString ;
	 String encryptedString;
	 String decryptedString;
     originalString =  readfile(fr);
    // System.out.println(originalString);
     encryptedString = encrypt(originalString, secretKe) ;
 	 decryptedString = decrypt(encryptedString, secretKe) ;
 	//System.out.println(decryptedString);
 	
 	
        try {
            Files.write(Paths.get("D:\\Encrypted Files\\decryptedfile.txt"), decryptedString.getBytes());
        } catch (Exception e) {
            e.printStackTrace();
        }
%>



</body>
</html>