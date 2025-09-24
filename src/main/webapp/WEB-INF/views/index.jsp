<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
	<head>
		<%@ include file="/WEB-INF/views/include/head.jsp"%>
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
				<div id="map" style="width:500px;height:400px;"></div>

				<script>
					var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
					var options = { //지도를 생성할 때 필요한 기본 옵션
						center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
						level : 3
					//지도의 레벨(확대, 축소 정도)
					};
					var map = new kakao.maps.Map(container, options);
				</script>

		<!-- Banner -->
				<div id="banner-wrapper">
					<div id="banner" class="box container">
						<div class="row">
							<div class="col-7 col-12-medium">
								<h2>어서오세요. soonmile입니다</h2>
								<p>나만의 지도, 우리만의 지도, 일기를 만들어 보아요!</p>
							</div>
							<div class="col-5 col-12-medium">
								<ul>
									<li><a href="/board/map" class="button large icon solid fa-arrow-circle-right">나만의 지도 만들기</a></li>
									<!-- <li><a href="#" class="button alt large icon solid fa-question-circle">More info</a></li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>

			<!-- Features 추천수? 최근순? 매핑한거 3개 띄우기, 누르면 지도에서 해당 주소 찍어서 보여주기 더보기 버튼 만들기-->
				<div id="features-wrapper">
					<div class="container">
						<div class="row">
							<div class="col-4 col-12-medium">

								<!-- Box -->
									<section class="box feature">
										<a href="#" class="image featured"><img src="resources/images/pic01.jpg" alt="" /></a>
										<div class="inner">
											<header>
												<h2>장소 명</h2>
												<p>주소</p>
											</header>
											<p>글작성자의 별점, 한줄평 등</p>
										</div>
									</section>

							</div>
							<div class="col-4 col-12-medium">

								<!-- Box -->
									<section class="box feature">
										<a href="#" class="image featured"><img src="resources/images/pic02.jpg" alt="" /></a>
										<div class="inner">
											<header>
												<h2>An interesting title</h2>
												<p>This is also an interesting subtitle</p>
											</header>
											<p>Phasellus quam turpis, feugiat sit amet in, hendrerit in lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
										</div>
									</section>

							</div>
							<div class="col-4 col-12-medium">

								<!-- Box -->
									<section class="box feature">
										<a href="#" class="image featured"><img src="resources/images/pic03.jpg" alt="" /></a>
										<div class="inner">
											<header>
												<h2>Oh, and finally ...</h2>
												<p>Here's another intriguing subtitle</p>
											</header>
											<p>Phasellus quam turpis, feugiat sit amet in, hendrerit in lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
										</div>
									</section>

							</div>
						</div>
					</div>
				</div>

			<!-- Main -->
				<div id="main-wrapper">
					<div class="container">
						<div class="row gtr-200">
							<div class="col-4 col-12-medium">

								<!-- Sidebar -->
									<div id="sidebar">
										<section class="widget thumbnails">
											<h3>Interesting stuff</h3>
											<div class="grid">
												<div class="row gtr-50">
													<div class="col-6"><a href="#" class="image fit"><img src="resources/images/pic04.jpg" alt="" /></a></div>
													<div class="col-6"><a href="#" class="image fit"><img src="resources/images/pic05.jpg" alt="" /></a></div>
													<div class="col-6"><a href="#" class="image fit"><img src="resources/images/pic06.jpg" alt="" /></a></div>
													<div class="col-6"><a href="#" class="image fit"><img src="resources/images/pic07.jpg" alt="" /></a></div>
												</div>
											</div>
											<a href="#" class="button icon fa-file-alt">More</a>
										</section>
									</div>

							</div>
							<div class="col-8 col-12-medium imp-medium">

								<!-- Content -->
									<div id="content">
										<section class="last">
											<h2>So what's this all about?</h2>
											<p>This is <strong>Verti</strong>, a free and fully responsive HTML5 site template by <a href="http://html5up.net">HTML5 UP</a>.
											Verti is released under the <a href="http://html5up.net/license">Creative Commons Attribution license</a>, so feel free to use it for any personal or commercial project you might have going on (just don't forget to credit us for the design!)</p>
											<p>Phasellus quam turpis, feugiat sit amet ornare in, hendrerit in lectus. Praesent semper bibendum ipsum, et tristique augue fringilla eu. Vivamus id risus vel dolor auctor euismod quis eget mi. Etiam eu ante risus. Aliquam erat volutpat. Aliquam luctus mattis lectus sit amet phasellus quam turpis.</p>
											<a href="#" class="button icon solid fa-arrow-circle-right">Continue Reading</a>
										</section>
									</div>

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

			<script src="resources/js/jquery.min.js"></script>
			<script src="resources/js/jquery.dropotron.min.js"></script>
			<script src="resources/js/browser.min.js"></script>
			<script src="resources/js/breakpoints.min.js"></script>
			<script src="resources/js/util.js"></script>
			<script src="resources/js/main.js"></script>

	</body>
</html>