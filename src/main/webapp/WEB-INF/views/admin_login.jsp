<%@ include file="content/header.jspf" %>
<body class="pt-5 bg-light">
	<%@ include file="content/script.jspf" %>
	<div class="row g-0">
	    <div class="col-lg-4 col-12"></div>
	    <div class="col-lg-4 col-12">
	        <div class="ui top attached tabular menu">
	            <a class="item w-50 active" data-tab="signin">Sign In</a>
	            <a class="item w-50" data-tab="signup">Sign Up</a>
	        </div>
	        <div class="ui bottom attached tab segment p-4 active" data-tab="signin">
	            <div id="signin_msg" class="d-none ui mx-5 message"></div>
	            <form id="adminLoginForm" onsubmit="onLogin(event, '/SpringMVCHibernate/admin/login', 'adminLoginForm')">
	            	<div class="mt-3 px-5">
		                Email address
		                <input type="email" class="form-control mt-1" name="loginUsername" id="loginUsername" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Password
		                <input type="password" class="form-control mt-1" name="loginPassword" id="loginPassword" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                <button type="submit" class="small ui right labeled icon button teal">
			                <i class="right arrow icon"></i>
			                Login
		                </button>
		            </div>
	            </form>
	        </div>
	        <div class="ui bottom attached tab segment p-4" data-tab="signup">
	            <div id="signup_msg" class="d-none ui mx-5 message"></div>
	            <form id="formId" onsubmit="onSubmitAdmin()">
		            <div class="mt-3 px-5">
		                Email address
		                <input type="email" class="form-control mt-1" id="adminEmail" name="adminEmail" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Password
		                <input type="password" class="form-control mt-1" id="adminPassword" name="adminPassword" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Agency name
		                <input type="text" class="form-control mt-1 text-uppercase" id="agencyName" name="agencyName" required="required" oninput="this.value = this.value.toUpperCase()">
		            </div>
		            <div class="mt-3 px-5">
		                Agency license number
		                <input type="text" class="form-control mt-1" id="agencyLicenseNumber" name="agencyLicenseNumber" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                <button type="submit" class="small ui right labeled icon button teal">
			                <i class="right arrow icon"></i>
			                Register
		                </button>
		            </div>
		    	</form>
	        </div>
	    </div>
	    <div class="col-lg-4 col-12"></div>
	</div>
	<script type="text/javascript">
    	$('.menu .item').tab();
		function onWindowLoad() {}
		
		function onLogin(event, loginURL, loginFormId) {
		    event.preventDefault();

		    let loginForm = form2js(loginFormId, null, false);

		    $.ajax({
		        type: "POST",
		        url: loginURL,
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json',
		        data: JSON.stringify(loginForm)
		    }).then(function(data) {
		        if (data.loginStatus) {
		            sessionStorage.setItem("login_id", data.loginId);
		            sessionStorage.setItem("login_type", data.loginType);
		            switch(data.loginType) {
						case "ADMIN":
				            window.location.href = '/SpringMVCHibernate/admin/profile/page';
						  break;
						case "SUPERADMIN":
				            window.location.href = '/SpringMVCHibernate/admins/page';
						  break;
					}
		        } else {
		        	$("#signin_msg").removeClass("d-none");
		        	$("#signin_msg").addClass("red");
		        	$("#signin_msg").html(data.loginError);
		        }
		    });
		}
		
		function onSubmitAdmin() {
		    event.preventDefault();

		    let adminObject = {};
		    adminObject['adminEmail'] = $('#adminEmail').val();
		    adminObject['adminPassword'] = $('#adminPassword').val();

		    $.ajax({
		        type: "POST",
		        url: "/SpringMVCHibernate/admin",
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json',
		        data: JSON.stringify(adminObject)
		    }).then(function(data) {
		        if (data) {
					onSubmitAgency(data.adminId);
		        }
		    });
		}
		
		function onSubmitAgency(adminId) {
		    let agencyObject = {};
		    agencyObject['agencyName'] = $('#agencyName').val();
		    agencyObject['agencyLicenseNumber'] = $('#agencyLicenseNumber').val();
		    agencyObject['adminId'] = adminId;

		    $.ajax({
		        type: "POST",
		        url: "/SpringMVCHibernate/agency",
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json',
		        data: JSON.stringify(agencyObject)
		    }).then(function(data) {
		        if (data) {
		            resetForm('formId');
		        	$("#signup_msg").removeClass("d-none");
		        	$("#signup_msg").addClass("green");
		        	$("#signup_msg").html("Successfully register.");
		        }
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>