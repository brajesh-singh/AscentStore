<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="productName" required="true" type="java.lang.String" %>
<header id="navbar" class="header">
<nav class="navbar navbar-custom detail-nav" role="navigation">

	<div class="container-fluid">
	
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#custom-collapse-sub">
			<span class="sr-only"></span> <span class="icon-bar"></span> <span
			class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand"><span class="fa fa-cube"></span>
			${fn:escapeXml(productName)}</a>
		</div>
		
	</div>

</nav>
</header>