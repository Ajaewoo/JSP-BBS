<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDAO" %>
<%@ page import="bbs.bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 중...</title>
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
		} 
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		bbs bbs = new bbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}else{
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
				|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모두 입력해주세요')");
				script.println("history.back()"); /* 이전 페이지로 되돌림 */
				script.println("</script>");
			} else {
				bbsDAO bbsDAO = new bbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
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