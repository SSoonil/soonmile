<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link rel="stylesheet" href="/resources/css/map.css" />
<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
</head>
<body class="is-preload homepage">
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header-wrapper">
			<header id="header" class="container">

				<!-- Logo -->
				<div id="logo">
					<h1>
						<a href="/">Soonil</a>
					</h1>
				</div>

				<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

			</header>
		</div>


		<!-- Main -->
		<div id="main-wrapper" style="height: 700px;">
			<div class="container" style="height: 120%;">
				<div class="row gtr-200" style="height: 100%;">
					<div class="col-4 col-12-medium">

						<!-- Sidebar -->
						<div id="sidebar">
							<section class="widget thumbnails" style="height:500px;">
								<select name="selectedGroup" id="selectedGroup" style="width:100%; padding:1px;">
									<option value="all" selected>전체</option>
									<c:forEach var="group" items="${groups }" varStatus="status">
										<option value="${group.groupId }">${group.groupName }</option>
									</c:forEach>
								</select>
								<h3>장소 리스트</h3>
								<div class="grid" style="overflow-y:scroll; height:380px;">
									<div class="row gtr-50" id="placeList">
										<div class="col-61 placeDiv">
											<h3 class="place">등록된 장소가 없습니다. 장소를 검색하고 등록해주세요.</h3>
											
										</div>
										
									</div>
								</div>
							</section>
						</div>

					</div>
					<div class="col-8 col-12-medium imp-medium">

						<!-- Content -->

						<div class="map_wrap">
							<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
							<div id="menu_wrap" class="bg_white">
								<div class="option">
									<div>
										<form onsubmit="searchPlaces(); return false;">
											키워드 : <input type="text" value="" id="keyword"
												size="15">
											<button type="submit">검색하기</button>
										</form>
									</div>
								</div>
								<hr>
								<ul id="placesList"></ul>
								<div id="pagination"></div>
							</div>
						</div>






					</div>
				</div>
			</div>
		</div>

		<div id="banner-wrapper" style="margin-top: 50px;">
			<div id="banner" class="box container">
				<div class="row">
					<div id="selected" class="col-61">
					<form id="placeForm">
						<input id="placeName" name="placeName" value="음식점 이름" readonly="readonly" style="border:0; font-size:4em; line-height: 1em; outline: none;"> 
						<p>주소 :<input id="placeAddr" name="placeAddr" value="경기도 시흥시 인선길 63" readonly="readonly" style="border:0; font-size:0.7em; outline: none; width:70%;"></p>
						<p>도로명 주소 :<input id="placeRoadAddr" name="placeRoadAddr" value="경기도 시흥시 인선길 63" readonly="readonly" style="border:0; font-size:0.7em; outline: none; width:70%;"></p>
						<p>전화번호 : <input id="placePhone" name="placePhone" value="010-8773-8409" readonly="readonly" style="border:0; font-size:0.7em; outline: none; width:70%;"></p>
						<p>방문날짜 : <input type="date" id="placeVisitDate" name="placeVisitDate" value="2025.06.18" style="border:0; font-size:0.7em; outline: none; width:70%;"></p>
						<p>평점 : <input id="placeRate" name="placeRate" value="4.3" style="border:0; font-size:0.7em; outline: none; width:3em;" maxlength="3">/5.0</p>
						<p>한줄평 : <input id="placeReview" name="placeReview" value="맛이 있었다." style="border:0; font-size:0.7em; outline: none; width:70%"></p>
						<p>사진</p>
						<input id="placeId" name=""placeId"" type="hidden" value="">
						<input id="placeX" name="placeX" type="hidden" value="">
						<input id="placeY" name="placeY" type="hidden" value="">
						<input id="placeCategoryGroupName" name="placeCategoryGroupName" type="hidden" value="">
						<input id="placeUrl" name="placeUrl" type="hidden" value="">
						<input id="formGroupId" name="formGroupId" type="hidden" value="">
						<button type="button" onclick="regPlace()">추가</button>
					</form>
					<form id="reloadForm" action="http://soonmile.com:8088/board/map" method="get">
						<input type="hidden" id="placeGroupId" name="groupId" value="">
					</form>
					</div>
					
				</div>
			</div>
		</div>

		<!-- Footer -->
		<div id="footer-wrapper">
			<footer id="footer" class="container">
				<div class="row">
					<div class="col-3 col-6-medium col-12-small">

						<!-- Links -->
						<section class="widget links">
							<h3>Random Stuff</h3>
							<ul class="style2">
								<li><a href="#">Etiam feugiat condimentum</a></li>
								<li><a href="#">Aliquam imperdiet suscipit odio</a></li>
								<li><a href="#">Sed porttitor cras in erat nec</a></li>
								<li><a href="#">Felis varius pellentesque potenti</a></li>
								<li><a href="#">Nullam scelerisque blandit leo</a></li>
							</ul>
						</section>

					</div>
					<div class="col-3 col-6-medium col-12-small">

						<!-- Links -->
						<section class="widget links">
							<h3>Random Stuff</h3>
							<ul class="style2">
								<li><a href="#">Etiam feugiat condimentum</a></li>
								<li><a href="#">Aliquam imperdiet suscipit odio</a></li>
								<li><a href="#">Sed porttitor cras in erat nec</a></li>
								<li><a href="#">Felis varius pellentesque potenti</a></li>
								<li><a href="#">Nullam scelerisque blandit leo</a></li>
							</ul>
						</section>

					</div>
					<div class="col-3 col-6-medium col-12-small">

						<!-- Links -->
						<section class="widget links">
							<h3>Random Stuff</h3>
							<ul class="style2">
								<li><a href="#">Etiam feugiat condimentum</a></li>
								<li><a href="#">Aliquam imperdiet suscipit odio</a></li>
								<li><a href="#">Sed porttitor cras in erat nec</a></li>
								<li><a href="#">Felis varius pellentesque potenti</a></li>
								<li><a href="#">Nullam scelerisque blandit leo</a></li>
							</ul>
						</section>

					</div>
					<div class="col-3 col-6-medium col-12-small">

						<!-- Contact -->
						<section class="widget contact last">
							<h3>Contact Us</h3>
							<ul>
								<li><a href="#" class="icon brands fa-twitter"><span
										class="label">Twitter</span></a></li>
								<li><a href="#" class="icon brands fa-facebook-f"><span
										class="label">Facebook</span></a></li>
								<li><a href="#" class="icon brands fa-instagram"><span
										class="label">Instagram</span></a></li>
								<li><a href="#" class="icon brands fa-dribbble"><span
										class="label">Dribbble</span></a></li>
								<li><a href="#" class="icon brands fa-pinterest"><span
										class="label">Pinterest</span></a></li>
							</ul>
							<p>
								1234 Fictional Road<br /> Nashville, TN 00000<br /> (800)
								555-0000
							</p>
						</section>

					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div id="copyright">
							<ul class="menu">
								<li>&copy; Untitled. All rights reserved</li>
								<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
							</ul>
						</div>
					</div>
				</div>
			</footer>
		</div>

	</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77ce003417024e96493d60d3be06d1c5&libraries=services"></script>
<script>
// 마커를 담을 배열입니다
var markers = [];
var placePins = [];
var pinOverlays = [];
var pinContent;
var pinOverlay;


var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
//마커 이미지의 이미지 크기 입니다
var imageSize = new kakao.maps.Size(24, 35); 
// 마커 이미지를 생성합니다    
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다




// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title, place) {
            //마커에 클릭이벤트
            kakao.maps.event.addListener(marker, 'click', function(){
            	$("#placeName").val(place.place_name);
				$("#placeAddr").val(place.address_name);
				$("#placePhone").val(place.phone);
				$("#placeVisiteDate").val("");
				$("#placeRate").val("");
				$("#placeReview").val("");
				$("#placeX").val(place.x);
				$("#placeY").val(place.y);
				$("#placeId").val(place.id);
				$("#placeCategoryGroupName").val(place.category_group_name);
				$("#placeRoadAddr").val(place.road_address_name);
				$("#placeUrl").val(place.place_url);
            	
            });
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
            itemEl.on
        })(marker, places[i].place_name, places[i]);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info" onclick="moveTo(' + places.y + ', ' + places.x + ')">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
            clickable: true
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

 
 
 
 

 
 
function placeList(groupId){
	removePin();
	$.ajax({
		type:"POST",
		url:"/map/placeList",
		data:{groupId:groupId},
		beforeSend: function(xhr) {
            xhr.setRequestHeader("AJAX", "true");
        },
        success:function(res){
        	const placeList = $("#placeList");
        	placeList.empty();
        	const place = res.data;
        	if(place && place.length > 0){
        		
        		let html = "";
        		$.each(place, function(index, place){
        			html += '<div class="col-61 placeDiv" onclick="moveTo(' + place.placeY + ', ' + place.placeX + ')">';
        			html += '<h3 class="place">' + place.placeName + '</h3>';
        			html += '<h4 class="place">' + place.placeAddr + '</h4>';
        			html += '</div>';
        			var pinPosition = new kakao.maps.LatLng(place.placeY, place.placeX)
        			var placePin = new kakao.maps.Marker({
        				title: place.placeName,
        				position: pinPosition,
        				image : markerImage
        			});
        			
        			pinContent =  '<div class="wrap">' + 
                    '    <div class="info">' + 
                    '        <div class="title">' + 
                    place.placeName + 
                    '            <div class="close" onclick="closeOverlay(' + index + ')" title="닫기"></div>' + 
                    '        </div>' + 
                    '        <div class="body">' + 
                    '            <div class="img">' +
                    '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
                    '           </div>' + 
                    '            <div class="desc">' + 
                    '                <div class="ellipsis">' + place.placeAddr + '</div>' + 
                    '                <div class="jibun ellipsis">' + place.placeRoadAddr + '</div>' + 
                    '                <div><a href="' + place.placeUrl + '" target="_blank" class="link">상세보기</a></div>' + 
                    '            </div>' + 
                    '        </div>' + 
                    '    </div>' +    
                    '</div>';
        			pinOverlay = new kakao.maps.CustomOverlay({
        				content: pinContent,
        				position: pinPosition,
        				clickable: true
        			});
        			pinOverlays.push(pinOverlay);
        			kakao.maps.event.addListener(placePin, 'click', function(){
        				pinOverlays[index].setMap(map);
        			});
        			
        			placePins.push(placePin);
        			
        			/* placePin.push({
        				title: place.placeName,
        				latlng: new kakao.maps.LatLng(place.placeY, place.placeX)
        			}); */
        		});
        		placeList.html(html);
        		pinPlace(placePins);
        	}
        	else{
        		placeList.html('<div class="col-61 placeDiv">등록된 장소가 존재하지 않습니다.</div>');
        	}
        	
        }
	});
}

function closeOverlay(index) {
    pinOverlays[index].setMap(null);     
}

function removePin() {
    for ( var i = 0; i < placePins.length; i++ ) {
    	placePins[i].setMap(null);
    }   
    placePins = [];
}



function pinPlace(placePins){
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
	for (var i = 0; i < placePins.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    
	    placePins[i].setMap(map);
	}
	
}

function regPlace(){
	if($("#selectedGroup").val() === 'all'){
		Swal.fire({
			icon : 'warning',
			title : '그룹을 선택하여주세요.',
			showConfirmButton: true,
			timer:1000
		});
		return;
	}
	
	var form = $("#placeForm")[0];
	var formData = new FormData(form);
	$.ajax({
		type:"POST",
		url:"/map/regPlace",
		data:formData,
		contentType:false,
		processData:false,
		cache:false,
		timeout:600000,
		beforSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			var code = res.code;
			var msg = res.msg;
			if(code == 0){
				Swal.fire({
					icon:"success",
					title:"장소가 등록 되었습니다.",
					showConfirmButton: true,
					timer:3000
				}).then(function(){
					location.href = "/board/map";
				});
			}
			else{
				Swal.fire({
					icon:"warning",
					title:msg,
					showConfirmButton: true,
					timer:3000
				});
			}
		}
	});	
}

function moveTo(lng, lat){
	var moveLatLon = new kakao.maps.LatLng(lng, lat);
	map.setLevel(3);
	map.panTo(moveLatLon);
}


$(document).ready(function() {
	placeList($("#selectedGroup").val());
	$("#selectedGroup").on("change",function(){
		$("#placeGroupId").val($(this).val());
		$("#formGroupId").val($(this).val());
		placeList($("#selectedGroup").val());
	});
});
 
 

</script>
</body>
</html>