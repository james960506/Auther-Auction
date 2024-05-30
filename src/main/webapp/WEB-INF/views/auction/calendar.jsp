<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
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
<link rel="stylesheet" href="auction/auctionCss/calendar.css">
<style>
	body{
		background-image: url('/image/background.jpg');
		background-repeat: no-repeat;
		background-size: cover;
	}
</style>

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div id="fDiv">
		<div id="calendarPlace">
		    <div id="calendar">
		        <div id="header"></div>
		        <div id="navigation">
		            <button  onclick="moveMonth(-1)" id="prevBtn"> previous Month</button>
		            <div id="dates"></div>
		            <button onclick="moveMonth(1)" id="nextBtn">Next Month</button>
		        </div>
		    </div>
	    </div>
	    <div id="sDiv">온라인 경매 일정</div>
	    <div id="svgDiv">
		    <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-calendar2-check" viewBox="0 0 16 16">
			  <path d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0"/>
			  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1z"/>
			  <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5z"/>
			</svg>
		</div>
	 	<div id="headLine" >매일 열리는 경매일정을 확인해 보세요!</div>
	    <div id="divinePlace">
			<div id="mainContent">
				<c:if test="${ empty aList }">
					<h1 id="ifNoData"> 해당 날짜에 시작하는 경매가 없습니다 </h1>
				</c:if>
			
				<div class="owl-carousel owl-theme">
					<c:forEach items="${ aList }" var="auction">
							<div class="item">
								<div class="auction" onclick="moveAuction(${auction.aucNo})">
									<img src="${ auction.attRename }" class="img"> <span>${ auction.conProduct }</span><br>
									<span>경매 시작 금액 : <fmt:formatNumber value="${ auction.aucStartPrice }" /> 원
									</span><br>
									<span>경매 기간 : ${ fn:split(auction.aucStartDate, " ")[0] } ~ ${ fn:split(auction.aucFinishDate, " ")[0] }</span><br>
								</div>
							</div>  
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
	
	<script>
		window.onload = () =>{
			let url = window.location.href;
			if(url.includes("?date=")){
				handleDateClick(url.split("-")[2] + "/새로고침");
				displayCalendar();
			}else{
				displayCalendar();
			}
		}
		
		function moveAuction(aucNo){
			location.href='scheduledAuction.ac?aucNo=' + aucNo;
		}
		
	
    	function carasel(){
    		const itemsLength = document.querySelectorAll("div[class='item']").length;
    		let itemsNum = 0;
    		switch(true){
	       	  case itemsLength == 1 :
	       		itemsNum = 1
	       		break;
	       	  case itemsLength == 2 :
	       		itemsNum = 2
	       		break;
	       	  default : 
	       		itemsNum = 3
	       		break;
	       	  }
    		var owl = $('.owl-carousel'); 
	    	owl.owlCarousel({
	       	  // 한번에 보여지는 이미지 수
	       	  items: itemsNum,
	          loop: true, // 항목들을 무한으로 반복하여 보여줄지 여부
	          autoplay: true, // 자동으로 슬라이드 쇼를 시작할지 여부
	          autoplayTimeout: 3000, // 다음 이미지로 넘어가는 시간 (단위 : 밀리초)
	          autoplayHoverPause: true, // 마우스가 이미지에 위에 있을 때 자동 슬라이드를 일시중지 할지 여부
	        });           
    	}
    
    
	    $(document).ready(function(){
	    	carasel();
	      });
    
        let currentDate = new Date();
        let selectedDate = new Date();
        

        function displayCalendar() {
        	 const header = document.getElementById('header');
             const dates = document.getElementById('dates');
             const prevBtn = document.getElementById('prevBtn');
             const nextBtn = document.getElementById('nextBtn');
             const today = new Date();
        	
       		const url = window.location.href;
       		console.log("url : " + url)
       		if(url.includes("?date=")){
       			selectedDate = new Date( url.split("=")[1] + 'T00:00:00+09:00');
       		}
       		
       		console.log("디스플레이 selectedDate : " + selectedDate)
       		
            header.textContent = currentDate.toLocaleString('ko-KR', { year: 'numeric', month: 'long' });
            
            let dateContent = '';


            const firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
            const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();

            for (let i = 1; i <= lastDayOfMonth; i++) {
                const currentDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), i);
                
                
                let	isFutureDate = currentDay > today || currentDay.toDateString() === today.toDateString();
                
                if (isFutureDate) {
                    const classNames = currentDay.toDateString() === selectedDate.toDateString() ? 'date-item current-date' : 'date-item future-date';
                    if(i <= 9) {
                    	dateContent += "<span class='" + classNames + "' onclick='handleDateClick(this.innerText)'>" + "&nbsp;" + i + "&nbsp;" + "</span>";
                    }else{
                    	dateContent += "&nbsp" + "<span class='" + classNames + "' onclick='handleDateClick(this.innerText)'>" + i + "</span>";
                    }
                }
            }

            dates.innerHTML = dateContent;

            // 이전 달 버튼 활성화/비활성화
            prevBtn.disabled = currentDate.getMonth() === today.getMonth() && currentDate.getFullYear() === today.getFullYear();
            if(prevBtn.disabled){
            	prevBtn.style.color = 'black';
            	prevBtn.style.background = 'gray';
            }else{
            	prevBtn.style.color = 'white';
            	prevBtn.style.background = 'darkgray';
            }
        }
        
        function moveMonth(months) {
        	const currentMonth = currentDate.getMonth();
        	console.log(currentMonth)
        	currentDate.setMonth(currentMonth + months);

        	    // 이동한 후에도 월이 변경되었는지 확인
        	if (currentDate.getMonth() !== (currentMonth + months) % 12) {
        	       // 변경된 경우, 월의 마지막 날짜로 설정
        	    currentDate.setDate(0);
        	}
        	    
            displayCalendar();
        }
        

        function handleDateClick(element) {
        	
        	if(element.includes("/새로고침")){
        		
	            const clickedDate = parseInt(element.split("/")[0]);
	            currentDate.setDate(clickedDate);
	            
	            selectedDate = new Date(currentDate);
	            displayCalendar();
        	}else{
	            const clickedDate = parseInt(element);
	            currentDate.setDate(clickedDate);
	            
	            const selectDate = currentDate.toLocaleDateString().split(".");
	            let selectYear = selectDate[0];
	            let selectMonth = selectDate[1].trim();
	            let selectDay = selectDate[2].trim();
	            
	            
	            
	            if(selectMonth.length == 1 ){
	                selectMonth = "0" + selectMonth;
	            }
	            
	            if(selectDay.length == 1 ){
	                selectDay = "0" + selectDay;
	            }
	            
	            let url = window.location.href;
	            let newUrl = null;
	            
	            switch(true){
	                case !url.includes("?date="):
	                    newUrl = url + "?date=" + selectYear + "-" + selectMonth + "-" + selectDay;
	                    history.pushState(null,null,newUrl);
	                    break;
	                case url.includes("?date="):
	                    newUrl = url.split("?")[0] + "?date=" + selectYear + "-" + selectMonth + "-" + selectDay;
	                    history.pushState(null,null,newUrl);
	                    break;
	            }
	            
	            selectedDate = new Date(currentDate);
	            displayCalendar();
	            
	            $("#mainContent").load(location.href + " #mainContent",()=>{
	            	carasel();        
	            });
	        }
        }
    </script>
</body>
</html>
