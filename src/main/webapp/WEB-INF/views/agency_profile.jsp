<%@ include file="content/header.jspf" %>
<body>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="row g-0">
	    <div class="col-lg-5 col-12 p-4">
            <div id="delete_msg" class="d-none ui message"></div>
	        <span class="fs-4 fw-bold">AGENCY</span>
			<input type="text" class="d-none" id="agencyIdDisplay">
	        <table id="normalTable" class="w-100 mt-3">
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Company name</td>
	        		<td class="px-3 py-2" id="disp_name"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">License number</td>
	        		<td class="px-3 py-2" id="disp_license_number"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Email</td>
	        		<td class="px-3 py-2" id="disp_email"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Phone number</td>
	        		<td class="px-3 py-2" id="disp_phone_number"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Website</td>
	        		<td class="px-3 py-2" id="disp_website"></td>
	        	</tr>
	        	<tr>
	        		<td class="fw-bold bg-light px-3 py-2">Address</td>
	        		<td style="white-space: pre-wrap;" class="px-3 py-2" id="disp_address"></td>
	        	</tr>
	        </table>
            <div class="mt-3" style="text-align: right;">
	            <button type="button" class="small ui right labeled icon button red" data-bs-toggle="modal" data-bs-target="#deleteModal">
		            <i class="ban icon"></i>
		            Delete
	            </button>
	            <button type="submit" class="small ui right labeled icon button green" data-bs-toggle="modal" data-bs-target="#insertModal" onclick="onGetAgency()">
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
	            <div class="modal-body">Confirm to delete agency?</div>
	            <div class="modal-footer">
	                <button class="small ui negative right labeled icon button" data-bs-dismiss="modal">Cancel <i class="close icon"></i></button>
	                <button class="small ui positive right labeled icon button" onclick="onDeleteAgency()">Confirm <i class="checkmark icon"></i></button>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <form id="agencyFormId" onsubmit="onSubmitAgency()">
		            <div class="modal-body">
            			<div id="submit_msg" class="d-none ui message"></div>
            			<div>
				            Name
				            <input type="text" class="d-none" id="agencyId" name="agencyId">
				            <input type="text" class="d-none" id="adminId" name="adminId">
			                <input type="text" class="form-control mt-1 text-uppercase" id="agencyName" name="agencyName" required="required" oninput="this.value = this.value.toUpperCase()">
				        </div>
				        <div class="mt-3">
				            License number
			                <input type="text" class="form-control mt-1" id="agencyLicenseNumber" name="agencyLicenseNumber" required="required">
				        </div>
				        <div class="mt-3">
				            Email address
			                <input type="email" class="form-control mt-1" id="agencyEmail" name="agencyEmail" required="required">
				        </div>
				        <div class="mt-3">
				            Phone number
			                <input type="text" class="form-control mt-1" id="agencyPhoneNum" name="agencyPhoneNum" required="required">
				        </div>
				        <div class="mt-3">
				            Website
			                <input type="text" class="form-control mt-1" id="agencyWebsite" name="agencyWebsite" required="required">
				        </div>
				        <div class="mt-3">
				            Address
		              		<textarea style="resize: none;" class="form-control mt-1 text-uppercase" rows="5" id="agencyAddress" name="agencyAddress" oninput="this.value = this.value.toUpperCase()"></textarea>
				        </div>
		            </div>
			        <div class="modal-footer">
		                <button type="button" class="small ui yellow right labeled icon button" onclick="removeMessage('submit_msg')" data-bs-dismiss="modal">Close <i class="close icon"></i></button>
		                <button type="submit" class="small ui blue right labeled icon button">Submit <i class="checkmark icon"></i></button>
		            </div>
				</form>
	        </div>
	    </div>
	</div>
	<script type="text/javascript">
		function onWindowLoad() {
			onDisplayAgency();
		}
		
		function onDisplayAgency() {
			$('#disp_name').html('');
			$('#disp_license_number').html('');
			$('#disp_email').html('');
			$('#disp_phone_number').html('');
			$('#disp_website').html('');
			$('#disp_address').html('');
			
			$.ajax({
				type: "GET",
		        url: "/SpringMVCHibernate/agency/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
		    	if (data) {
		    		$('#agencyIdDisplay').val(data.agencyId);
					$('#disp_name').html(data.agencyName);
					$('#disp_license_number').html(data.agencyLicenseNumber);
					$('#disp_email').html(data.agencyEmail);
					$('#disp_phone_number').html(data.agencyPhoneNum);
					$('#disp_website').append($('<a>').attr('href', data.agencyWebsite).attr('target', '_blank').html('Visit Website'));
					$('#disp_address').html(data.agencyAddress);
		    	}
		    });
		}
		
		function onGetAgency() {
			$.ajax({
				type: "GET",
		        url: "/SpringMVCHibernate/agency/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
			    setForm("agencyFormId", data);
				$("#agencyFormId #adminId").val(sessionStorage.getItem("login_id"));
		    });
		}
		
		function onSubmitAgency() {
			event.preventDefault();
			
			let form = form2js(agencyFormId, null, false);
			
			$.ajax({
				type: $("#agencyId").val() ? "PUT" : "POST",
		        url: "/SpringMVCHibernate/agency",
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json',
		        data: JSON.stringify(form)
		    }).then(function(data) {
				if (data) {
					onDisplayAgency();
		        	$("#submit_msg").removeClass("d-none");
		        	$("#submit_msg").addClass("green");
		        	$("#submit_msg").html("Successfully update.");
				}
		    });
		}
		
		function onDeleteAgency() {
			$('#deleteModal').modal('hide');
			
			$.ajax({
				type: "DELETE",
		        url: "/SpringMVCHibernate/agency/" + $('#agencyIdDisplay').val()
		    }).then(function(data) {
		    	onDisplayAgency();
		    	if (data) {
		        	$("#delete_msg").removeClass("d-none");
		        	$("#delete_msg").addClass("green");
		        	$("#delete_msg").html("Successfully delete.");
		    	} else {
		        	$("#delete_msg").removeClass("d-none");
		        	$("#delete_msg").addClass("red");
		        	$("#delete_msg").html("Failed to delete.");
		    	}
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>