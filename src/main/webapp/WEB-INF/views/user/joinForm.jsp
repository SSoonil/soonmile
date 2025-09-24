<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
	<head>
		<%@ include file="/WEB-INF/views/include/head.jsp"%>
		<script type="text/javascript">
		$(document).ready(function () {
		    $("#loginUserId").focus();
		});

			
			var idDupCheck = false; //아이디 중복 체크
			var emailDupCheck = false; //이메일 중복 체크
			var sendCheck = false; //인증번호 전송 체크
			var authCheck = false; //인증번호 일치 체크
			
			// 공백 체크
			var emptCheck = /\s/g;
			// 아이디 정규표현식(영문 대소문자, 숫자로만 이루어진 8~20자)
			var idCheck = /^[a-zA-Z0-9]{8,20}$/;
			// 비밀번호 정규표현식(영문 대소문자, 숫자, 특수문자만 이루어진 8~20자)
			var pwdCheck = /^[a-zA-Z0-9!@#$%^&*]{8,20}$/;
			var phoneCheck = /^(010)[0-9]{4}[0-9]{4}$/;
			
			//로그인 시작
			function fn_login() {
				if ($.trim($("#loginUserId").val()).length <= 0) {
					Swal.fire({
						icon : 'warning',
						title : '아이디를 입력하세요.'
					}).then(function() {
						$("#loginUserId").val("");
						setTimeout(() => $("#loginUserId").focus(), 100);
					});
					return;
				}

				if (emptCheck.test($("#loginUserId").val())) {
					Swal.fire({
						icon : "warning",
						title : "아이디는 공백을 포함할 수 없습니다."
					}).then(function() {
						$("#loginUserId").val("");
						setTimeout(() => $("#loginUserId").focus(), 100);
					});
					return;
				}

				if ($.trim($("#loginUserPwd").val()).length <= 0) {
					Swal.fire({
						icon : "warning",
						title : "비밀번호를 입력하세요"
					}).then(function() {
						$("#loginUserPwd").val("");
						setTimeout(() => $("#loginUserPwd").focus(), 100);
					});
					return;
				}

				if (emptCheck.test($("#loginUserPwd").val())) {
					Swal.fire({
						icon : "warning",
						title : "비밀번호는 공백을 포함할 수 없습니다"
					}).then(function() {
						$("#loginUserPwd").val("");
						setTimeout(() => $("#loginUserPwd").focus(), 100);
					});
					return;
				}
				
				$.ajax({
					type:"POST",
					url:"/user/loginProc",
					data:{
						loginUserId:$("#loginUserId").val(),
						loginUserPwd:$("#loginUserPwd").val()
					},
					datatype:"JSON",
					/* contentType:false,
					processData:false, */
					beforeSend : function(xhr) {
		               xhr.setRequestHeader("AJAX", "true");
		            },
		            success:function(res){

	            		var code = res.code;
	            		if(code == 0){
	            			Swal.fire({
	            				icon:"success",
	            				title:"로그인 성공!",
	            				showConfirmButton: false,
	            				timer:1000
	            			}).then(function(){
	            				location.href = "/";
	            			});
	            		}
	            		else{
	            			Swal.fire({
	            				icon:"warning",
	            				title:"로그인 실패",
	            				showConfirmButton: false,
	            				timer:1000
	            			}).then(function(){
	            				$("#loginUserId").focus;
	            			});
	            		}

		            }
				});
				
			}
			//로그인 끝
			
			//아이디 중복체크
			document.addEventListener("DOMContentLoaded", function () {
			    var joinUserId = document.getElementById("joinUserId");
			    joinUserId.addEventListener("input", function(e) {
			    	idDupCheck=false;
			    });
			});

			function fn_checkDupId(){
				if ($.trim($("#joinUserId").val()).length <= 0) {
					Swal.fire({
						icon : 'warning',
						title : '아이디를 입력하세요.'
					}).then(function() {
						$("#joinUserId").val("");
						setTimeout(() => $("#joinUserId").focus(), 100);
					});
					return;
				}

				if (emptCheck.test($("#joinUserId").val())) {
					Swal.fire({
						icon : "warning",
						title : "아이디는 공백을 포함할 수 없습니다."
					}).then(function() {
						$("#joinUserId").val("");
						setTimeout(() => $("#joinUserId").focus(), 100);
					});
					return;
				}
				
				if(!idCheck.test($("#joinUserId").val())){
					Swal.fire({
						icon:"warning",
						title:"사용할 수 없는 아이디입니다.",
						text:"(영문 대소문자, 숫자로만 이루어진 8~20자)"
					}).then(function(){
						$("#joinUserId").val("");
						setTimeout(() => $("#joinUserId").focus(), 100);
					});
					return;
				}
				$.ajax({
						type:"POST",
						url:"/user/checkDupId",
						data:{joinUserId:$("#joinUserId").val()},
						beforSend:function(xhr){
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(res){
							var code = res.code;
							if(code == 0){
								Swal.fire({
									icon:"success",
									title:"사용가능한 아이디 입니다.",
									showConfirmButton:true,
									timer:1000
								}).then(function(){
									idDupCheck = true;
								});
							}
							else{
								Swal.fire({
									icon:"warning",
									title:"사용할 수 없는 아이디 입니다.",
									showConfirmButton: true,
									timer:100
								}).then(function(){
									$("#joinUserId").focus();
								});
								return;
							}
						}
					});
			}
			
			//회원가입 시작
			function fn_join(){
				if ($.trim($("#joinUserId").val()).length <= 0) {
					Swal.fire({
						icon : 'warning',
						title : '아이디를 입력하세요.'
					}).then(function() {
						$("#joinUserId").val("");
						setTimeout(() => $("#joinUserId").focus(), 100);
					});
					return;
				}

				if (emptCheck.test($("#joinUserId").val())) {
					Swal.fire({
						icon : "warning",
						title : "아이디는 공백을 포함할 수 없습니다."
					}).then(function() {
						$("#joinUserId").val("");
						setTimeout(() => $("#joinUserId").focus(), 100);
					});
					return;
				}
				
				if(!idCheck.test($("#joinUserId").val())){
					Swal.fire({
						icon:"warning",
						title:"사용할 수 없는 아이디입니다.",
						text:"(영문 대소문자, 숫자로만 이루어진 8~20자)"
					}).then(function(){
						$("#joinUserId").val("");
						setTimeout(() => $("#joinUserId").focus(), 100);
					});
					return;
				}
				
				
				
				if ($.trim($("#joinUserPwd1").val()).length <= 0) {
					Swal.fire({
						icon : "warning",
						title : "비밀번호를 입력하세요"
					}).then(function() {
						$("#joinUserPwd1").val("");
						setTimeout(() => $("#joinUserPwd1").focus(), 100);
					});
					return;
				}

				if (emptCheck.test($("#joinUserPwd1").val())) {
					Swal.fire({
						icon : "warning",
						title : "비밀번호는 공백을 포함할 수 없습니다"
					}).then(function() {
						$("#joinUserPwd1").val("");
						setTimeout(() => $("#joinUserPwd1").focus(), 100);
					});
					return;
				}
				
				if(!pwdCheck.test($("#joinUserPwd1").val())){
					Swal.fire({
						icon:"warning",
						title:"사용할 수 없는 비밀번호입니다.",
						text:"(영문 대소문자, 숫자, 특수문자로만 이루어진 8~20자)"
					}).then(function(){
						$("#joinUserPwd1").val("");
						setTimeout(() => $("#joinUserPwd1").focus(), 100);
					});
					return;
				}
				
				if ($("#joinUserPwd2").val() != $("#joinUserPwd1").val()){
					Swal.fire({
						icon : "warning",
						title : "비밀번호가 일치하지 않습니다."
					}).then(function() {
						setTimeout(() => $("#joinUserPwd2").focus(), 100);
					});
					return;
				}
				$("#joinUserPwd").val($("#joinUserPwd1").val());
				
				if($.trim($("#joinUserName").val()).length <= 0){
					Swal.fire({
						icon : "warning",
						title : "이릅을 입력하세요."
					}).then(function() {
						$("#joinUserName").val("");
						setTimeout(() => $("#joinUserName").focus(), 100);
					});
					return;
				}
				
				if($.trim($("#joinUserPhone").val()).length <= 0){
					Swal.fire({
						icon : "warning",
						title : "전화번호를 입력하세요."
					}).then(function() {
						$("#joinUserPhone").val("");
						setTimeout(() => $("#joinUserPhone").focus(), 100);
					});
					return;
				}
				
				if (!phoneCheck.test($("#joinUserPhone").val())) {
					Swal.fire({
						icon : "warning",
						title : "전화번호를 다시 확인해주세요.",
						text:"(010을 포함한 11자리 숫자)"
					}).then(function() {
						setTimeout(() => $("#joinUserPhone").focus(), 100);
					});
					return;
				}
				
				if($.trim($("#joinUserEmail").val()).length <= 0){
					Swal.fire({
						icon : "warning",
						title : "이메일을 입력하세요."
					}).then(function() {
						$("#joinUserEmail").val("");
						setTimeout(() => $("#joinUserEmail").focus(), 100);
					});
					return;
				}
				if(!idDupCheck){
					Swal.fire({
						icon:"warning",
						title:"아이디 중복 체크를 해주세요",
						showConfirmButton:true,
						timer:1000
					}).then(function(){
						$("#joinUserId").focus();
						
					});
					return;
				}
				var form = $("#joinForm")[0];
				var formData = new FormData(form);
				
				$.ajax({
					type:"POST",
					url:"/user/joinProc",
					data:formData,
					contentType:false,
					processData:false,
					cache:false,
					timeout:600000,
					beforeSend : function(xhr) {
		               xhr.setRequestHeader("AJAX", "true");
		            },
		            success:function(res){
	            		var code = res.code;
	            		if(code == 0){
	            			Swal.fire({
	            				icon:"success",
	            				title:"회원가입 성공!",
	            				showConfirmButton: false,
	            				timer:1000
	            			}).then(function(){
	            				location.href = "/";
	            			});
	            		}
	            		else{
	            			Swal.fire({
	            				icon:"warning",
	            				title:"회원가입 실패",
	            				showConfirmButton: false,
	            				timer:1000
	            			}).then(function(){
	            				$("#joinUserId").focus;
	            			});
	            		}

		            }
				});
				
			}
			//회원가입 끝
			
			
			
		</script>
	</head>
	<body class="is-preload homepage">
		<div id="page-wrapper">

			<!-- Header -->
				<div id="header-wrapper">
					<header id="header" class="container">

						<!-- Logo -->
							<div id="logo">
								<h1><a href="/">Soonmile</a></h1>
							</div>
						<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

					</header>
				</div>

		<!-- 로그인 회원가입 -->
				<div id="banner-wrapper">
					<div id="banner" class="box container">
						<div class="row">
							<div class="col-6 col-12-medium">
								<p>로그인</p>
								<form name="loginForm" id="loginForm" method="post" action="">
									<label class="loginLabel" for="loginUserId">아이디</label>
									<input type="text" id="loginUserId" name="loginUserId" required>
									<label class="loginLabel" for="loginUserPwd">비밀번호</label>
									<input type="password" id="loginUserPwd" name="loginUserPwd" required>
									<button type="button" onclick="fn_login()">로그인</button>
								</form>
							</div>
							<div class="col-6 col-12-medium">
								<p>회원가입</p>
								<form name="joinForm" id="joinForm" method="post" action="">
									<label class="loginLabel" for="joinUserId">아이디</label>
									<div style="display: flex; align-items: center; gap: 8px;">
										<input type="text" id="joinUserId" name="joinUserId" style="">
										<button type="button" onclick="fn_checkDupId()" style="margin:0; height:54px; width:100px; font-size:1em;">확인</button>
									</div>
									<label class="loginLabel" for="joinUserPwd1">비밀번호</label>
									<input type="password" id="joinUserPwd1" name="joinUserPwd1">
									<label class="loginLabel" for="joinUserPwd2">비밀번호 확인</label>
									<input type="password" id="joinUserPwd2" name="joinUserPwd2">
									<input type="hidden" id="joinUserPwd" name="joinUserPwd" value="">
									<label class="loginLabel" for="joinUserName">이름</label>
									<input type="text" id="joinUserName" name="joinUserName">
									<label class="loginLabel" for="joinUserPhone">전화번호</label>
									<input type="text" id="joinUserPhone" name="joinUserPhone">
									<label class="loginLabel" for="joinUserEmail">이메일</label>
									<input type="text" id="joinUserEmail" name="joinUserEmail">
									<button type="button" onclick="fn_join()">회원가입</button>
								</form>
							</div>
						</div>
					</div>
				</div>

			</div>

		<!-- Scripts -->

			<script src="resources/js/jquery.min.js"></script>
			<script src="resources/js/jquery.dropotron.min.js"></script>
			<script src="resources/js/browser.min.js"></script>
			<script src="resources/js/breakpoints.min.js"></script>
			<script src="resources/js/util.js"></script>
			<script src="resources/js/main.js"></script>

	</body>
</html>