<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>Anonymous Forum</title>
<script type="text/javascript">
//검색 스크립트
	window.onload = function(){
	document.getElementById("btnSearch").onclick=function(){
		if(frm.keyword.value==""){
			frm.keyword.focus();
			alert("검색어를 입력하세요");
			return;
		}
		frm.submit();
	}
}
</script>
<style>
	.container {
    	margin: 0;
    	padding: 0;
    }
    #btnSearch{
    	background-color:  #b0c364;
    	border-color:  #b0c364;
    }
    #write_btn{
    	background-color:  #b0c364;
    	border-color:  #b0c364;
    }
    
}
</style>
</head>
<body>

<header id="top_section">
		<%@ include file="/template/top.jsp" %>
</header>

<div class="container">
<div style ="margin: 15px 25px 15px 0px;" align="right" >
	<button onclick="location.href ='/aBoard/aBoardWriteForm.jsp'" class="btn btn-success" id="write_btn">글쓰기</button>
</div>
	<table class="table table-hover">
		<!-- 검색어 파라미터 -->
		<c:set var="keyword" value="${param.keyword}" />
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="number" value="${number}" />
			<c:forEach var="list" items="${list}">
			<tr>
				<td>${number}</td>
				<td><a href="/aBoardInfoServlet.do?pageNum=${list.boardNum}">${list.boardTitle}</a></td>
				<td>${list.boardDate}</td>
				<td>${list.readCount}</td>
			</tr>
			<c:set var="number" value="${number-1 }"/>
			</c:forEach>
		</tbody>
	</table>
</div>
	
<div class="container">
	<c:if test="${count>0}">
			<!-- 카운터링 숫자를 얼마까지 보여줄건지 결정 -->
			<c:set var="pageCount" value="${count /pageSize + (count%pageSize == 0 ? 0 : 1 )}" />
			<c:set var="startPage" value="${1}" />
			
			<c:if test="${currentPage%5 != 0}">
				<!--결과를 정수형으로 리턴 받아야 하기에 fmt  -->
				<fmt:parseNumber var="result" value="${(currentPage-1)/5}" integerOnly="true"/>
				<c:set var="startPage" value="${result*5+1}" />
			</c:if>
			
			<c:if test="${currentPage%5 == 0}">
				<!--결과를 정수형으로 리턴 받아야 하기에 fmt  -->
				<c:set var="startPage" value="${result*5+1}" />
			</c:if>
			
			<!-- 화면에 보여질 페이지 처리 숫자를 표현 -->
			<c:set var="pageBlock" value="${5}" />
			<c:set var="endPage" value="${startPage+pageBlock-1}" />
			
			<c:if test="${endPage > pageCount}">
				<c:set var="endPage" value="${pageCount}" />
			</c:if>
			
			<!-- 게시판 페이징 -->
			<c:set var="keyword" value="${param.keyword}" />
			<c:if test="${keyword == null}">
			 <ul class="pagination justify-content-center" style="margin:20px 0">
			 	<!-- 이전 -->
				<c:if test="${startPage > pageBlock}">
					<li class="page-item"><a class="page-link" href="/aBoardListServlet.do?pageNum=${startPage-5}">◀</a></li>
				</c:if>
				<!-- 페이지 숫자 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:if test="${i==currentPage}">
						<li class="page-item active"><a class="page-link" href="/aBoardListServlet.do?pageNum=${i}">${i}</a></li>
					</c:if>
					<c:if test="${i!=currentPage}">
						<li class="page-item"><a class="page-link" href="/aBoardListServlet.do?pageNum=${i}">${i}</a></li>
					</c:if>
				</c:forEach>
				<!-- 다음  -->
				<c:if test="${endPage < pageCount}">
					<li class="page-item"><a class="page-link" href="/aBoardListServlet.do?pageNum=${startPage+5}">▶</a></li>
				</c:if>
			</ul>
			</c:if>
			
			<!-- 검색 시 페이징 -->
			<c:if test="${keyword != null}">
			 <ul class="pagination justify-content-center" style="margin:60px 0">
			 	<!-- 이전 -->
				<c:if test="${startPage > pageBlock}">
					<li class="page-item"><a class="page-link" href="/aBoardSearch.do?keyword=${keyword}&&pageNum=${startPage-5}">◀</a></li>
				</c:if>
				<!-- 페이지 숫자 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:if test="${i==currentPage}">
						<li class="page-item active"><a class="page-link" href="/aBoardSearch.do?keyword=${keyword}&&pageNum=${i}">${i}</a></li>
					</c:if>
					<c:if test="${i!=currentPage}">
						<li class="page-item "><a class="page-link" href="/aBoardSearch.do?keyword=${keyword}&&pageNum=${i}">${i}</a></li>
					</c:if>
				</c:forEach>
				
				<!-- 다음  -->
				<c:if test="${endPage < pageCount}">
					<li class="page-item"><a class="page-link" href="/aBoardSearch.do?keyword=${keyword}&&pageNum=${startPage+5}">▶</a></li>
				</c:if>
			</ul>
			</c:if>
		</c:if>
	</div>
		<form action="/aBoardSearch.do?keyword="${keyword} name="frm" method="get" class="form-inline justify-content-center" role="form" style="margin:40px 0">
			<div class="input-group mb-3">
			<input type="text" name="keyword"class="form-control" placeholder="Search" placeholder="검색"/>
			 <div class="input-group-append">
			<input type="button" value="검색" id="btnSearch" class="btn btn-success" />
			</div>
			</div>
		</form>
	<footer>
		<%@ include file="/template/bottom.jsp" %>
	</footer>
</body>
</html>