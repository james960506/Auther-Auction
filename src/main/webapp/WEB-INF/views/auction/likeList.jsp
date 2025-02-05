<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.kh.auction.user.model.vo.Auction" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="auction/auctionCss/likeList.css">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/myPageSide.jsp"/>
	<div id="content-allOver-cover">
		<div id="divine">
			<div id="headline">
				<div id="likeList">관심 경매 목록</div>
				<div id="btnPlace">
					<div id="seeWhich1" class="seeWhich" onclick="chooseAuction('all');">전체 보기</div>
					<div class="seeWhich" id="scheduled" onclick="chooseAuction('scheduled');">예정 경매</div>
					<div class="seeWhich" id="ongoing" onclick="chooseAuction('ongoing');">진행 경매</div>
					<div class="seeWhich" id="end" onclick="chooseAuction('end');">종료 경매</div>
					<span id="sortUp" class="price" onclick="sortPrice('high');">금액 높은순</span>
					<span id="sortDown" class="price" onclick="sortPrice('low');">금액 낮은순</span>
				</div>
				<div id="frame">
					<div class="firstLine">
						<input type="checkbox" id="allCheck" name="allCheck" onclick="allCheck(this);">
						<label for="allCheck">전체 선택</label>
					</div>
					<div class="firstLine">경매 번호</div>
					<div class="firstLine">작품 사진</div>
					<div class="firstLine">작가 명</div>
					<div class="firstLine">작품 명</div>
					<div class="firstLine">경매 기간</div>
					<div class="firstLine">경매 현황</div>
				</div>

				<div id="onlyLoad">
					<c:if test="${ empty aList }">
						<div class="auctionNoData">
							<h1>조회 가능한 데이터가 없습니다</h1>
						</div>
					</c:if>
					
					<div id="new">
						<c:forEach items="${ aList }" var="auction" varStatus="num">
							<div class="auction" onclick="moveAuction(${auction.aucNo});">
								<div class="checkZone">
									<input type="checkbox" class="eachCheck" onclick="eachCheckForAll();">
								</div>
								<div class="detailInfo">${ auction.aucNo }</div>
								<div id="detailInfoDiv" class="detailInfo">
									<img id="detailInfoDivImg" src="${ auction.attRename }"
										>
								</div>
								<div class="detailInfo" >${ auction.conAuthor }</div>
								<div class="detailInfo">${ auction.conProduct }</div>
								<div id="term">
									<div>시작일 : ${ fn:split(auction.aucStartDate, " ")[0] }<br>종료일 : ${ fn:split(auction.aucFinishDate, " ")[0] }</div>
								</div>
		
								<c:set var="startDateVar" value="${auction.aucStartDate}" />
								<c:set var="endDateVar" value="${auction.aucFinishDate}" />
								<c:set var="num" value="${num.index}" />
								
								
								<%
								Date today = new Date();
								SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								
								List<Auction> auctionList = (List<Auction>)request.getAttribute("aList");
								int i = (int)pageContext.getAttribute("num");
		
								String auctionStartDateStr = auctionList.get(i).getAucStartDate(); // "2024-01-10 15:30:00" 형태의 값으로 가정
								String auctionEndDateStr = auctionList.get(i).getAucFinishDate();
		
								Date auctionStartDate = dateFormat.parse(auctionStartDateStr);
								Date auctionEndDate = dateFormat.parse(auctionEndDateStr);
								
								if(today.compareTo(auctionStartDate) < 0){
								%>
									<div class="detailInfo"">
										진행 상황 : 예정 경매<br> 시작 금액 : <fmt:formatNumber value="${ auction.aucStartPrice }"/> 원
									</div>
								<%
								}else if(today.compareTo(auctionEndDate) > 0){
								%>
									<div class="detailInfo"">
										진행 상황 : 종료 경매<br> 낙찰 금액 : <fmt:formatNumber value="${ auction.aucFinishPrice }"/> 원
									</div>
								<%
								}else{
								%>
									<div class="detailInfo"">
										진행 상황 : 진행 경매<br> 입찰 금액 : <fmt:formatNumber value="${ auction.aucFinishPrice }"/> 원
									</div>
								<%								
								}
								%>
							</div>
						</c:forEach>
					</div>
					<div id="deleteBtnPlace">
						<button id="delBtn" onclick="deleteLike();">삭제</button>
					</div>
					
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
		                  <a class="pagiset-link pagiset-first" href="${ goFirst }">
		                     <span class="visually-hidden">처음</span>
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
		               <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }"
		                  var="p">
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
	         </div>
		</div>
	</div>
	</div>
	
	
	<jsp:include page="../common/footer.jsp" />

	<script>
		window.onload = () =>{
			const url = window.location.href;
			if(url.includes("sort=low")){
				document.querySelectorAll("span[class='price']")[1].style.fontWeight = '1000';;
			}else if(url.includes("sort=high")){
				document.querySelectorAll("span[class='price']")[0].style.fontWeight = '1000';;
			}
			
			switch(true){
			case url.includes("aucStatus=all"): 
				changeSee(0);
				break;
			case url.includes("aucStatus=scheduled"): 
				changeSee(1);
				break;
			case url.includes("aucStatus=ongoing"): 
				changeSee(2);
				break;
			case url.includes("aucStatus=end"): 
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
		
	
		function allCheck(data){
			if(data.checked){
				for(const checkBox of document.querySelectorAll("input[class='eachCheck']")){
					checkBox.checked = true;
				}
			}else{
				for(const checkBox of document.querySelectorAll("input[class='eachCheck']")){
					checkBox.checked = false;
				}
			}
		}
		
		function eachCheckForAll(){
			let checkCount = 0;
			for(const checkBox of document.querySelectorAll("input[class='eachCheck']")){
				if(checkBox.checked){
					checkCount++;
				}
				if(checkCount == document.querySelectorAll("input[class='eachCheck']").length){
					document.getElementById("allCheck").checked = true;
				}else{
					document.getElementById("allCheck").checked = false;
				}
			}
		}
		
		const deleteLike = () =>{
			let checkedNum = [];
			for(let checkedBox of document.querySelectorAll("input[class='eachCheck']")){
				if(checkedBox.checked){
					checkedNum.push(checkedBox.parentElement.nextElementSibling.innerText);
				}
			}
			if(checkedNum.length > 0){
				$.ajax({
					url:'interest.ac',
					type:'get',
					data:{checkedNum:checkedNum},
					success: (data) =>{
						if(data == 'deleteMypage'){
							$("#new").load(location.href + " #new");
						}
					},
					error: data => console.log(data)
				})
			}
		}
		
		function moveAuction (aucNo){
			if(document.querySelectorAll("div[class='auction']")[0].children[0].tagName != 'H1'){
				if(event.target.className != 'eachCheck' && event.target.className != 'checkZone'){
					switch(event.target.parentElement.children[6].innerText.split(":")[1].trim().split(" ")[0]){
					case '예정':
						//location.href='auctionDetailScheduled.ac?aucNo=' + aucNo + "&page="  + ${ pi.currentPage };
						break;
					default:
						location.href='auctionDetail.ac?aucNo=' + aucNo + "&page=" + ${ pi.currentPage };
						break;
					}
				}
	       	}
		}
		
		const chooseAuction = (data) =>{
		
			for(const priceBtn of document.querySelectorAll("span[class='price']")){
				priceBtn.style.fontWeight = '500';
			}
			const url = window.location.href;
			
			let newUrl = null;
			
			if(!url.includes("?aucStatus=") && !url.includes("?page=") && !url.includes("?sort=")){
			    let newUrl = url + "?aucStatus=" + data;
			    history.pushState(null, null, newUrl);
			}else{
				let newUrl = url.split("?")[0] + "?aucStatus=" + data;
				history.pushState(null, null, newUrl);
			}
			
		    refreshData();
			seeWhich();
		}
		
		function refreshData() {
			$("#onlyLoad").load(location.href + " #onlyLoad");
		}
		
		const seeWhich = () =>{
			document.addEventListener('click',function(event){
				if(event.target.className == 'seeWhich'){
					event.target.style.background = 'gray';
					const clickedElement = event.target;

                    for(let b of document.getElementsByClassName('seeWhich')){
                    	if(b != clickedElement) {
                        	b.style.background = '#f0f0f0';
						}
					}
				}
			})
		}
		
		const sortPrice = (data) =>{
			
			const url = window.location.href;
			
			let newUrl = null;
			
			let sort = data;
			
			switch(true){
			case (!url.includes("?aucStatus=") && !url.includes("?page=")):
				if(!url.includes("?sort")){
					newUrl = url + "?sort=" + data;
					history.pushState(null,null,newUrl);
				}else{
					newUrl = url.split("?")[0] + "?sort=" + data;
					history.pushState(null,null,newUrl);
				}
				break;
			case (!url.includes("?aucStatus=") && url.includes("?page=")):
				newUrl = url.split("?")[0] + "?sort=" + data;
				history.pushState(null,null,newUrl);
				break;
			case (url.includes("?aucStatus=") && !url.includes("&page=")):
				if(!url.includes("&sort")){
					newUrl = url +"&sort=" + data;
					history.pushState(null,null,newUrl);
				}else{
					newUrl = url.split("&")[0] +"&sort=" + data;
					history.pushState(null,null,newUrl);
				}
				break;
			case (url.includes("?aucStatus=") && url.includes("&page=")):
				newUrl = url.split("&")[0] + "&sort=" + data;
				history.pushState(null,null,newUrl);
				break;
			}
			
			refreshData();
			for(const sortBtn of document.querySelectorAll("span[class='price']")){
				if(sortBtn == event.target){
					sortBtn.style.fontWeight = '1000';
				}else{
					sortBtn.style.fontWeight = '500';
				}
			}	    
		}
    </script>
</body>
</html>
