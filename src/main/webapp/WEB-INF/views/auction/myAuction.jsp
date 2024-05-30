<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.kh.auction.user.model.vo.Auction"%>
<%@ page import="com.kh.auction.user.model.vo.BiddingDetail"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="auction/auctionCss/myAuction.css">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/myPageSide.jsp"/>

	<div id="content-allOver-cover">
		<div id="divine">
			<div id="headline">
				<div id="partList">참여 경매 목록</div>
				<div id="btnPlace">
					<div id="seeWhich" class="seeWhich" onclick="auctions('all');">전체 보기</div>
					<div class="seeWhich" onclick="auctions('ongoing');">진행 경매</div>
					<div class="seeWhich" onclick="auctions('end');">종료 경매</div>
					<div class="seeWhich" onclick="auctions('successBid');">낙찰 경매</div>
					<span id="sortUp" class="price" onclick="sortingPrice('high');">금액 높은순</span>
					<span id="sortDown" class="price" onclick="sortingPrice('low');">금액 낮은순</span>
				</div>
				<div class="infoCover">
					<div class="info">경매 번호</div>
					<div class="info">작품 사진</div>
					<div class="info">작가 명</div>
					<div class="info">작품 명</div>
					<div class="info">진행 상황</div>
					<div class="info">입찰 상태</div>
					<div class="info">금액</div>
				</div>

				
				
				<div id="forLoad">
					<c:if test="${ empty myBidList }">
						<div id="noDataDiv">
							<h1>조회 가능한 데이터가 없습니다</h1>
						</div>
					</c:if>
					
					<c:forEach items="${ myBidList }" var="myBidList" varStatus="bidStatus">
						<div class="auction" onclick="moveToAuction('${ myBidList.aucNo }');">
							<div class="divs">${ myBidList.aucNo }</div>
							<div class="renameDiv">
								<img class="imgZone" src="${ myBidList.attRename }">
							</div>
							<div class="divs">${ myBidList.conAuthor }</div>
							<div class="divs">${ myBidList.conProduct }</div>

							<c:forEach items="${ detailList }" var="detailList" varStatus="detailStatus">
								<c:if test="${bidStatus.index eq detailStatus.index}">
									<c:set var="bidIndex" value="${bidStatus.index}" />
									<%
									 Date today = new Date();
								
									  ArrayList<Auction> auctionList = (ArrayList<Auction>)request.getAttribute("myBidList");
									  
									  int i = (int)pageContext.getAttribute("bidIndex");
								
									  // 각 Auction 객체를 순회하면서 시작일과 종료일을 비교합니다.
									  String auctionEndDateStr = auctionList.get(i).getAucFinishDate();
								
									  // 시작일과 종료일을 Date 객체로 변환합니다.
									  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									  Date auctionEndDate = dateFormat.parse(auctionEndDateStr);
										    
									  String forSuccess = "";
									  
									 if(today.compareTo(auctionEndDate) > 0){
									  %>
									  	  <div class="divs">
									  	  종료 경매
									  	  <%
									  		forSuccess = "낙찰";									  	  
									  	  %>
									  	  </div>
									 <% 
									  }else{
									  %>
									  	  <div class="divs">
									  	  진행 경매
									  	  <%
										  	forSuccess = "입찰";
									  	  %>
										  </div>
								      <% 	
									  }
									  %>
									  <c:if test="${ myBidList.aucFinishPrice eq  detailList.bidPrice }">
										<div class="biddingStatus">
											<%= forSuccess %>
										</div>
									  </c:if>

									  <c:if test="${ !(myBidList.aucFinishPrice eq  detailList.bidPrice) }">
										<div class="biddingStatus">
											패찰
										</div>
									  </c:if>
									
									<div class="myBidListPrice"><fmt:formatNumber value="${ detailList.bidPrice }"/> 원</div>
								</c:if>
							</c:forEach>
						</div>
					</c:forEach>
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
								<c:if test="${ !empty aucStatus }">
									<c:param name="aucStatus" value="${ aucStatus }"></c:param>
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
									<c:if test="${ !empty aucStatus }">
										<c:param name="aucStatus" value="${ aucStatus }"></c:param>
									</c:if>
									<c:if test="${ !empty sort }">
										<c:param name="sort" value="${ sort }"></c:param>
									</c:if>
									<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
								</c:url>
								<a class="pagiset-link pagiset-prev" href="${ goBack }"> <span
									class="visually-hidden">이전</span>
								</a>
							</div>
						</c:if>
						<div class="pagiset-list">
							<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
								<c:url var="goNum" value="${ loc }">
									<c:if test="${ !empty aucStatus }">
										<c:param name="aucStatus" value="${ aucStatus }"></c:param>
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
									<c:if test="${ !empty aucStatus }">
										<c:param name="aucStatus" value="${ aucStatus }"></c:param>
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
									<c:if test="${ !empty aucStatus }">
										<c:param name="aucStatus" value="${ aucStatus }"></c:param>
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
					<br>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp" />

	<script>
		function check1(){
			var scrollPosition = window.scrollY;
			console.log("현재 스크롤 위치:", scrollPosition);
		}
	
	
		window.onload = () =>{
			const url = window.location.href;
			if(url.includes("sort=low")){
				document.querySelectorAll("span[class='price']")[1].style.fontWeight = '1000';
			}else if(url.includes("sort=high")){
				document.querySelectorAll("span[class='price']")[0].style.fontWeight = '1000';
			}
			
			switch(true){
			case url.includes("aucStatus=all"):
				changeSee(0);
				break;
			case url.includes("aucStatus=ongoing"):
				changeSee(1);
				break;
			case url.includes("aucStatus=end"):
				changeSee(2);
				break;
			case url.includes("aucStatus=successBid"):
				changeSee(3);
				break;
			default:
				changeSee(0);
				break;
			}
		}
		
		
		function changeSee(data) {
			const seeWhich = document.querySelectorAll("div[class='seeWhich']");
			seeWhich[data].style.background = 'gray'
			
			for (let i = 0; i < seeWhich.length; i++){
				if(seeWhich[i] != seeWhich[data]){
					seeWhich[i].style.background = '#f0f0f0'
				}
			}
			
		}
		
		
		function reloadSearch(data){
			for(let i = 0; i < document.querySelectorAll("div[class='seeWhich']").length; i++){
				if(i == data){
					document.querySelectorAll("div[class='seeWhich']")[i].style.background = 'gray';
				}else{
					document.querySelectorAll("div[class='seeWhich']")[i].style.background = '#f0f0f0';
				}
			}
		}
		
	
        const moveToAuction = (data)=>{
        	location.href="auctionDetail.ac?aucNo=" + data + "&page=" + ${pi.currentPage};
        }
        
        const seeSwitch = () =>{
			if(event.target.className == 'seeWhich'){
				event.target.style.background = 'gray';
				const clickedElement = event.target;

                   for(let b of document.getElementsByClassName('seeWhich')){
                   	if(b != clickedElement) {
                       	b.style.background = '#f0f0f0';
					}
				}
			}
			
			for(const priceBtn of document.querySelectorAll("span[class='price']")){
				priceBtn.style.fontWeight = '500';
			}
        }
        
        function refresh(){
        	$("#forLoad").load(location.href + " #forLoad");
        }
        
        const auctions = (data) =>{
        	let url = window.location.href;
        	
        	let newUrl = null;
        	
        	
        	if(!url.includes("?aucStatus=") && !url.includes("?page=") && !url.includes("?sort=")){
			    let newUrl = url + "?aucStatus=" + data;
			    history.pushState(null, null, newUrl);
			}else{
				let newUrl = url.split("?")[0] + "?aucStatus=" + data;
				history.pushState(null, null, newUrl);
			}
        	
        	refresh();
        	seeSwitch();
        }
        
        function sortingPrice(data){
        	let url = window.location.href;
        	
        	let newUrl = null;
        	
        	switch(true){
        	case (!url.includes("?aucStatus") && !url.includes("?page")):
        		if(!url.includes("?sort")){
        			newUrl = url + "?sort=" + data;
					history.pushState(null,null,newUrl);
        		}else{
        			newUrl = url.split("?")[0] + "?sort=" + data;
					history.pushState(null,null,newUrl);
        		}
        		break;
        	case (!url.includes("?aucStatus") && url.includes("?page")):
        		newUrl = url.split("?")[0] + "?sort=" + data;
        		history.pushState(null,null,newUrl);
        		break;
        	case (url.includes("?aucStatus") && !url.includes("&page")):
        		if(!url.includes("&sort")){
        			newUrl = url + "&sort=" + data;
        			history.pushState(null,null,newUrl);
        		}else{
        			newUrl = url.split("&")[0] + "&sort=" + data;
        			history.pushState(null,null,newUrl);
        		}
        		break;
        	case (url.includes("?aucStatus") && url.includes("&page")):
        		if(!url.includes("&sort")){
        			newUrl = url.split("&")[0] + "&sort=" + data;
        			history.pushState(null,null,newUrl);
        		}else{
        			newUrl = url.split("&")[0] + "sort=" + data;
        			history.pushState(null,null,newUrl);
        		}
        		break;
        	}
        	
        	refresh();
        	
        	for(const priceBtn of document.querySelectorAll("span[class='price']")){
        		if(event.target == priceBtn){
        			priceBtn.style.fontWeight = '1000';
        		}else{
        			priceBtn.style.fontWeight = '500';
        		}
        	}
        }
        
        
	</script>
</body>
</html>