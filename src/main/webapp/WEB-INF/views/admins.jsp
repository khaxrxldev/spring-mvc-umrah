<%@ include file="content/header.jspf" %>
<body>
   	<div id="loading" class="loading d-none">
		<img id="loading-image" class="loading-image" src="<c:url value='/resources/images/loader.png'/>" alt="Loading..." />
	</div>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="w-100">
        <div class="fs-4 fw-bold w-100 py-3 px-4 border border-0 border-bottom">ADMINISTRATIONS</div>
        <div class="w-100 p-2">
        	<div class="w-100 ui card">
		        <div class="fs-6 fw-bold p-2 header bg-light">ADMIN LIST</div>
			    <div class="content overflow-auto">
					<table id="tableId" class="table table-striped compact" style="width:100%">
						<thead>
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Agency</th>
								<th>License number</th>
								<th>Status</th>
						 	</tr>
						</thead>
						<tbody></tbody>
					</table>
			    </div>
			</div>
		</div>
	</div>
	<%@ include file="content/sidebar_footer.jspf" %>
	<script type="text/javascript">
		function onWindowLoad() {
			onGetTableData();
		}
		
		function onGetTableData() {
			$.ajax({
				type: "GET",
		        url: "/SpringMVCHibernate/admins"
		    }).then(function(dataList) {
		    	for(let data of dataList) {
		    		let option1 = $("<option>", { value: "PENDING", text: "PENDING" });
		    		let option2 = $("<option>", { value: "APPROVED", text: "APPROVED" });
		    		let select = $('<select>').addClass('form-select').append(option1).append(option2).change(function () {
		    		    $('#loading').removeClass('d-none');
		    			onUpdate(event, data.admin.adminId);
					});
		    		
		    		if (data.admin.adminStatus) {
		    			select.val(data.admin.adminStatus);
		    		}
		    		
		    		let link = '';
		    		if (data.agency) {
		    			link = $('<a>').attr('href', data.agency.agencyWebsite).attr( 'target','_blank' ).html(data.agency.agencyName);
		    		}
		    		
		    		if (data.admin.adminType === 'ADMIN') {
		    			$('#tableId > tbody:last').append($('<tr>')
							.append($('<td>').append(data.admin.adminName))
							.append($('<td>').append(data.admin.adminEmail))
							.append($('<td>').append(link))
							.append($('<td>').append(data.agency ? data.agency.agencyLicenseNumber : ''))
							.append($('<td>').append(select))
						);
		    		}
				}
		    	
				$('#tableId').dataTable(<%@ include file="content/datatable_options.jspf" %>);
		    });
		}
		
		function onUpdate(evt, adminIdText) {
			let admin = { adminId: adminIdText, adminStatus: evt.target.value };

			$.ajax({
				type: "PUT",
				url: "/SpringMVCHibernate/admin",
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json',
		        data: JSON.stringify(admin)
			}).then(function(data) {
				if (data) {
					$('#tableId').DataTable().clear().destroy();
					onGetTableData();
	    		    $('#loading').addClass('d-none');
				}
			});
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>