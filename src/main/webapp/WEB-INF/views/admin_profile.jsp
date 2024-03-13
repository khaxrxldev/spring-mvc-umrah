<%@ include file="content/header.jspf" %>
<body>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="row g-0">
	    <div class="col-lg-5 col-12 p-4">
	        <span class="fs-4 fw-bold">PROFILE</span>
	        <table id="normalTable" class="w-100 mt-3">
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Full name</td>
	        		<td class="px-3 py-2" id="disp_name"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Gender</td>
	        		<td class="px-3 py-2" id="disp_gender"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Email</td>
	        		<td class="px-3 py-2" id="disp_email"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Password</td>
	        		<td class="px-3 py-2" id="disp_password">
	        			<span id="disp_password_mask"></span>
	        			<span id="disp_password_text"></span>
	        		</td>
	        	</tr>
	        </table>
			<div class="mt-3" style="text-align: right;">
	            <button type="button" class="small ui right labeled icon button red" data-bs-toggle="modal" data-bs-target="#deleteModal">
		            <i class="ban icon"></i>
		            Delete
	            </button>
	            <button type="button" class="small ui right labeled icon button green" data-bs-toggle="modal" data-bs-target="#insertModal" onclick="onGetAdmin()">
		            <i class="check icon"></i>
		            Update
	            </button>
	        </div>
	    </div>
	    <div class="col-lg-7 col-12"></div>
	</div>
	<%@ include file="content/sidebar_footer.jspf" %>
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-body">Confirm to delete account?</div>
	            <div class="modal-footer">
	                <button class="small ui negative right labeled icon button" data-bs-dismiss="modal">Cancel <i class="close icon"></i></button>
	                <button class="small ui positive right labeled icon button" onclick="onDeleteAdmin()">Confirm <i class="checkmark icon"></i></button>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
		        <form id="adminFormId" onsubmit="onUpdateAdmin()">
		        	<div class="modal-body">
	        			<div id="update_msg" class="d-none ui message"></div>
				        <div>
				            Full name
				            <input type="text" class="d-none" id="adminId" name="adminId">
			                <input type="text" class="form-control mt-1 text-uppercase" id="adminName" name="adminName" required="required" oninput="this.value = this.value.toUpperCase()">
				        </div>
				        <div class="mt-3">
				            Gender
				            <select class="form-select" id="adminGender" name="adminGender" required="required">
			                    <option selected hidden disabled>Choose Gender</option>
								<option value="MALE">MALE</option>
								<option value="FEMALE">FEMALE</option>
			                </select>
				        </div>
				        <div class="mt-3">
				            Email address
			                <input type="email" class="form-control mt-1" id="adminEmail" name="adminEmail" required="required">
				        </div>
				        <div class="mt-3">
				            Password
			                <input type="password" class="form-control mt-1" id="adminPassword" name="adminPassword" required="required">
				        </div>
	            	</div>
		            <div class="modal-footer">
		                <button type="button" class="small ui yellow right labeled icon button" onclick="removeMessage('update_msg')" data-bs-dismiss="modal">Close <i class="close icon"></i></button>
		                <button type="submit" class="small ui blue right labeled icon button">Submit <i class="checkmark icon"></i></button>
		            </div>
				</form>
	        </div>
	    </div>
	</div>
	<script type="text/javascript">
		function onWindowLoad() {
			onDisplayAdmin();
		}
		
		function onDisplayAdmin() {
			$('#disp_name').html('');
			$('#disp_gender').html('');
			$('#disp_email').html('');
			$('#disp_password_text').html('');
			$('#disp_password_mask').html('');
			
			$.ajax({
				type: "GET",
		        url: "/SpringMVCHibernate/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
				$('#disp_name').html(data.adminName);
				$('#disp_gender').html(data.adminGender);
				$('#disp_email').html(data.adminEmail);
				$('#disp_password_text').html(data.adminPassword);
				$('#disp_password_mask').html(('*').repeat(data.adminPassword.length));
		    });
		}
		
		function onGetAdmin() {
			$.ajax({
				type: "GET",
		        url: "/SpringMVCHibernate/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
			    setForm("adminFormId", data);
		    });
		}
		
		function onUpdateAdmin() {
			event.preventDefault();

			let form = form2js(adminFormId, null, false);

			$.ajax({
				type: "PUT",
				url: "/SpringMVCHibernate/admin",
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json',
		        data: JSON.stringify(form)
			}).then(function(data) {
				if (data) {
					onDisplayAdmin();
		        	$("#update_msg").removeClass("d-none");
		        	$("#update_msg").addClass("green");
		        	$("#update_msg").html("Successfully update.");
				}
			});
		}
		
		function onDeleteAdmin() {
			/*
			$.ajax({
				type: "DELETE",
		        url: "/SpringMVCHibernate/agency/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
		    	if (data) {
		    		$.ajax({
						type: "DELETE",
				        url: "/SpringMVCHibernate/admin/" + sessionStorage.getItem("login_id")
				    }).then(function(data) {
				    	if (data) {
							window.location.href = "/SpringMVCHibernate/";
				    	}
				    });
		    	}
		    });
			*/
			$.ajax({
				type: "DELETE",
		        url: "/SpringMVCHibernate/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
		    	if (data) {
					window.location.href = "/SpringMVCHibernate/";
		    	}
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>