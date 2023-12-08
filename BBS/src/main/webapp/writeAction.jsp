<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.bbs" scope="page" /> <!-- 자바빈 사용, scope="page"(현재 페이지에서만 자바빈이 사용되도록 한다) -->
<jsp:setProperty name="bbs" property="bbsTitle" /> <!-- 로그인페이지에서 넘겨준 userID를 받아서 사용자의 userID에 넣어준다  -->
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 중...</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else{
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모두 입력해주세요')");
				script.println("history.back()"); /* 이전 페이지로 되돌림 */
				script.println("</script>");
			} else {
				bbsDAO bbsDAO = new bbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()"); /* 이전 페이지로 되돌림 */
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}	
			}
		}
			
		
	%>

</body>
</html>