<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="main/css/setting.css">
<link rel="stylesheet" href="main/css/plugin.css">
<link rel="stylesheet" href="main/css/template.css">
<link rel="stylesheet" href="main/css/common.css">
<link rel="stylesheet" href="main/css/main.css">
<link rel="stylesheet" href="main/css/style.css">
<link rel="stylesheet" href="auction/auctionCss/auctionDetail.css">
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<!-- 사진 확대 모달 제작 -->
	<div class="picModal">
 		<div class="picModal_content">
 			<img id="picModalImg">
 			<div>
 				<button id="closePicModal"> 닫기 </button>
 			</div>
 		</div>
 	</div>
 	<!-- 모달 끝 -->

	<div id="content-allOver-cover">
		<div id="content-left">
			<img id="auctionImg" src="${ auction.attRename }">
		</div>
		<div id="contentRightCover">
			<div id="consCover">
				<div id= "lastZone">
					<span>남은 경매 시간</span> <span id="remainingTime"></span>
				</div>
				<div id="lotNumDiv">
					<span id="lotNum">LOT NUMBER ${ auction.aucNo }</span>
				</div>
				<div class="productInfo" id="authorPlaceCover">
					<span id="authorPlace">${ auction.conAuthor }</span>
				</div>
				<div class="productInfo">
					<span id="productPlace">${ auction.conProduct }</span>
				</div>
				<div class="productInfo">
					<div>
						<div id="lengthZone">
							가로 : <span>${ auction.conWidth } cm</span><br> 세로 : <span>${ auction.conHeight } cm</span>
						</div>
					</div>
				</div>
				<hr id="fHr">
				<span> 
					<span id="sMoneySpan">경매 시작가</span>
					<span id="sMoney">
						<fmt:formatNumber value="${ auction.aucStartPrice }" pattern="#,##0" /> 원
					</span>
				</span>
				
				<br clear="all">
				
				<hr id="sHr">
				<span>
					<span id="nowPriceWord">현재 입찰가</span>
					<span id="nowPrice"></span>
				</span>
				
				<br clear="all">
				
				<hr id="tHr">
				<span>
					<span id="endTime">경매 마감 시간</span>
					<span id="endTimeT"> ${ fn:split(auction.aucFinishDate, " ")[0] }</span>
				</span>
				
				<br clear="all">
				
				<hr id="lHr">
				<div id="forInfoPlace">
				    <div class="infoSpan" id="fees">
						낙찰 수수료
						<div class="tooltip">
							현재 가격을 기준으로<br> 낙찰 수수료는 <span id="showFees"></span>원입니다.
						</div>
					</div>
					<span class="infoSpan" id="priceTagBtn">경매 호가표</span>
					<span class="infoSpan" id="likeBtn">관심 목록 추가</span>
				</div>
				<div id="checkId"></div>
			</div>
		</div>
	</div>
	<div id="picturePlace">
		<c:forEach items="${ attachmentList }" var="attachmentList">
			<img class="littleImg" src="${ attachmentList.attRename }" onclick="expansion(this);">
		</c:forEach>
	</div>
	
	<br>
	
	<div id="api">
		<h1 id="aAuthor">이 작가의 다른 작품</h1>
		<h1 id="noShow"> 조회된 데이터가 없습니다</h1>
		<div class="owl-carousel owl-theme"></div>
	</div>
	
	
	<div id="explainZone">
		<div id="eZone">작품 설명</div>
		
		<br>
		
		<pre id="explain">${ auction.conEtc }</pre>
	</div>
	
	
	<!-- 호가표 모달창 -->
	<div id="priceTag">
		<div class="modal-content">
			<h2 id="modalPrice">호가표</h2>
			<table id="modalTable">
				<tr class="trLine">
					<th id="fTh">현재가 구간(원)</th>
					<th id="sTh">호가 단위(원)</th>
				</tr>
				<tr class="trLine">
					<td>30만 미만</td>
					<td>20,000</td>
				</tr>
				<tr class="trLine">
					<td>30만 이상 ~ 100만 미만</td>
					<td>50,000</td>
				</tr>
				<tr class="trLine">
					<td>100만 이상 ~ 300만 미만</td>
					<td>100,000</td>
				</tr>
				<tr class="trLine">
					<td>300만 이상 ~ 500만 미만</td>
					<td>200,000</td>
				</tr>
				<tr class="trLine">
					<td>500만 이상 ~ 1,000만 미만</td>
					<td>500,000</td>
				</tr>
				<tr class="trLine">
					<td>1,000만 이상 ~ 3,000만 미만</td>
					<td>1,000,000</td>
				</tr>
				<tr class="trLine">
					<td>3,000만 이상 ~ 5,000만 미만</td>
					<td>2,000,000</td>
				</tr>
				<tr class="trLine">
					<td>5,000만 이상 ~ 2억 미만</td>
					<td>5,000,000</td>
				</tr>
				<tr class="trLine">
					<td>2억 이상 ~ 5억 미만</td>
					<td>10,000,000</td>
				</tr>
				<tr class="trLine">
					<td>5억 이상</td>
					<td>20,000,000</td>
				</tr>
			</table>
			<div id="cZone">
				<button id="closePriceTag">닫기</button>
			</div>
		</div>
	</div>
	
	<!-- 입찰 모달 -->
	<div id="bidModal">
		<div id="modal-content_bid">
			<h2>입찰</h2>
			<div>
				<div class="bidModalDiv">
					현재입찰가
				</div>
				<div class="bidModalDiv" id="modalNowPrice"></div>
				<div class="bidModalDiv">
					최소 입찰가
				</div>
				<div class="bidModalDiv" id="minPrice"></div>
				<div class="bidModalDiv">
					보유한 금액
				</div>
				<div class="bidModalDiv" id="possession">
					<fmt:formatNumber value="${ memBalance }" pattern="#,##0" /> 원
				</div>
				<div id="bZoneCover">
					<div id="bidSize">입찰할 금액</div>
					<input type="number" value="" id="myInputPoint" pattern="\d*">
					원
					<div id="chargeZone">
						<button id="chargeBtn" onclick="movePointCharge();">금액 충전</button>
					</div>
				</div>
			</div>
			<div id="buttonZone">
				<div id="closeBidModal">닫기</div>
				<div id="insertBid">입찰</div>
			</div>
		</div>
	</div>
	
	<br>
	<br>
	
	<jsp:include page="../common/footer.jsp" />
	
	<!-- 현재 입찰가를 낙찰 금액으로 변경 -->
	
	<script>
	
		const movePointCharge = () =>{
			location.href='pointpayment.ar';
		}
	
		window.onload = function(){
	       	const priceTagBtn = document.getElementById("priceTagBtn");
	       	const priceTag = document.getElementById("priceTag");
	       	const closePriceTag = document.getElementById("closePriceTag");
	       	const nowPrice = document.getElementById("nowPrice");
	       	const likeBtn = document.getElementById("likeBtn");
	       	const modalNowPrice = document.getElementById("modalNowPrice");
	       	const minPrice = document.getElementById("minPrice");
	       	const bidModal = document.getElementById("bidModal");
	       	const closeBidModal = document.getElementById("closeBidModal");
	       	const myInputPoint = document.getElementById("myInputPoint");
	       	const insertBid = document.getElementById("insertBid");
	       	const check = document.getElementById("checkId");
	       	let remainingTime = document.getElementById("remainingTime");
	       	const possession = document.getElementById("possession");
	       	const nowPriceWord = document.getElementById('nowPriceWord')
	       	
	       	document.getElementById("closePicModal").addEventListener('click',function(){
	       		document.body.style.overflow = '';
	       		document.querySelector("div[class='picModal']").style.display = 'none';
	       	})
	       	
	       	
	       	/* 모달창 컨트롤 */
	       	priceTagBtn.addEventListener('click',function(){
	       		document.body.style.overflow = 'hidden';
	       		priceTag.style.display='block';
	       	})
	       	closePriceTag.addEventListener('click',function(){
	       		document.body.style.overflow = '';
	       		priceTag.style.display='none';
	       	})
	       	
	       	closeBidModal.addEventListener('click',function(){
	       		document.body.style.overflow = '';
	       		bidModal.style.display="none";
	       		if(nowPrice.innerText == "0 원"){
	   				myInputPoint.value = '${ auction.aucStartPrice }';
	   			}else{
	   				if(jsonObject == null){
	    				const aucFinishPrice = parseInt('${ auction.aucFinishPrice }');
	    				
	    				const minIncrement = checkMin(parseInt('${ auction.aucFinishPrice }'))
	    				
	    				let minPoint = aucFinishPrice + minIncrement;
	    				
	    				const formatMinPoint = minPoint.toLocaleString();
	
	    				myInputPoint.setAttribute("min", aucFinishPrice + minIncrement);
	    				myInputPoint.value = aucFinishPrice + minIncrement;
	    				minPrice.innerText = formatMinPoint.concat(' 원');
	    				
	    			}
	   			}
	       	})
	       	
	       	//들어왔을시 좋아요 체크
	       	if(${ loginUser != null }){
	        	$.ajax({
	        		url:'checkLike.ac',
	        		type:'get',
	        		data:{aucNo:'${auction.aucNo}'},
	        		success: data =>{
	        			if(data != 0){
	        				console.log(data);
	        				likeBtn.innerText = '관심 목록 삭제';
	                		likeBtn.style.background = 'black';
	                		likeBtn.style.color = 'white';
	        			}
	        		},
	        		error: data => console.log(data)
	        	})
	       	}
		       	
	       	function bidding(){
	       		document.body.style.overflow = 'hidden';
	       		bidModal.style.display="block";
	       	}
		       	
		       	
	       	//로그인에 따른 입찰/로그인/관심목록 추가
	       	if(${ loginUser != null }){
				check.innerText = "입찰하기";
				check.addEventListener('click', bidding);
				likeBtn.addEventListener('click',function(){
					if(checkId.innerText != '경매 종료'){
						$.ajax({
							url:'interest.ac',
							type:'get',
							data:{aucNo:'${ auction.aucNo }'},
							success: data =>{
								if(data == 'insert'){
									likeBtn.innerText = '관심 목록 삭제';
									likeBtn.style.background = 'black';
									likeBtn.style.color = 'white';
								}else{
									likeBtn.innerText = '관심 목록 추가';
									likeBtn.style.background = 'white';
									likeBtn.style.color = 'black';
								}
							},
							error: data => console.log(data)
						})
					}else{
						if(likeBtn.style.background = 'black'){
							$.ajax({
								url:'interest.ac',
								type:'get',
								data:{aucNo:'${ auction.aucNo }'},
								success: data =>{
										likeBtn.innerText = '관심 목록 추가';
										likeBtn.style.background = 'white';
										likeBtn.style.color = 'black';
								},
								error: data => console.log(data)
							})
						}else{
							alert('종료된 경매입니다')	
						}
					}
				})
	       	}else{
	       		check.innerText = "로그인 후 입찰 가능합니다";
	       		check.addEventListener('click',function(){
	       			location.href="loginView";
	       		})
	       		likeBtn.addEventListener('click',function(){
	   				if(confirm("로그인을 하셔야 관심 목록에 추가하실 수 있습니다. \n로그인 하시겠습니까?")){
	   					location.href='loginView';
	   				}
	   			})
	       	}
		       	
       		//남은 경매시간 계속 갱신 및 경매 종료시 입찰 기능 삭제
			const dateObject = new Date('${ auction.aucFinishDate }');
           
			let date = new Date();
           
			let remainTime = (dateObject - date);
		           
			let seconds = Math.floor(remainTime / 1000);
			let minutes = Math.floor(seconds / 60);
			let hours = Math.floor(minutes / 60);
			let days = Math.floor(hours / 24);
	
			hours %= 24;
			minutes %= 60;
			seconds %= 60;
				
			if(seconds.toString().indexOf('-') == -1){
				remainingTime.innerText = days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초";
			}else{
				remainingTime.innerText = '경매 종료';
				check.innerText = '경매 종료'
				check.removeEventListener('click',bidding);
				nowPriceWord.innerText = '최종 낙찰가';
			}
				
			let timer = setInterval(() => {
				let date = new Date();
				let remainTime = (dateObject - date);
	            
				let seconds = Math.floor(remainTime / 1000);
				let minutes = Math.floor(seconds / 60);
				let hours = Math.floor(minutes / 60);
				let days = Math.floor(hours / 24);
	
				hours %= 24;
				minutes %= 60;
				seconds %= 60;
				
				remainingTime.innerText = days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초";
				
				if(remainingTime.innerText == '0일 0시간 0분 0초' || seconds.toString().indexOf('-') != -1){
					clearInterval(timer);
					remainingTime.innerText = '경매 종료';
					check.innerText = '경매 종료'
					check.removeEventListener('click',bidding);
					nowPriceWord.innerText = '최종 낙찰가';
				}
			}, 1000);
				
			// 상태에 따른 최소 입찰가 및 최초 기본 입찰가 변경
			if(${ auction.aucFinishPrice eq 0 }){
				nowPrice.innerText = "0 원"; 
				modalNowPrice.innerText = "0 원";
				minPrice.innerHTML = '<fmt:formatNumber value="${ auction.aucStartPrice }"/> 원';
				myInputPoint.setAttribute("min", ${ auction.aucStartPrice })
				myInputPoint.value= '${ auction.aucStartPrice }';
			}else{
				nowPrice.innerHTML = '<fmt:formatNumber value="${ auction.aucFinishPrice }"/> 원';
				modalNowPrice.innerHTML = '<fmt:formatNumber value="${ auction.aucFinishPrice }"/> 원';
				
				const aucFinishPrice = parseInt('${ auction.aucFinishPrice }');
	  				
  				const minIncrement = checkMin(parseInt('${ auction.aucFinishPrice }'))
	  				
  				let minPoint = aucFinishPrice + minIncrement;
				
				const formatMinPoint = minPoint.toLocaleString();
	
				myInputPoint.setAttribute("min", aucFinishPrice + minIncrement);
				myInputPoint.value = aucFinishPrice + minIncrement;
				minPrice.innerText = formatMinPoint.concat(' 원');
			}
				
								
			document.querySelector("span[id='showFees']").innerText = (Math.floor(parseInt('${auction.aucFinishPrice}')/ 100 * 0.198) * 100 ).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") ; 
				
			//입찰 버튼 눌렀을때 반응
			insertBid.addEventListener('click',function(){
				if(myInputPoint.value != parseInt(myInputPoint.value)){
					alert("숫자만 입력하실 수 있습니다");
					myInputPoint.value = '';
				}else{
					if(parseInt(myInputPoint.value) > '${ loginUser.memBalance }'){
						if(confirm('보유하신 금액이 부족합니다, \n충전 페이지로 이동하시겠습니까?')){
								location.href="pointpayment.ar";
						}
					}else{
						if(nowPrice.innerText == "0 원") {
							if(parseInt(myInputPoint.value) < '${ auction.aucStartPrice}'){
								alert('최소입찰가보다 작게 입찰할 수 없습니다');
							}else if(confirm("입찰하시고 나면 취소하실 수 없습니다\n그래도 입찰시겠습니까?")){
								$.ajax({
									url: 'insertBid.ac',
									type: 'post',
									data:{bidMoney:myInputPoint.value, aucNo:'${ auction.aucNo}'},
									success: data =>{
										if(data != 'fail'){
											let jsonObject = JSON.parse(data)
											const aucFinishPriceJs = jsonObject[0].aucFinishPrice;
											const memBalanceJs = jsonObject[0].memBalance;
											const headMoney = document.getElementById("headMoney");
											alert("입찰에 성공하였습니다.") //에이젝스로 새로 갱신
											bidModal.style.display = 'none';
											nowPrice.innerText = aucFinishPriceJs.toLocaleString().concat(" 원");
											modalNowPrice.innerText = aucFinishPriceJs.toLocaleString().concat(" 원");
											//
											
						    				const minIncrement = checkMin(aucFinishPriceJs)
						    				
											
											let minPoint = aucFinishPriceJs + minIncrement;
											
											const formatMinPoint = minPoint.toLocaleString();
							
											myInputPoint.setAttribute("min", aucFinishPriceJs + minIncrement);
											myInputPoint.value = aucFinishPriceJs + minIncrement;
											minPrice.innerText = formatMinPoint.concat(' 원');
											possession.innerText = memBalanceJs.toLocaleString().concat(" 원");
											headMoney.innerText = memBalanceJs.toLocaleString().concat(" 원");
											document.body.style.overflow = '';
											
											//
										}else{
											alert("입찰에 실패하였습니다.");
											location.reload();
										}
									},
									error: data => console.log(data)
								})
							}
						}else{
							if(parseInt(myInputPoint.value) < parseInt(minPrice.innerText.replace(/,/g, '').split(' ')[0])){
								alert('최소입찰가보다 작게 입찰할 수 없습니다');
							}else if(confirm("입찰하시고 나면 취소하실 수 없습니다\n그래도 입찰시겠습니까?")){
								$.ajax({
									url: 'insertBid.ac',
									type: 'post',
									data:{bidMoney:myInputPoint.value, aucNo:'${ auction.aucNo}'},
									success: data =>{
										if(data != 'fail'){
											let jsonObject = JSON.parse(data)
											const aucFinishPriceJs = jsonObject[0].aucFinishPrice;
											const memBalanceJs = jsonObject[0].memBalance;
											const headMoney = document.getElementById("headMoney");
											alert("입찰에 성공하였습니다.") //에이젝스로 새로 갱신
											
											bidModal.style.display = 'none';
											nowPrice.innerText = aucFinishPriceJs.toLocaleString().concat(" 원");
											modalNowPrice.innerText = aucFinishPriceJs.toLocaleString().concat(" 원");
											
											const minIncrement = checkMin(aucFinishPriceJs)
						    				
											let minPoint = aucFinishPriceJs + minIncrement;
											
											const formatMinPoint = minPoint.toLocaleString();
							
											myInputPoint.setAttribute("min", aucFinishPriceJs + minIncrement);
											myInputPoint.value = aucFinishPriceJs + minIncrement;
											minPrice.innerText = formatMinPoint.concat(' 원');
											possession.innerText = memBalanceJs.toLocaleString().concat(" 원");
											headMoney.innerText = memBalanceJs.toLocaleString().concat(" 원");
											document.body.style.overflow = '';
											
											//
										}else{
											alert("입찰에 실패하였습니다.");
											location.reload();
										}
									},
									error: data => console.log(data)
								})
							}
						}
					}
				}
				document.body.style.overflow = '';
			})
		}
	      
	       
		const contentRightCover = document.getElementById("contentRightCover");

		function handleScroll() {
			let scrollPosition = window.scrollY;

			let divPosition = contentRightCover.getBoundingClientRect().top;

			if ( 182 >= scrollPosition) {
				contentRightCover.style.position = "absolute";
				contentRightCover.style.marginTop = "0";
			}else {
				if(window.scrollY <= 250){
					contentRightCover.style.marginTop = "-8%";
					contentRightCover.style.position = "fixed";
       	  		}else if(window.scrollY > 250){
    				contentRightCover.style.position = "fixed";
    				contentRightCover.style.marginTop = "-4.5%";
       	  		}
         	}
		}
	       
		window.addEventListener("scroll", handleScroll);
	       
		const expansion = (data) =>{
			const modalPicture = document.querySelector("div[class='picModal_content']").children[0];
	       	document.body.style.overflow = 'hidden';
	       	modalPicture.setAttribute("src", data.src)
	       	modalPicture.style.borderRadius = '10px';
	       	
	       	document.querySelector("div[class='picModal']").style.display = 'block';
		}
	
	       
		let itemsNum = 0;
	       
		var xhr = new XMLHttpRequest();
		
		var url = 'http://openapi.seoul.go.kr:8088/6b645362786b79773339516a6f6f59/json/SemaPsgudInfoKorInfo/1/1000'; 
	   	xhr.open('GET', url,false);
	   	xhr.onreadystatechange = function () {
	   	    if (this.readyState == xhr.DONE) {  
	   	        if(xhr.status == 200||xhr.status == 201){
	   	            let jsonResponse = JSON.parse(xhr.responseText);
	   	            let itemsContainer = document.querySelector("div[class='owl-carousel owl-theme']");
	   	            
	   	            for (let i = 0; i < jsonResponse.SemaPsgudInfoKorInfo.row.length; i++){
	   	                let row = jsonResponse.SemaPsgudInfoKorInfo.row[i];
	   	                
	                   	if(row.writr_nm == '${ auction.conAuthor }'){
	   	                	if (row.prdct_cl_nm === '드로잉&판화' || row.prdct_cl_nm === '회화' || row.prdct_cl_nm === '한국화') { 
	    	                    let imgElement = document.createElement("img");
	    	                    imgElement.src = row.main_image;
	    	                    imgElement.className = 'item'
	    	                    	
	    	                    itemsNum++;
	    	                    
	    	                    imgElement.onclick = function(){
	    	                    	expansion(this)
	    	                    }
	    	                    itemsContainer.appendChild(imgElement);
	    	                }
	    	            }
	   	            }
	   	            carasel(itemsNum);
	   	        }
	   	    }
	   	};
	   	xhr.send('');
	
		function carasel(itemsNum){
			if(itemsNum > 2){
				itemsNum = 2
			}else if(itemsNum == 0){
				document.querySelector("h1[id='noShow']").style.display = 'flex';
			}
	      		
			var owl = $('.owl-carousel'); 
      	    owl.owlCarousel({
      	        items: itemsNum,
      	        loop: true, 
      	        autoplay: true,
      	        autoplayTimeout: 3000,
      	        autoplayHoverPause: true,
      	    });
		}
	
		function checkMin(aucFinishPrice){
	      		
			let minIncrement = 0;
	      		
			switch (true) {
			  case aucFinishPrice < 300000:
			    minIncrement = 20000;
			    break;
			  case aucFinishPrice < 1000000:
			    minIncrement = 50000;
			    break;
			  case aucFinishPrice < 5000000:
			    minIncrement = 100000;
			    break;
			  case aucFinishPrice < 10000000:
			    minIncrement = 200000;
			    break;
			  case aucFinishPrice < 30000000:
			    minIncrement = 1000000;
			    break;
			  case aucFinishPrice < 50000000:
			    minIncrement = 2000000;
			    break;
			  case aucFinishPrice < 200000000:
			    minIncrement = 5000000;
			    break;
			  case aucFinishPrice < 500000000:
			    minIncrement = 1000000;
			    break;
			  default:
			    minIncrement = 20000000;
			}
	      		return minIncrement;
		}
		
	   </script>
		<script src="main/js/setting.js"></script>
		<script src="main/js/plugin.js"></script>
		<script src="main/js/template.js"></script>
		<script src="main/js/common.js"></script>
		<script src="main/js/script.js"></script>
	</body>
</html>
