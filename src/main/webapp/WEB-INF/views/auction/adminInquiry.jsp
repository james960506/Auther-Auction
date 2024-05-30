<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kh.auction.user.model.vo.Auction"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="main/css/template.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="auction/auctionCss/adminInquiry.css">
</head>
<body>
	<jsp:include page="../common/adminHeadSide.jsp"></jsp:include>
	
	<div id="first">
		<form action="search.adac" method="get">
			<div id="coverAll">
				<h2 id="firstH2">Auction</h2>
				<div id="searchBox">
					<div id="checkBoxAll">
						<input type="checkBox" id="all">
						<label for="all">전체</label>
					</div>
					<div id="yetAuc">
						<input type="checkBox" class="auctionStatus" value="scheduled" name="scheduled" id="scheduled" onclick="allCheck(this);">
						<label for="scheduled">진행 예정 경매</label>
					</div>
					<div id="keepAuc">
						<input type="checkBox" class="auctionStatus" value="ongoing" name="ongoing" id="ongoing" onclick="allCheck(this);">
						<label for="ongoing">진행 중인 경매</label>
					</div>
					<div id="finAuc">
						<input type="checkBox" class="auctionStatus" value="end" name="end" id="end" onclick="allCheck(this);">
						<label for="end">종료된 경매</label>
					</div>
					<div id="selecetZone">
						<select id="selectPart"name="search">
							<option value="all">---------</option>
							<option value="author">작가명</option>
							<option value="work">작품명</option>
						</select> <input type="text" id="content" name="content">
						<button id="button">검색</button>
					</div>
					<div id="durationZone">
						<input type="checkbox" id="auctionTerm" onclick="openPeriod(this);">
						<label for="auctionTerm">경매 기간</label>
					</div>
				</div>
				<div id="checkAuctionPeriod">
					<span id="searchSpace">기간검색</span>
					<div id="searchSpaceDiv">
						<div id="searchSpaceDiv2">
							경매 시작일
							<button type="button" onclick="openCalendar(this);" class="openCalBtn">달력</button>
							<input type="text" name="aucSS" readonly>
							<!-- 시작/시작 달력 -->
							<div id="startFirstCalendar" class="calendar">
								<div id="startFirstCalendarDiv">
									<div id="startFirstCalendarDiv2">
										<button class="previous" type="button" id="srtPreBut">&lt;</button>
									</div>
									<span class="yearPlace"></span>년 <span class="monthPlace"></span>월
									<div id="srtDate">
										<button id="srtNextBut" class="next" type="button">&gt;</button>
									</div>
								</div>
								<jsp:include page="miniCalendar.jsp" />
								<div id="srtSrtButDiv">
									<button type="button" class="select">선택</button>
									<button type="button" class="close" onclick="close();">닫기</button>
								</div>
							</div>
							<!-- 시작/시작 끝 -->
							<span class="swung1">~</span>
							<button type="button" onclick="openCalendar(this);" class="openCalBtn">달력</button>
							<input type="text" name="aucSE" readonly>
							<!-- 시작/끝 시작 -->
							<div id="startSecondCalendar" class="calendar">
								<div id="startSecondCalendarDiv">
									<div id="srtEndButZone">
										<button id="srtEndPreBut" class="previous" type="button">&lt;</button>
									</div>
									<span class="yearPlace"></span>년 <span class="monthPlace"></span>월
									<div id="srtEndNextButDiv">
										<button class="next" type="button" id="srtEndNextBut">&gt;</button>
									</div>
								</div>
								<jsp:include page="miniCalendar.jsp" />
								<div id="selectDiv">
									<button type="button" class="select">선택</button>
									<button type="button" class="close" onclick="close();">닫기</button>
								</div>
							</div>
							<!-- 시작/끝 끝 -->
						</div>
						<div id="searchSpaceDiv1">
							경매 종료일
							<button type="button" onclick="openCalendar(this);" class="openCalBtn">달력</button>
							<input type="text" name="aucFS" readonly>
							<!-- 끝/시작 시작 -->
							<div id="endFirstCalendar" class="calendar">
								<div id="endStartUpButZone">
									<div id="endStartPreButDiv">
										<button class="previous" type="button" id="endStartPreBut">&lt;</button>
									</div>
									<span class="yearPlace"></span>년 <span class="monthPlace"></span>월
									<div  id="endStartNextButDiv">
										<button id="endStartNextBut" class="next" type="button">&gt;</button>
									</div>
								</div>
								<jsp:include page="miniCalendar.jsp" />
								<div id="endSrtButZone">
									<button type="button" class="select">선택</button>
									<button type="button" class="close" onclick="close();">닫기</button>
								</div>
							</div>
							<!-- 끝/시작 끝 -->
							<span class="swung">~</span>
							<button type="button" onclick="openCalendar(this);" class="openCalBtn">달력</button>
							<input type="text" name="aucFE" readonly>
							<!-- 끝/끝 시작 -->
							<div id="endSecondCalendar" class="calendar">
								<div id="endEndUpButZone">
									<div id="endEndUpButZoneDiv">
										<button id="endEndPreBut" class="previous" type="button">&lt;</button>
									</div>
									<span class="yearPlace"></span>년 <span class="monthPlace"></span>월
									<div id="endEndNextButDiv">
										<button id="endEndNextBut" class="next" type="button">&gt;</button>
									</div>
								</div>
								<jsp:include page="miniCalendar.jsp" />
								<div id="underDiv">
									<button type="button" class="select">선택</button>
									<button type="button" class="close" onclick="close();">닫기</button>
								</div>
							</div>
							<!-- 끝/끝 끝 -->
						</div>
					</div>
					<div id="asdsd">
						<button type="button" id="reset" onclick="resetCalendar();">달력 초기화</button>
					</div>
				</div>
			</div>
		</form>
		<div id="showDiv">
			<div  id="showDiv2">
				<span>총 경매</span>&nbsp; ${ total } 개 
				<span onclick="sortingPrice('high');" class="sorting" id="sortUp">금액 높은순</span>
				<span onclick="sortingPrice('low');" class="sorting">금액 낮은순</span>
			</div>
			<div id="showCover">
				<div id="num">경매 번호</div>
				<div class="showingPlace">작품 사진</div>
				<div class="showingPlace">작가 명</div>
				<div class="showingPlace">작품 명</div>
				<div class="showingPlace">경매 기간</div>
				<div class="showingPlace">경매 상황</div>
				<div class="showingPlace">금액</div>
			</div>
		</div>

		<div id="infoPlace">
			<c:if test="${ empty aList }">
				<div id="ifNoData">
					<h1>조회할 데이터가 없습니다</h1>
				</div>
			</c:if>
			<c:forEach items="${ aList }" var="auction" varStatus="status">
				<div onclick="openAuctionModal('${auction.aucNo}', '${ auction.aucStartPrice }','${ auction.aucFinishPrice }','${ auction.aucStartDate }','${ auction.aucFinishDate }','${ auction.aucMemId}','${ auction.conAuthor }','${ auction.conProduct }','${ auction.conWidth }','${ auction.conHeight }','${ auction.conYear }','${ StringEscapeUtils.escapeEcmaScript(auction.conEtc)}','${ auction.attRename }');" class="auction"
					>
					<div class="aucSss">${ auction.aucNo }</div>
					<div class="imgRenameCover">
						<img class="imgss" src="${ auction.attRename }">
					</div>
					<div class="aucSss">${ auction.conAuthor }</div>
					<div class="aucSss">${ auction.conProduct }</div>
					<div class="aucSss">
						시작일 : ${ fn:split(auction.aucStartDate, ' ')[0] }
						<br>
						종료일 : ${ fn:split(auction.aucFinishDate, ' ')[0] }
					</div>

					<c:set var="status" value="${status.index}" />

					<%
					Date today = new Date();

					List<Auction> auctionList = (List<Auction>) request.getAttribute("aList");
					int i = (int) pageContext.getAttribute("status");

					String auctionStartDateStr = auctionList.get(i).getAucStartDate(); // "2024-01-10 15:30:00" 형태의 값으로 가정
					String auctionEndDateStr = auctionList.get(i).getAucFinishDate();

					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date auctionStartDate = dateFormat.parse(auctionStartDateStr);
					Date auctionEndDate = dateFormat.parse(auctionEndDateStr);

					if (today.compareTo(auctionStartDate) < 0) {
					%>
					<div class="aucStatus">예정 경매</div>
					<%
					} else if (today.compareTo(auctionEndDate) > 0) {
					%>
					<div class="aucStatus">종료 경매</div>
					<%
					} else {
					%>
					<div class="aucStatus">진행 경매</div>
					<%
					}
					%>

					<%
					if (today.compareTo(auctionStartDate) < 0) {
					%>
					<div class="aucStatus">경매 시작가<br>
						<fmt:formatNumber value="${ auction.aucStartPrice }" />	원
					</div>
					<%
					} else if (today.compareTo(auctionEndDate) > 0) {
					%>
					<div class="aucStatus">낙찰 금액<br>
						<fmt:formatNumber value="${ auction.aucFinishPrice }" /> 원
					</div>
					<%
					} else {
					%>
					<div class="aucStatus">입찰 금액<br>
						<fmt:formatNumber value="${ auction.aucFinishPrice }" /> 원
					</div>
					<%
					}
					%>
				</div>
			</c:forEach>
			</div>
			
			<div class="modal" id="aucModal">
		      <div class="modal_body">
		      	<h1 id="modalH1">경매품 정보</h1>
		      	<div>경매 번호</div>
		      	<div>작품명</div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div>작가명</div>
		      	<div>경매 시작가</div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div>최고 입찰금</div>
		      	<div>현재 입찰자 아이디</div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div>시작일</div>
		      	<div>종료일</div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div>가로</div>
		      	<div>세로</div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div><input type="text" disabled  class="modalInput"></div>
		      	<div>사진<br><img id="picDiv" onclick="getLargePic(this);"/></div>
		      	<div>
		      		작품 설명<br>
		      		<textarea disabled rows="9" cols="33" id="textBox"></textarea>
		      	</div>
		      	<div></div>
		      	<div id="closeCover">
		      		<button id="modalClose">닫기</button>
		      	</div>
		      </div>
		</div>
			
		<div class="modal" id="picModal">
			<div id="picModalBody">
				<img id="largePic">
				<div>
					<button onclick="closeLarge();" id="largeClose">닫기</button>
				</div>
			</div>
		</div>
			

			<%
			String queryString = request.getQueryString();
			String scheduledString = "scheduled=scheduled";
			String ongoingString = "ongoing=ongoing";
			String endString = "end=end";
			String aucSSString = "aucSS=";
			String aucSEString = "aucSE=";
			String aucFSString = "aucFS=";
			String aucFEString = "aucFE=";

			pageContext.setAttribute("queryString", queryString);
			pageContext.setAttribute("scheduledString", scheduledString);
			pageContext.setAttribute("ongoingString", ongoingString);
			pageContext.setAttribute("endString", endString);
			pageContext.setAttribute("aucSSString", aucSSString);
			pageContext.setAttribute("aucSEString", aucSEString);
			pageContext.setAttribute("aucFSString", aucFSString);
			pageContext.setAttribute("aucFEString", aucFEString);
			%>

			<br>
			
			<nav class="pagiset pagiset-line">
				<c:if test="${ pi.currentPage <= 1 }">
					<div class="pagiset-ctrl">
						<a class="pagiset-link pagiset-first"> <span
							class="visually-hidden">처음</span>
						</a>
					</div>
					<div class="pagiset-ctrl">
						<a class="pagiset-link pagiset-prev"> <span
							class="visually-hidden">이전</span>
						</a>
					</div>
				</c:if>
				<c:if test="${ pi.currentPage > 1 }">
					<div class="pagiset-ctrl">
						<c:url var="goFirst" value="${ loc }">
							<c:if test="${ fn:containsIgnoreCase( queryString, scheduledString ) }">
								<c:param name="scheduled" value="${ scheduled }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, ongoingString ) }">
								<c:param name="ongoing" value="${ ongoing }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, endString ) }">
								<c:param name="end" value="${ end }"></c:param>
							</c:if>
							<c:if test="${ !empty search }">
								<c:param name="search" value="${ search }"></c:param>
							</c:if>
							<c:if test="${ (empty content and content eq '') or  !empty content}">
								<c:param name="content" value="${ content }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSSString ) }">
								<c:param name="aucSS" value="${ aucSS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSEString ) }">
								<c:param name="aucSE" value="${ aucSE }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFSString ) }">
								<c:param name="aucFS" value="${ aucFS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFEString ) }">
								<c:param name="aucFE" value="${ aucFE }"></c:param>
							</c:if>
							<c:if test="${ !empty sort }">
								<c:param name="sort" value="${ sort }"></c:param>
							</c:if>
							<c:param name="page" value="${ pi.startPage }"></c:param>
						</c:url>
						<a class="pagiset-link pagiset-first" href="${ goFirst }"> <span
							class="visually-hidden">처음</span>
						</a>
					</div>
					<div class="pagiset-ctrl">
						<c:url var="goBack" value="${ loc }">
							<c:if test="${ fn:containsIgnoreCase( queryString, scheduledString ) }">
								<c:param name="scheduled" value="${ scheduled }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, ongoingString ) }">
								<c:param name="ongoing" value="${ ongoing }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, endString ) }">
								<c:param name="end" value="${ end }"></c:param>
							</c:if>
							<c:if test="${ !empty search }">
								<c:param name="search" value="${ search }"></c:param>
							</c:if>
							<c:if test="${ (empty content and content eq '') or  !empty content}">
								<c:param name="content" value="${ content }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSSString ) }">
								<c:param name="aucSS" value="${ aucSS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSEString ) }">
								<c:param name="aucSE" value="${ aucSE }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFSString ) }">
								<c:param name="aucFS" value="${ aucFS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFEString ) }">
								<c:param name="aucFE" value="${ aucFE }"></c:param>
							</c:if>
							<c:if test="${ !empty sort }">
								<c:param name="sort" value="${ sort }"></c:param>
							</c:if>
							<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
						</c:url>
						<a class="pagiset-link pagiset-prev" href="${ goBack }">
							<span class="visually-hidden">이전</span>
						</a>
					</div>
				</c:if>
				<div class="pagiset-list">
					<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
						<c:url var="goNum" value="${ loc }">
							<c:if test="${ fn:containsIgnoreCase( queryString, scheduledString ) }">
								<c:param name="scheduled" value="${ scheduled }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, ongoingString ) }">
								<c:param name="ongoing" value="${ ongoing }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, endString ) }">
								<c:param name="end" value="${ end }"></c:param>
							</c:if>
							<c:if test="${ !empty search }">
								<c:param name="search" value="${ search }"></c:param>
							</c:if>
							<c:if test="${ (empty content and content eq '') or  !empty content}">
								<c:param name="content" value="${ content }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSSString ) }">
								<c:param name="aucSS" value="${ aucSS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSEString ) }">
								<c:param name="aucSE" value="${ aucSE }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFSString ) }">
								<c:param name="aucFS" value="${ aucFS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFEString ) }">
								<c:param name="aucFE" value="${ aucFE }"></c:param>
							</c:if>
							<c:if test="${ !empty sort }">
								<c:param name="sort" value="${ sort }"></c:param>
							</c:if>
							<c:param name="page" value="${ p }"></c:param>
						</c:url>
						<c:choose>
							<c:when test="${p eq pi.currentPage}">
								<a class="pagiset-link active-fill" href="${ goNum }">${ p }</a>
							</c:when>
							<c:otherwise>
								<a class="pagiset-link" href="${ goNum }">${ p }</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>




				<c:if test="${ pi.currentPage >= pi.maxPage }">
					<div class="pagiset-ctrl">
						<a class="pagiset-link pagiset-next"> <span
							class="visually-hidden">다음</span>
						</a>
					</div>
					<div class="pagiset-ctrl">
						<a class="pagiset-link pagiset-last"> <span
							class="visually-hidden">마지막</span>
						</a>
					</div>
				</c:if>
				<c:if test="${ pi.currentPage < pi.maxPage }">
					<div class="pagiset-ctrl">
						<c:url var="goNext" value="${ loc }">
							<c:if test="${ fn:containsIgnoreCase( queryString, scheduledString ) }">
								<c:param name="scheduled" value="${ scheduled }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, ongoingString ) }">
								<c:param name="ongoing" value="${ ongoing }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, endString ) }">
								<c:param name="end" value="${ end }"></c:param>
							</c:if>
							<c:if test="${ !empty search }">
								<c:param name="search" value="${ search }"></c:param>
							</c:if>
							<c:if test="${ (empty content and content eq '') or  !empty content}">
								<c:param name="content" value="${ content }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSSString ) }">
								<c:param name="aucSS" value="${ aucSS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSEString ) }">
								<c:param name="aucSE" value="${ aucSE }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFSString ) }">
								<c:param name="aucFS" value="${ aucFS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFEString ) }">
								<c:param name="aucFE" value="${ aucFE }"></c:param>
							</c:if>
							<c:if test="${ !empty sort }">
								<c:param name="sort" value="${ sort }"></c:param>
							</c:if>
							<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
						</c:url>
						<a class="pagiset-link pagiset-next" href="${ goNext }"> <span
							class="visually-hidden">다음</span>
						</a>
					</div>
					<div class="pagiset-ctrl">
						<c:url var="goList" value="${ loc }">
							<c:if
								test="${ fn:containsIgnoreCase( queryString, scheduledString ) }">
								<c:param name="scheduled" value="${ scheduled }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, ongoingString ) }">
								<c:param name="ongoing" value="${ ongoing }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, endString ) }">
								<c:param name="end" value="${ end }"></c:param>
							</c:if>
							<c:if test="${ !empty search }">
								<c:param name="search" value="${ search }"></c:param>
							</c:if>
							<c:if test="${ (empty content and content eq '') or  !empty content}">
								<c:param name="content" value="${ content }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSSString ) }">
								<c:param name="aucSS" value="${ aucSS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucSEString ) }">
								<c:param name="aucSE" value="${ aucSE }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFSString ) }">
								<c:param name="aucFS" value="${ aucFS }"></c:param>
							</c:if>
							<c:if test="${ fn:containsIgnoreCase( queryString, aucFEString ) }">
								<c:param name="aucFE" value="${ aucFE }"></c:param>
							</c:if>
							<c:if test="${ !empty sort }">
								<c:param name="sort" value="${ sort }"></c:param>
							</c:if>
							<c:param name="page" value="${ pi.maxPage }"></c:param>
						</c:url>
						<a class="pagiset-link pagiset-last" href="${ goList }"> <span
							class="visually-hidden">마지막</span>
						</a>
					</div>
				</c:if>
			</nav>
		</div>
	<br>

	<script>
		const getLargePic = (data) =>{
	    	document.getElementById("largePic").setAttribute("src", data)
	    	document.getElementById("picModal").style.display = "block";
	    }
		
		const closeLarge = () =>{
	    	document.getElementById("picModal").style.display = "none";
	    }
	
		window.onload = () =>{
			const url = window.location.href;
			const checkAuctionPeriod = document.getElementById("checkAuctionPeriod");
			const auction = document.querySelectorAll("div[class='auction']");
			const monthPlace = document.querySelectorAll("span[class='monthPlace']");
			const yearPlace = document.querySelectorAll("span[class='yearPlace']");
			
			const modalClose = document.querySelector("button[id='modalClose']");
	    	modalClose.addEventListener('click',function(){
	    		document.body.style.overflow = '';
	    		document.getElementById("aucModal").style.display="none";
    		})
			
			if(url.includes("sort=low")){
				document.querySelectorAll("span[class='sorting']")[1].style.fontWeight = '1000';
			}else if(url.includes("sort=high")){
				document.querySelectorAll("span[class='sorting']")[0].style.fontWeight = '1000';
			}
			
			//체크박스 컨트롤
			document.querySelector("input[id='all']").addEventListener('click',function(){
				if(this.checked){
					for(const checkBox of document.querySelectorAll("input[class='auctionStatus']")){
						checkBox.checked = true;
					}
				}else{
					for(const checkBox of document.querySelectorAll("input[class='auctionStatus']")){
						checkBox.checked = false;
					}
				}
			})
			
			
			for(const closeBtn of document.querySelectorAll("button[class='close']")){
				closeBtn.addEventListener('click',function(){
					closeBtn.parentElement.parentElement.style.display = 'none';
				})
			}
			
			
			function checkLeapYear(selectYear){
				if(selectYear%400 == 0){
					return true;
				}else if(selectYear%100 == 0){
					return false;
				}else if(selectYear%4 == 0){
					return true;
				}else{
					return false;
				}
			}
			
			const year = new Date().getFullYear();
			const month = new Date().getMonth() +1;
			
			
			for(const yearSelect of yearPlace){
				yearSelect.innerText = year;
			}
			
			if(parseInt(month) < 10){
				for(const monthSelect of monthPlace){
					monthSelect.innerText = "0" + month;	
				}
			}else{
				for(const monthSelect of monthPlace){
					monthSelect.innerText = month;	
				}
			}
			
			
			for (let i = 0; i < monthPlace.length; i++) {
				changeYearMonth(yearPlace[i].innerText, monthPlace[i].innerText);
				
			    let currentIndex = i;

			    document.querySelectorAll("button[class='previous']")[currentIndex].addEventListener('click', function () {
			        if (parseInt(monthPlace[currentIndex].innerText) > 10) {
			            monthPlace[currentIndex].innerText = parseInt(monthPlace[currentIndex].innerText) - 1;
			        } else {
			            monthPlace[currentIndex].innerText = "0" + (parseInt(monthPlace[currentIndex].innerText) - 1);
			        }

			        if (parseInt(monthPlace[currentIndex].innerText) == 0) {
			            yearPlace[currentIndex].innerText = parseInt(yearPlace[currentIndex].innerText) - 1;
			            monthPlace[currentIndex].innerText = 12;
			        }
			        changeYearMonth(yearPlace[currentIndex].innerText, monthPlace[currentIndex].innerText);
			    });

			    document.querySelectorAll("button[class='next']")[currentIndex].addEventListener('click', function () {
			        if (parseInt(monthPlace[currentIndex].innerText) >= 9) {
			            monthPlace[currentIndex].innerText = parseInt(monthPlace[currentIndex].innerText) + 1;
			        } else {
			            monthPlace[currentIndex].innerText = "0" + (parseInt(monthPlace[currentIndex].innerText) + 1);
			        }

			        if (parseInt(monthPlace[currentIndex].innerText) == 13) {
			            yearPlace[currentIndex].innerText = parseInt(yearPlace[currentIndex].innerText) + 1;
			            monthPlace[currentIndex].innerText = '01';
			        }
			        changeYearMonth(yearPlace[currentIndex].innerText, monthPlace[currentIndex].innerText);
			    });
			}

			function getFirstDay(selectYear, selectMonth){
				if(selectMonth < 10){
					selectMonth = "0" + selectMonth;	
				}
				return (new Date(selectYear+ "-" + selectMonth + "-01").getDay());
			}
			
			
			function changeYearMonth(selectYear, selectMonth){
				let month_day = [31,28,31,30,31,30,31,31,30,31,30,31];
				if(selectMonth == 2){
					if(checkLeapYear(selectYear)) {
						month_day[1] = 29;
					}
				}
				
				let first_day_of_week = getFirstDay(selectYear, selectMonth);
				let arr_calendar = [];
			
				for(let i =0; i< first_day_of_week; i++){
					arr_calendar.push("");
				}
				
				for(let i = 1; i <= month_day[selectMonth-1]; i++){
					arr_calendar.push(String(i))
				}
				
				let remain_day = 7 - (arr_calendar.length%7);
				
				if(remain_day < 7) {
					for(let i =0; i < remain_day; i++){
						arr_calendar.push("");
					}
				}
				
				renderCalendar(arr_calendar);
			}
			
			function renderCalendar(data) {
				let h = [];
				for(let i = 0; i < data.length; i++){
					if(i == 0) {
						 h.push('<tr>');
					}else if(i%7 == 0){
						h.push('</tr>');
						h.push('<tr>');
					}
					h.push('<td>' + data[i] + '</td>');
				}
				
				h.push('</tr>');
				
				document.getElementsByClassName("tb_body")[0].innerHTML = h.join("");
				document.getElementsByClassName("tb_body")[1].innerHTML = h.join("");
				document.getElementsByClassName("tb_body")[2].innerHTML = h.join("");
				document.getElementsByClassName("tb_body")[3].innerHTML = h.join("");
			}
		}
		
		const openAuctionModal = (aucNo, startPrice, lastPrice, startDate, finishDate, memId, author, product, width, height, year, explain, pic) =>{
    		document.body.style.overflow = 'hidden';
    		const modal = document.querySelector('.modal');
    		let auctionModal = [];
    		
    		auctionModal.push(aucNo)
    		auctionModal.push(product)
    		auctionModal.push(author)
    		auctionModal.push(startPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + " 원")
    		auctionModal.push(lastPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + " 원")
    		if(memId == ''){
    			memId = '입찰자가 없습니다'
    		}
    		auctionModal.push(memId)
    		auctionModal.push(startDate.split(" ")[0])
    		auctionModal.push(finishDate.split(" ")[0])
    		auctionModal.push(width + "cm")
    		auctionModal.push(height + "cm")
    		
    		for(const [index, inputs] of document.querySelectorAll("input[class='modalInput']").entries()){
    			inputs.value = auctionModal[index];
    		}
    		
    		document.querySelector("img[id='picDiv']").setAttribute("src", pic);
    		document.querySelector("textarea[id='textBox']").value = explain;
    		modal.style.display = 'block';
		}
		
		
		
		
		
		const close = () =>{
			console.log(document.querySelectorAll("button[class='close']")[0].parentElement.parentElement)
		}
		
		function sortingPrice(data){
			for(const sortBtn of document.querySelectorAll("span[class='sorting']")){
				if(event.target == sortBtn){
					event.target.style.fontWeight = '1000';
				}else{
					sortBtn.style.fontWeight = '500';
				}
			}
			
			const url = window.location.href;
			console.log(url)
			let newUrl = null;
			switch(true){
			case (url.includes("adminInquiry.adac") && !url.includes("?page=")):
				if(!url.includes("?sort=")){
					newUrl = url + "?sort=" + data;
					history.pushState(null,null,newUrl);
				}else{
					newUrl = url.split("?")[0] + "?sort=" + data;
					history.pushState(null,null,newUrl);
				}
				break;
			case (url.includes("adminInquiry.adac") && url.includes("?page=")):
				newUrl = url.split("?")[0] + "?sort=" + data;
				history.pushState(null,null,newUrl);
				break;
			case (url.includes("search.adac?") && !url.includes("&page=")):
				if(!url.includes("&sort=")){
					newUrl = url + "&sort=" + data;
					history.pushState(null,null,newUrl);
				}else{
					newUrl = url.split("&sort=")[0] + "&sort=" + data;
					history.pushState(null,null,newUrl);
				}
				break;
			case (url.includes("search.adac?") && url.includes("&page=")):
				if(!url.includes("&sort=")){
					newUrl = url.split("&page=")[0] + "&sort=" + data;
					history.pushState(null,null,newUrl);
				}else{
					newUrl = url.split("&sort=")[0] + "&sort=" + data;
					history.pushState(null,null,newUrl);
				}
				break;
			}
			
			const styleObject = {
				    width: '100%',
				    height: '100%',
				    display: 'flex',
				    alignItems: 'center',
				    justifyContent: 'center',
				    textAlign: 'center',
				    borderBottom: '1px solid black',
				    cursor: 'pointer'
				};
			
			$("#infoPlace").load(location.href + " #infoPlace",function(){
				 $("#infoPlace").css({width: '100%',
					    height: '100%',
					    display: 'flex',
					    alignItems: 'center',
					    justifyContent: 'center',
					    textAlign: 'center',
					    cursor: 'pointer'});
			})
			
			
			
			
			
			
			
			event.target.style.color = 'oragne';
		}
		
		////////////////////////////////
		////////////////////////////////
		////////////////////////////////
		////////////////////////////////
		////////////////////////////////
		
		const resetCalendar = () =>{
				for(let i = 1; i < document.querySelectorAll("input[type='text']").length; i++){
					 document.querySelectorAll("input[type='text']")[i].value= "";
				}
			}
		
		
		const openPeriod = (data) =>{
			if(data.checked){
				document.getElementById("checkAuctionPeriod").style.display="block";
			}else{
				document.getElementById("checkAuctionPeriod").style.display='none';
			}
		}
		
		
		const allCheck = (data) =>{
			let checkCount = 0;
			if(event.target.checked){
				for(const checkBox of document.querySelectorAll("input[class='auctionStatus']")){
					if(checkBox.checked){
						checkCount++;
					}
				}
			}
			if(checkCount == document.querySelectorAll("input[class='auctionStatus']").length){
				document.querySelector("input[id='all']").checked = true;
			}else{
				document.querySelector("input[id='all']").checked = false;
			}
		}
		
		for(const td of document.getElementsByClassName("tb_body")){
			td.addEventListener('click', chooseDay);
		}
		//달력 선택 이벤트 추가해야됨
		
		function openCalendar(data){
			for(const calendars of document.querySelectorAll("div[class='calendar']")){
				if(calendars == data.nextElementSibling.nextElementSibling){
					data.nextElementSibling.nextElementSibling.querySelector("tbody[class='tb_body']").addEventListener('click',chooseDay);
					calendars.style.display='block';
				}else{
					calendars.style.display='none';
				}
			}
			
		}
		
		function chooseDay (event) {
    		if (event.target.tagName === 'TD') {
 	            const targetDay = event.target;
 	            const allTds = document.querySelectorAll('.tb_body td');

 	            allTds.forEach(td => {
 	                if (td != targetDay) {
 	                    td.style.background = 'white';
 	                    td.style.color = 'black';
 	                }
 	            });

 	            if (targetDay.innerText != '') {
 	                targetDay.style.background = 'black';
 	                targetDay.style.color = 'white';
 	                selectDay(targetDay.innerText);
 	            }
 	        }
		}
		
		
		function selectDay(targetDay) {
	   		if(parseInt(targetDay) < 10){
	   			targetDay = "0" + targetDay;
	   		}
	   		
	   		for(const selectBtn of document.querySelectorAll('button[class="select"]')){
	   			selectBtn.addEventListener('click',function(){
	   				event.target.parentElement.parentElement.previousElementSibling.value = event.target.parentElement.parentElement.querySelectorAll("span")[0].innerText + "-" + event.target.parentElement.parentElement.querySelectorAll("span")[1].innerText + "-" + targetDay;
	   				event.target.parentElement.parentElement.style.display = 'none';
	   			})
	   		}
		}
	</script>
</body>


</html>
