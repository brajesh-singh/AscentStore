<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>

	<!-- Navigation end -->
	 <!-- Tab panes -->
	 
<template:page pageTitle="${pageTitle}">
	<section id="payment" class="content-block" style="min-height:600px;">
	<div class="container">
	<div class="row">
	<div class="wow fadeInLeft"><h2 class="content-block-header">PAYMENT INFO</h2></div>
	<div class="content-block-line"></div>    
	<div class="wow fadeInLeft">
	<div class="col-sm-12"><h2 class="content-block-header">Total: $9999.00 <!--<small class="pull-right"> 12 month Subscription</small>--></h2></div>
	<div class="clearfix">&nbsp;</div>
	<!--<div class="content-block-line"></div>-->
	</div>
	</div>
	<div class="row">
	<div class="col-sm-12 col-md-4">
	<h4 class="content-block-header">Saved Billing Address</h4>
	<div class="clearfix">&nbsp;</div>
	<div class="panel panel-default panel-body">
	<div class="col-sm-1"><input type="radio"></div>
	<div class="col-sm-10">
	<p>123 Main St.<br />Charlotte, NC 28277</p>
	</div>
	</div>
	</div>
	<div class="col-sm-12 col-md-4 ">
	<h4 class="content-block-header">New Billing Address</h4>
	<form class="panel-body">
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
  
  <div class="checkbox">
    <label>
      <input type="checkbox"> Save this address
    </label>
  </div>
</form>
	<div class="clearfix">&nbsp;</div>
	</div>
		<div class="col-sm-12 col-md-4">
			<h4 class="content-block-header">Payment Details</h4>
			<form class="panel-body">
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
  
  <div class="checkbox">
    <label>
      <input type="checkbox"> 
      Save this card
    </label>
  </div>
</form>
	<div class="clearfix">&nbsp;</div>

	    </div>
		 </div>
	<div class="col-sm-12 text-center"><a href="download.html" class="btn btn-warning">Complete Purchase</a></div>
		</div>
</section>
</template:page>
	


