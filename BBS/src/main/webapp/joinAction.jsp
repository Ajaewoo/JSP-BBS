<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 자바빈 사용, scope="page"(현재 페이지에서만 자바빈이 사용되도록 한다) -->
<jsp:setProperty name="user" property="userID" /> <!-- 로그인페이지에서 넘겨준 userID를 받아서 사용자의 userID에 넣어준다  -->
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 중...</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
		|| user.getUserGender() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모두 입력해주세요')");
			script.println("history.back()"); /* 이전 페이지로 되돌림 */
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); /* 이전 페이지로 되돌림 */
				script.println("</script>");
			}else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			
		}
	%>

</body>
</html>