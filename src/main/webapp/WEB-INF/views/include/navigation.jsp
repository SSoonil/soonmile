
<!-- Nav -->
<nav id="nav">
	<ul>
		<li class="current"><a href="index.html">Welcome</a></li>
		<li><a href="#">Dropdown</a>
			<ul>
				<li><a href="#">Lorem ipsum dolor</a></li>
				<li><a href="#">Magna phasellus</a></li>
				<li><a href="#">Phasellus consequat</a>
					<ul>
						<li><a href="#">Lorem ipsum dolor</a></li>
						<li><a href="#">Phasellus consequat</a></li>
						<li><a href="#">Magna phasellus</a></li>
						<li><a href="#">Etiam dolore nisl</a></li>
					</ul></li>
				<li><a href="#">Veroeros feugiat</a></li>
			</ul></li>
		<li><a href="/board/map">Map</a></li>
		<%
		if (com.sist.web.util.CookieUtil.getCookie(request, (String) request.getAttribute("AUTH_COOKIE_NAME")) == null) {
		%>
		<li><a href="/user/joinForm">Login/Sign up</a></li>
		<%
		} else {
		%>
		<li><a href="/user/myInfo">my info</a></li>
		<%
		}
		%>
		<li><a href="#">No Sidebar</a></li>
	</ul>
</nav>