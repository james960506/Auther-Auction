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
<link rel="stylesheet" href="auction/auctionCss/scheduledAuction.css">
</head>
<body>
	
		
		
	<!-- 사진 확대 모달 제작 -->
	
	
	<div class="picModal">
  		<div class="picModal_content">
  			<img id="picModalImg">
  			<div>
  				<button id="closePicModal" onclick="closePicModal();" style="width: 10%; margin: 1% 5% 0 0;"> 닫기 </button>
  			</div>
  		</div>
  	</div>
  	
  	<jsp:include page="../common/header.jsp"/>	
	<div id="content-allOver-cover">
		<div id="content-left">
			<img id="leftImg" src="${ auction.attRename }">
		</div>
		<div id="contentRightCover">
			<div id="contentRightCoverDiv">
				<div id="timerZone">
					<span></span> <span id="remainingTime"></span>
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
							가로 : <span>${ auction.conWidth } cm</span>
							<br> 
							세로 : <span>${ auction.conHeight } cm</span>
						</div>
					</div>
				</div>
				<hr id="fH1">
				<span>
					<span id="srtMoneySpan">경매 시작가</span>
					<span id="moneyZone"><fmt:formatNumber value="${ auction.aucStartPrice }" pattern="#,##0" /> 원</span>
				</span>
				<br clear="all">
				<hr id="fHr">
				<span>
					<span id="nowPriceWord">경매 시작일</span>
					<span id="nowPrice"> ${ fn:split(auction.aucStartDate, " ")[0] }</span>
				</span>
				<br clear="all">
				<hr id="sHr">
				<span>
					<span id ="lastDay">경매 마감일</span>
					<span id="realDate"> ${ fn:split(auction.aucFinishDate, " ")[0] }</span>
				</span>
				<br clear="all">
				<hr id="tHr">
				<div id="forInfoPlace">
				    <div class="infoSpan" id="fees">
						낙찰 수수료
						<div class="tooltip">
							시작 가격을 기준으로<br>낙찰 수수료는 <span id="fees"></span>원입니다.
						</div>
					</div>
					<span class="infoSpan" id="priceTagBtn" onclick="openPriceModal();">경매 호가표</span> <span class="infoSpan" id="likeBtn">관심 목록 추가</span>
				</div>
				<div id="checkId"></div>
			</div>
		</div>
	</div>
	<div id="picturePlace">
		<c:forEach items="${ attachmentList }" var="attachmentList">
			<img id="rename" src="${ attachmentList.attRename }" onclick="expansion(this);">
		</c:forEach>
	</div>
	<br>
	<div id="api">
		<h1>이 작가의 다른 작품</h1>
		<h1 id="noShow"> 조회된 데이터가 없습니다</h1>
		<div class="owl-carousel owl-theme">
		</div>
	</div>


	<div id="divs">
		<div id="divsSec">작품 설명</div>
		<br>
		<pre id="explain" >${ auction.conEtc }</pre>
	</div>

	
	<!-- 호가표 모달창 -->
	<div id="priceTag">
		<div id="modal-content" class="modal-content">
			<h2 id="modalH2">호가표</h2>
			<table id="modalTable">
				<tr class="trLine">
					<th id="fTr">현재가 구간(원)</th>
					<th id="sTr">호가 단위(원)</th>
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
			<div id="modalDiv">
				<button id="closePriceTag">닫기</button>
			</div>
		</div>
	</div>

	<br>
	<br>
	
	<jsp:include page="../common/footer.jsp" />

	<script type="text/javascript">
		window.onload = () =>{
			
			document.getElementById("closePriceTag").addEventListener('click',function(){
				document.body.style.overflow = '';
				document.getElementById("priceTag").style.display = 'none'; 
			})
			document.querySelector("span[id='fees']").innerText = (Math.floor(parseInt('${ auction.aucStartPrice}') * 0.198)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			const likeBtn = document.querySelector("span[id='likeBtn']")
			
			const check = document.querySelector(("div[id='checkId']"));
			
			if(${ empty loginUser}){
				likeBtn.innerText = '로그인후 관심 목록 추가';
				likeBtn.addEventListener('click',function(){
					location.href="loginView";
				})
			}else{
				if(!likeBtn.innerText.includes("로그인후 관심 목록 추가")){
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
	        	
	        	likeBtn.addEventListener('click',function(){
					if(check.innerText != '로그인을 하셔야 관심 목록에 추가하실 수 있습니다'){
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
					}
	        	})
			}
			
			
			const dateObject = new Date('${ auction.aucStartDate }');
            
			let date = new Date();
            
            let remainTime = (dateObject - date);
            
			let seconds = Math.floor(remainTime / 1000);
			let minutes = Math.floor(seconds / 60);
			let hours = Math.floor(minutes / 60);
			let days = Math.floor(hours / 24);

			hours %= 24;
			minutes %= 60;
			seconds %= 60;
			
			check.innerText = "경매 시작까지 남은 시간 " + days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초";
			
				if(check == '0일 0시간 0분 0초' || seconds.toString().indexOf('-') != -1){
					check.innerText = '경매 페이지로 이동'
					/* document.querySelector("div[id='timerZone']").innerText = '경매 시작'
						check.addEventListener('click',function(){
							if(confirm('경매가 시작되었습니다. \n경매 페이지로 이동하시겠습니까?')){
								location.href='auctionDetail.ac?aucNo=${auction.aucNo}'
							}
						}) */
					}
			
			const timer = setInterval(function(){
				
				let date = new Date();
	            
	            let remainTime = (dateObject - date);
	            
	            
				let seconds = Math.floor(remainTime / 1000);
				let minutes = Math.floor(seconds / 60);
				let hours = Math.floor(minutes / 60);
				let days = Math.floor(hours / 24);

				hours %= 24;
				minutes %= 60;
				seconds %= 60;
				
				check.innerText = "경매 시작까지 남은 시간 " + days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초";
				
					if(check == '0일 0시간 0분 0초' || seconds.toString().indexOf('-') != -1){
						clearInterval(timer);
						check.innerText = '경매 페이지로 이동'
						document.querySelector("div[id='timerZone']").innerText = '경매 시작'
							check.addEventListener('click',function(){
								if(confirm('경매가 시작되었습니다. \n경매 페이지로 이동하시겠습니까?')){
									location.href='auctionDetail.ac?aucNo=${auction.aucNo}'
								}
							})
						}
				}, 1000);
			}
			
		
		const expansion = (data) =>{
        	
        	const modalPicture = document.querySelector("div[class='picModal_content']").children[0];
        	document.body.style.overflow = 'hidden';
        	modalPicture.setAttribute("src", data.src)
        	modalPicture.style.borderRadius = '10px';
        	
        	document.querySelector("div[class='picModal']").style.display = 'block';
        }
		
		
		
		const contentRightCover = document.getElementById("contentRightCover");
		
        function handleScroll() {
          let scrollPosition = window.scrollY;

          let divPosition = contentRightCover.getBoundingClientRect().top;

          if ( 182 >= scrollPosition) {
        	  contentRightCover.style.position = "absolute";
        	  contentRightCover.style.marginTop = "0";
          } else {
        	  if(window.scrollY <= 250){
        	  	contentRightCover.style.position = "fixed";
        	  	contentRightCover.style.marginTop = "-5%";
        	  }else{
          	  	contentRightCover.style.marginTop = "-3.5%";
        	  }
          }
        }
        
        window.addEventListener("scroll", handleScroll);
		
        
        const openPriceModal = () =>{
        	document.body.style.overflow = 'hidden';
        	document.querySelector("div[id='priceTag']").style.display = 'block';
        }
        
        const closePicModal = () =>{
        	document.body.style.overflow = '';
        	document.querySelector("div[class='picModal']").style.display = 'none';
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
    	        loop: true, // 항목들을 무한으로 반복하여 보여줄지 여부
    	        autoplay: true, // 자동	으로 슬라이드 쇼를 시작할지 여부
    	        autoplayTimeout: 3000, // 다음 이미지로 넘어가는 시간 (단위 : 밀리초)
    	        autoplayHoverPause: true, // 마우스가 이미지에 위에 있을 때 자동 슬라이드를 일시중지 할지 여부
    	    });           
    	}
	</script>
	 <script src="main/js/setting.js"></script>
  	<script src="main/js/plugin.js"></script>
 	 <script src="main/js/template.js"></script>
	  <script src="main/js/common.js"></script>
  	<script src="main/js/script.js"></script>
	<!-- 현재 입찰가를 낙찰 금액으로 변경 -->
	</body>
</html>
		
