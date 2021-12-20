<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:url var="root" value="/" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!doctype html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

</head>
<style>
body {
	overflow-x: hidden;
}

#wrapper {
	padding-left: 0;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled {
	padding-left: 250px;
}

#sidebar-wrapper {
	z-index: 1000;
	position: fixed;
	left: 250px;
	width: 0;
	height: 100%;
	margin-left: -250px;
	overflow-y: auto;
	background: #000;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled #sidebar-wrapper {
	width: 250px;
}

#page-content-wrapper {
	width: 100%;
	position: absolute;
	padding: 15px;
}

#wrapper.toggled #page-content-wrapper {
	position: absolute;
	margin-right: -250px;
}

/* Sidebar Styles */
.sidebar-nav {
	position: absolute;
	top: 0;
	width: 250px;
	margin: 0;
	padding: 0;
	list-style: none;
}

.sidebar-nav li {
	text-indent: 20px;
	line-height: 40px;
}

.sidebar-nav li a {
	display: block;
	text-decoration: none;
	color: #999999;
}

.sidebar-nav li a:hover {
	text-decoration: none;
	color: #fff;
	background: rgba(255, 255, 255, 0.2);
}

.sidebar-nav li a:active, .sidebar-nav li a:focus {
	text-decoration: none;
}

.sidebar-nav>.sidebar-brand {
	height: 65px;
	font-size: 18px;
	line-height: 60px;
}

.sidebar-nav>.sidebar-brand a {
	color: #999999;
}

.sidebar-nav>.sidebar-brand a:hover {
	color: #fff;
	background: none;
}

@media ( min-width :768px) {
	#wrapper {
		padding-left: 0;
	}
	#wrapper.toggled {
		padding-left: 250px;
	}
	#sidebar-wrapper {
		width: 0;
	}
	#wrapper.toggled #sidebar-wrapper {
		width: 250px;
	}
	#page-content-wrapper {
		padding: 20px;
		position: relative;
	}
	#wrapper.toggled #page-content-wrapper {
		position: relative;
		margin-right: 0;
	}
}
</style>
<script>
	<%-- 제목 커서 표시 및 sunmit --%>
	$(document).ready(function (){
		$("div.title").css("cursor", "pointer").click(function(){
			let no = $(this).attr("id");
			$("#writeNo").val(no);
			$("#f").attr("action", "${root}centerViewProc");
			$("#f").submit();
		});
	});
	<%--전체 버튼--%>
	$(document).on('click','#centerAll',function(){
		$("#f").attr("action", "${root}sellerProc?answer");
		$("#f").submit();
	});
	
	<%--미답변 버튼--%>
	$(document).on('click','#centerNo',function(){
		$("#f").attr("action", "${root}sellerProc?answer=n");
		$("#f").submit();
	});
	<%--prev 버튼--%>
	$(document).on('click','#a-tag-Prev',function(){
		$("#pageNumber").val(${cl.getPageNumber()-1});
		$("#f").attr("action", "${root}sellerProc");
		$("#f").submit();
	});
	<%--page 버튼--%>
	$(document).on('click','#a-tag-Page',function(){
		var page = $(this).text();
		$("#pageNumber").val(page);
		$("#f").attr("action", "${root}sellerProc");
		$("#f").submit();
	});
	<%--next 버튼--%>
	$(document).on('click','#a-tag-Next',function(){
		$("#pageNumber").val(${cl.getPageNumber()+1});
		$("#f").attr("action", "${root}sellerProc");
		$("#f").submit();
	});
</script>
<body>
	<c:if test="${not empty msg}"><script>alert("${msg}")</script></c:if>
	<form id="f" method="post">
		<input type="hidden" id="reUri" name="reUri" value="sellerProc"/>
		<input type="hidden" id="writeNo" name="writeNo"/>
		<input type="hidden" id="pageNumber" name="pageNumber" value="${cl.getPageNumber()}"/>
		<input type="hidden" name="category" value="${searchDto.category}"/>
		<input type="hidden" name="mode" value="${searchDto.mode}"/>
		<input type="hidden" name="find" value="${searchDto.find}"/>
		<input type="hidden" name="data" value="${searchDto.data}"/>
	</form>
	<div id="wrapper" class="toggled">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="${root}sellerProc"> 내 상품문의 </a></li>
				<li><a href="${root}sellerProc?category=movie">영화</a></li>
				<li><a href="${root}sellerProc?category=theater">연극</a></li>
				<li><a href="${root}sellerProc?category=concert">콘서트</a></li>
				<li><a href="${root}sellerProc?category=sports">스포츠</a></li>
				<li><a href="${root}sellerProc?category=leisure">레저</a></li>
				<li><br></li>
				<li><a href="${root}centerProc"> 고객센터 </a></li>
				</ul>
		</div>
		<div id="page-content-wrapper">
			<h3>&ensp;<b>${searchDto.category}</b></h3>
			<div class="container-fluid">
				<button type="button" class="btn btn-secondary" id="centerAll">전 체</button>
				<button type="button" class="btn btn-secondary" id="centerNo">미답변</button>
				<table class="table">
					<thead>
					<tr>
						<th style="width: 10%;" scope="col" class="text-center">
						</th>
						<th style="width: 60%;" scope="col" class="text-center">제목</th>
						<th style="width: 15%;" scope="col" class="text-center">작성자</th>
						<th style="width: 15%;" scope="col" class="text-center">작성일</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="i" begin="${cl.getStart()}" end="${cl.getScroll() + cl.getStart() - 1}" step="1">
						<c:if test="${i < cl.getTotalRecord()}">
							<c:set var="list" value="${centerList.get(i)}"/>
							<tr>
								<td scope="row" class="text-center" valign="middle">
									<c:if test="${list.groupOrd == 0}">
										${list.no}
									</c:if>
								</td>
								<td scope="row" class="text-center"><div id="${list.no }" class="title"> ${list.title }</div></td>
								<td scope="row" class="text-center">${list.id }</td>
								<td scope="row" class="text-center">${list.writeDate }</td>
							</tr>
						</c:if>
					</c:forEach>
					</tbody>
				</table>
				<br>
				<br>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
				  		<c:choose>
							<c:when test="${cl.getPageNumber() <= 1}">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Prev</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:set var="tmpPrev" value="${cl.getPageNumber() - 1}"/>
								<li class="page-item">
									<a class="page-link" id="a-tag-Prev">Prev</a>
								</li>
							</c:otherwise> 
						</c:choose>	
				    	<c:forEach var="i" begin="1" end="${cl.getTotalPage()}" step="1">
							<c:choose>
								<c:when test="${cl.getPageNumber() == i}">
									  <li class="page-item active"><a class="page-link" href="#">${i }</a></li>
								</c:when>
								<c:otherwise>
								   <li class="page-item"><a class="page-link" id="a-tag-Page">${i }</a></li>
								</c:otherwise> 
							</c:choose>	
						</c:forEach>
						<c:choose>
							<c:when test="${cl.getPageNumber() >= cl.getTotalPage()}">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:set var="tmpNext" value="${cl.getPageNumber() + 1}"/>
								<li class="page-item">
				      				<a class="page-link" id="a-tag-Next">Next</a>
				    			</li>
							</c:otherwise> 
						</c:choose>
				  </ul>
				</nav>
			</div>
		</div>

	</div>

	<!-- Footer -->
	<!-- Optional JavaScript; choose one of the two! -->
	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
    
</body>
