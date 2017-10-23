<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>


<div role="tabpanel" class="tab-pane active">
	<section id="pricing" class="content-block">
		<form:form id="selectPaymentTypeForm" commandName="paymentTypeForm" action="${request.contextPath}/checkout/multi/payment-type/choose" method="post">
			<div class="container">
				<div class="row">
					<div class="col-sm-6 wow fadeInLeft">
						<multi-checkout:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="false" showPaymentInfo="false" showTaxEstimate="false" showTax="true" />
					</div>
					<div class="col-sm-6 wow fadeInLeft">
						<div class="content-block-desc">
							<div class="step-body-form">
						        <div class="radiobuttons_paymentselection">
						            <c:forEach items="${paymentTypes}" var="paymentType">
						                <form:radiobutton path="paymentType" id="PaymentTypeSelection_${paymentType.code}" value="${paymentType.code}" label="${paymentType.displayName}" />
						                <br>
						            </c:forEach>
						        </div>
						
						        <formElement:formInputBox idKey="PurchaseOrderNumber" labelKey="checkout.multi.purchaseOrderNumber.label" path="purchaseOrderNumber" inputCSS="text" />
						
						        <div id="costCenter">
						            <formElement:formSelectBox idKey="costCenterSelect" labelKey="checkout.multi.costCenter.label" path="costCenterId" skipBlank="false" skipBlankMessageKey="checkout.multi.costCenter.title.pleaseSelect" itemValue="code" itemLabel="name" items="${costCenters}" mandatory="true" selectCSSClass="form-control"/>
						        </div>
						    </div>
						
							<button id="choosePaymentType_continue_button" type="submit" class="btn btn-primary btn-block checkout-next btn btn-warning">
								<spring:theme code="checkout.multi.paymentType.continue"/>
							</button>
						</div>
					</div>
				</div>
			</div>
			<!-- <button href="buy.html" class="btn btn-warning">BUY NOW</button> -->
		</form:form>
	</section>
</div>
