<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/include/head.jsp"%>
		<style>
			.hidden {display:none}
			.tab {cursor: pointer; display:inline-block;}

		</style>
		<script>
			// 아이디 중복체크 아이디 수정 불가로 필요없는 변수
			var idDupCheck = true;
			// 공백 체크
			var emptCheck = /\s/g;
			// 아이디 정규표현식(영문 대소문자, 숫자로만 이루어진 8~20자)
			var idCheck = /^[a-zA-Z0-9]{8,20}$/;
			// 비밀번호 정규표현식(영문 대소문자, 숫자, 특수문자만 이루어진 8~20자)
			var pwdCheck = /^[a-zA-Z0-9!@#$%^&*]{8,20}$/;
			var phoneCheck = /^(010)[0-9]{4}[0-9]{4}$/;
			// 비밀번호 처음 클릭시 초기화 여부
			var pwdClick = true;
			var groupNameDupCheck = true;
			
			$(document).ready(function(){
				$.ajax({
					type:"POST",
					url:"/user/info",
					beforeSend : function(xhr) {
		               xhr.setRequestHeader("AJAX", "true");
		            },
		            success:function(res){
		            	user = res.data;
						$("#infoUserId").val(user.userId);
						$("#infoUserPwd").val(user.userPwd);
						$("#infoUserName").val(user.userName);
						$("#infoUserPhone").val(user.userPhone);
						$("#infoUserEmail").val(user.userEmail);
		            }
				});
			});
			//아이디 중복체크
			document.addEventListener("DOMContentLoaded", function () {
			    var infoUserId = document.getElementById("infoUserId");
			    infoUserId.addEventListener("input", function(e) {
			    	idDupCheck=false;
			    });
			    
			    //비밀번호 클릭시 초기화
			    var infoUserPwd = document.getElementById("infoUserPwd");
			    
			    infoUserPwd.addEventListener("click", function(e){
			    	if (pwdClick){
				    	$("#infoUserPwd").val("");
				    	pwdClick = false;
			    	}
			    });
			    
			    //그룹만들기 내 그룹이름 중복
			    var groupName = document.getElementById("groupName");
			    groupName.addEventListener("input", function(e) {
			    	groupNameDupCheck=false;
			    });
			    
			});
			
			function showTab(tabId){
				const tabs = ['info', 'group', 'groupMade'];
				tabs.forEach(id => {
					document.getElementById(id).classList.add('hidden');
				});
				document.getElementById(tabId).classList.remove('hidden');
			}
			
			
			//회원수정 시작
			function fn_infoUpdate(){
				//비밀번호 입력여부 체크
				if ($.trim($("#infoUserPwd").val()).length <= 0) {
					Swal.fire({
						icon : "warning",
						title : "비밀번호를 입력하세요"
					}).then(function() {
						$("#infoUserPwd").val("");
						setTimeout(() => $("#infoUserPwd").focus(), 100);
					});
					return;
				}
				//비밀번호 공백여부 확인
				if (emptCheck.test($("#infoUserPwd").val())) {
					Swal.fire({
						icon : "warning",
						title : "비밀번호는 공백을 포함할 수 없습니다"
					}).then(function() {
						$("#infoUserPwd").val("");
						setTimeout(() => $("#infoUserPwd").focus(), 100);
					});
					return;
				}
				//비밀번호 유효성 검사
				if(!pwdCheck.test($("#infoUserPwd").val())){
					Swal.fire({
						icon:"warning",
						title:"사용할 수 없는 비밀번호입니다.",
						text:"(영문 대소문자, 숫자, 특수문자로만 이루어진 8~20자)"
					}).then(function(){
						$("#infoUserPwd").val("");
						setTimeout(() => $("#infoUserPwd").focus(), 100);
					});
					return;
				}
				//비밀번호/비밀번호 확인 일치 체크
				if ($("#infoUserPwd").val() != $("#infoUserPwd1").val()){
					Swal.fire({
						icon : "warning",
						title : "비밀번호가 일치하지 않습니다."
					}).then(function() {
						setTimeout(() => $("#infoUserPwd1").focus(), 100);
					});
					return;
				}
				
				//이름은 핸드폰 인증을 도입하게되면 변경 불가하게 만들예정
				//이름 입력 체크
				if($.trim($("#infoUserName").val()).length <= 0){
					Swal.fire({
						icon : "warning",
						title : "이릅을 입력하세요."
					}).then(function() {
						$("#infoUserName").val("");
						setTimeout(() => $("#infoUserName").focus(), 100);
					});
					return;
				}
				//전화번호 입력 체크
				if($.trim($("#infoUserPhone").val()).length <= 0){
					Swal.fire({
						icon : "warning",
						title : "전화번호를 입력하세요."
					}).then(function() {
						$("#infoUserPhone").val("");
						setTimeout(() => $("#infoUserPhone").focus(), 100);
					});
					return;
				}
				//전화번호 유효성 검사
				if (!phoneCheck.test($("#infoUserPhone").val())) {
					Swal.fire({
						icon : "warning",
						title : "전화번호를 다시 확인해주세요.",
						text:"(010을 포함한 11자리 숫자)"
					}).then(function() {
						setTimeout(() => $("#infoUserPhone").focus(), 100);
					});
					return;
				}
				//이메일 입력 검사
				if($.trim($("#infoUserEmail").val()).length <= 0){
					Swal.fire({
						icon : "warning",
						title : "이메일을 입력하세요."
					}).then(function() {
						$("#infoUserEmail").val("");
						setTimeout(() => $("#infoUserEmail").focus(), 100);
					});
					return;
				}
				
				//ajax 시작
				var form = $("#infoForm")[0];
				var formData = new FormData(form);
				$.ajax({
					type:"POST",
					url:"/user/updateProc",
					data:formData,
					contentType:false,
					processData:false,
					cache:false,
					timeout:600000,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(res){
						var code = res.code;
						var msg = res.msg;
						if(code == 0){
							Swal.fire({
								icon:"success",
								title:"회원 정보가 수정되었습니다.",
								showConfirmButton: true,
								timer:3000
							}).then(function(){
								location.href = "/";
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
				})
				
			}
			
			
			//그룹만들기
			function fn_groupMade(){
				if ($.trim($("#groupName").val()).length <= 0) {
					Swal.fire({
						icon : 'warning',
						title : '그룹이름를 입력하세요.'
					}).then(function() {
						$("#groupName").val("");
						setTimeout(() => $("#groupName").focus(), 100);
					});
					return;
				}
				
				var groupPublic = document.querySelector('input[name="groupPublic"]:checked').value;
				
				$.ajax({
					type:"POST",
					url:"/group/groupMade",
					data:{groupName:$("#groupName").val(),
						isPublic:groupPublic,
						groupIntro:$("#groupIntro").val()
					},
					beforeSend : function(xhr) {
		               xhr.setRequestHeader("AJAX", "true");
		            },
		            success:function(res){
	            		var code = res.code;
	            		if(code == 0){
	            			Swal.fire({
	            				icon:"success",
	            				title:"그룹 만들기 성공!",
	            				showConfirmButton: false,
	            				timer:1000
	            			}).then(function(){
	            				showTab('group');
	            				fn_list(1);
	            				$("#groupName").val("");
	            				$("#groupIntro").val("");
	            			});
	            		}
	            		else{
	            			Swal.fire({
	            				icon:"warning",
	            				title:"그룹만들기 실패",
	            				showConfirmButton: false,
	            				timer:1000
	            			}).then(function(){
	            				console.log(res.code + "---------------------");
	            				$("#joinUserId").focus;
	            			});
	            		}

		            }
				});
			}
			function fn_list(page) {
			    // 서버에 그룹 목록 데이터를 요청
			    $.ajax({
			        type: "POST",
			        url: "/group/groupList", // 그룹 목록을 조회할 컨트롤러 URL
			        data: {
			            pageNum: page, // 요청할 페이지 번호
			            curPage: $("#curPage").val()
			        },
			        beforeSend: function(xhr) {
			            xhr.setRequestHeader("AJAX", "true");
			        },
			        success: function(res) {
			            // res 객체는 서버로부터 받은 그룹 목록(groups)과 페이징 정보(paging)를 포함해야 합니다.

			            // 1. 그룹 목록 테이블 다시 그리기
			            const tbody = $("#c_size_image tbody");
			            tbody.empty(); // 기존 목록 삭제

			            if (res.group && res.group.length > 0) {
			                let html = "";
			                // 받은 데이터로 새로운 <tr>...</tr> HTML을 생성
			                $.each(res.group, function(index, group) {
			                    html += '<tr>';
			                    html += '    <th>';
			                    html += '        <span class="table-portrait-label">';
			                    html += '            <img class="portrait" src="assets/images/sample-portrait-1.png" alt="">';
			                    html += '            <span class="label">' + group.ownerId + '</span>';
			                    html += '        </span>';
			                    html += '    </th>';
			                    html += '    <td><span class="v-middle">' + group.groupName +'</span>';
			                    if(group.isPublic === 'N'){
			                    	html += '<span class="badge badge-inline">🔒</span></td>';
			                    }
			                    else{
			                    	html += '</td>';
			                    }
			                    html += '    <td style="width:20%;">' + group.createAt + '</td>';
			                    html += '</tr>';
			                });
			                tbody.html(html); // 새로 만든 목록으로 테이블 내용 교체
			            } else {
			                // 데이터가 없을 경우
			                tbody.html('<tr><td colspan="3">가입한 그룹이 없습니다.</td></tr>');
			            }

			            // 2. 페이지네이션 다시 그리기
			            const pagination = $(".pagination-wrapper div");
			            pagination.empty(); // 기존 페이지네이션 삭제

			            const paging = res.paging; // 새로운 페이징 정보
			            let pageHtml = "";
			            pageHtml += '<div class="pagination-group direction">';
			            pageHtml += 	'<ul>';
			            if(paging.startPage === 1){
			            	pageHtml += 		'<li class="disabled">';
			            }
			            else{
			            	pageHtml += 		'<li class="">';
			            }
			            pageHtml +=				'<a href="#" onclick="fn_list(' + (paging.pageNum - paging.pageSize) + ')" class="pagination-item prev"><i class="Licon ico-prev"></i></a></li>';
			            if(1 === paging.pageNum){
			            	pageHtml += 		'<li class="disabled">';
			            }
			            else{
			            	pageHtml += 		'<li class="">';
			            }
			            pageHtml += 			'<a href="#" onclick="fn_list(' + (paging.pageNum - 1) + ')" class="pagination-item left"><i class="Licon ico-left"></i></a></li>';
			            pageHtml += 		'</ul>';
			            pageHtml += 	'</div>';
			            pageHtml += '<div class="pagination-group pagingNum">';
			            pageHtml += '<ul>';
			            for (let i = paging.startPage; i <= paging.endPage; i++) {
			                if (i === page) {
			                    // 현재 페이지는 'on' 클래스 추가
			                    pageHtml += '<li class="on"><a href="#" class="pagination-item"><i>' + i + '</i></a></li>';
			                } else {
			                    // 다른 페이지는 onclick 이벤트 추가
			                    pageHtml += '<li class=""><a href="#" onclick="fn_list(' + i + ')" class="pagination-item"><i>' + i + '</i></a></li>';
			                }
			            }
			            pageHtml += '</ul>';
			            pageHtml += '</div>';
			            
			            pageHtml += '<div class="pagination-group direction">';
			            pageHtml += 	'<ul>';
			            if(paging.endPage > paging.totalPage - paging.pageSize + 1){
			            	pageHtml += 		'<li class="disabled">';
			            }
			            else{
			            	pageHtml += 		'<li class="">';
			            }
			            pageHtml +=				'<a href="#" onclick="fn_list(' + (paging.pageNum + 1) + ')" class="pagination-item right"><i class="Licon ico-right"></i></a></li>';

			            if(paging.totalPage === paging.pageNum || paging.pageNum + paging.pageSize > paging.totalPage){
			            	pageHtml += 		'<li class="disabled">';
			            }
			            else{
			            	pageHtml += 		'<li class="">';
			            }
			            pageHtml += 			'<a href="#" onclick="fn_list(' + (paging.pageNum + paging.pageSize) + ')" class="pagination-item next"><i class="Licon ico-next"></i></a></li>';
			            pageHtml += 		'</ul>';
			            pageHtml += 	'</div>';
			            
			            pagination.html(pageHtml); // 새로운 페이지네이션으로 교체
						$("#curPage").val(page);
			        },
			        error: function(xhr, status, error) {
			            console.error("그룹 목록을 불러오는 데 실패했습니다.", error);
			            Swal.fire({
			                icon: "error",
			                title: "데이터를 불러오는 중 오류가 발생했습니다."
			            });
			        }
			    });
			}
		</script>
	</head>
	
	<body class="is-preload homepage">
		<div id="page-wrapper">

			<!-- Header -->
				<div id="header-wrapper">
					<header id="header" class="container">

						<!-- Logo -->
							<div id="logo">
								<h1><a href="index.html">Verti</a></h1>
								<span>by HTML5 UP</span>
							</div>

						<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

					</header>
				</div>

		<!-- 메인 -->
				<div id="banner-wrapper">

					<div id="banner" class="box container">
						<div class="row">
							<div class="col-6 col-12-medium" style="width:20%;">
								<p style="padding:0 0 10px 0">My Info</p>
								<a class="tab" onclick="showTab('info')"><p style="font-size: 20px;">개인정보변경</p></a><br> 
								<a class="tab" onclick="showTab('group')"><p style="font-size: 20px;">Group</p></a>
								
							</div>
							<div id="info" class="col-6 col-12-medium ">
								<h3>개인정보</h3>
								<form name="infoForm" id="infoForm" method="post" action="">
									<label class="loginLabel" for="infoUserId">아이디</label>
<!-- 									<div style="display: flex; align-items: center; gap: 8px;">
 -->										
 									<input type="text" id="infoUserId" name="infoUserId" readonly>
<!-- 										<button type="button" onclick="fn_checkDupId()" style="margin:0; height:54px; width:100px; font-size:1em;">확인</button>
									</div> -->
									<label class="loginLabel" for="infoUserPwd">비밀번호</label>
									<input type="password" id="infoUserPwd" name="infoUserPwd" required>
									<label class="loginLabel" for="infoUserPwd1">비밀번호 확인</label>
									<input type="password" id="infoUserPwd1" name="infoUserPwd1" required>
									<label class="loginLabel" for="infoUserName">이름</label>
									<input type="text" id="infoUserName" name="infoUserName">
									<label class="loginLabel" for="infoUserPhone">전화번호</label>
									<input type="text" id="infoUserPhone" name="infoUserPhone">
									<label class="loginLabel" for="infoUserEmail">이메일</label>
									<input type="text" id="infoUserEmail" name="infoUserEmail">
									<button type="button" onclick="fn_infoUpdate()">수정</button>
								</form>
							</div>
							<div id="group" class="col-6 col-12-medium hidden" style="width:80%;">
								<h3>group</h3>
						<section>
							<table class="table table-md" id="c_size_image">
								<thead>
									<tr>
										<th>그룹장</th>
										<th>그룹이름</th>
										<th>생성날짜</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="group" items="${groups}" varStatus="status">
									<tr>
										<th><span class="table-portrait-label"> <img
												class="portrait" src="assets/images/sample-portrait-1.png"
												alt=""> <span class="label">${group.ownerId}</span>
										</span></th>
										<td><span class="v-middle">${group.groupName }</span><!-- <span class="badge badge-inline">N</span> --><c:if test="${group.isPublic eq 'N' }"><span class="badge badge-inline">🔒</span></c:if></td>
										<td style="width:20%;">${group.createAt }</td>
									</tr>
								</c:forEach>
								</tbody>
								
							</table>
						</section>

						<div class="mg-b-10u">
							<div class="pagination-wrapper">
								<div class="pagination">
									<div class="pagination-group direction">
										<ul>
											<li class="disabled"><a href="#" onclick="fn_list(${paging.pageNum} - 1)" class="pagination-item prev"><i class="Licon ico-prev"></i></a></li>
											<li class="disabled"><a href="#" onclick="fn_list(${paging.pageNum - paging.pageSize})" class="pagination-item left"><i class="Licon ico-left"></i></a></li>
										</ul>
									</div>
									<div class="pagination-group pagingNum">
										<ul>
											<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
												<c:choose>
													<c:when test="${i eq paging.pageNum}">
														<li class="on"><a href="#" class="pagination-item"><i>${i}</i></a></li>
													</c:when>
													<c:otherwise>
														<li class=""><a href="#" onclick="fn_list(${i})" class="pagination-item"><i>${i}</i></a></li>
													</c:otherwise>
												</c:choose>
												
											</c:forEach>
										</ul>
									</div>
									<div class="pagination-group direction">
										<ul>
											<li class=""><a href="#" onclick="fn_list(${paging.pageNum} + 1)" class="pagination-item right"><i class="Licon ico-right"></i></a></li>
											<li class=""><a href="#" onclick="fn_list(${paging.pageNum} + ${paging.pageSize })" class="pagination-item next"><i class="Licon ico-next"></i></a></li>
										</ul>
									</div>
								</div>
								<input type="hidden" id="curPage" name="curPage" value="1">
							</div>
						</div>
						<button type="button" onclick="showTab('groupMade')">그룹 만들기</button>
							</div>
							<div id="groupMade" class="col-6 col-12-medium hidden">
								<h3>그룹 만들기</h3>
								<form name="groupMadeForm" id="groupMadeForm" method="post" action="">
									<label class="loginLabel" for="groupName">그룹이름</label>
 									<div style="display: flex; align-items: center; gap: 8px;">
 										<input type="text" id="groupName" name="groupName">
 										<button type="button" onclick="fn_checkDupGroupName()" style="margin:0; height:54px; width:100px; font-size:1em;">확인</button>
									</div>
									
									<label class="loginLabel" for="groupPublic">공개 여부</label>
									<input type="radio" name="groupPublic" value="Y" checked style=" appearance:radio;">공개 &nbsp;&nbsp;&nbsp;
									<input type="radio" name="groupPublic" value="N" style="appearance:radio;">비공개
									<label class="loginLabel" for="groupIntro">그룹 소개(300자 이내)</label>
									<textarea id="groupIntro" name="groupIntro" style="resize:none; height:25em;" maxlength="300"></textarea>
									<button type="button" onclick="fn_groupMade()">생성</button>
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
											<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
											<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
											<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
											<li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li>
											<li><a href="#" class="icon brands fa-pinterest"><span class="label">Pinterest</span></a></li>
										</ul>
										<p>1234 Fictional Road<br />
										Nashville, TN 00000<br />
										(800) 555-0000</p>
									</section>

							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div id="copyright">
									<ul class="menu">
										<li>&copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
									</ul>
								</div>
							</div>
						</div>
					</footer>
				</div>

			</div>

		<!-- Scripts -->

			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>