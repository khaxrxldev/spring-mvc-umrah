<%@ include file="content/header.jspf" %>
<body class="pt-5 bg-light">
	<%@ include file="content/script.jspf" %>
    <div class="w-100 text-center">
    	<div id="popupId" class="ui grey label copy-popup">Copied.</div>
    </div>
	<div class="row g-2">
	    <div class="col-lg-1 col-12"></div>
	    <div class="col-lg-10 col-12 text-center border border-bottom-0 bg-white text-center fw-bold p-2 fs-4">
	    	UMRAH AGENCIES
	    </div>
	    <div class="col-lg-1 col-12"></div>
	</div>
	<div class="row g-2">
	    <div class="col-lg-1 col-12"></div>
	    <div class="col-lg-10 col-12 text-center border bg-white">
	    	<div class="row g-0">
	    		<div class="col-lg-3 col-12"></div>
	    		<div class="col-lg-6 col-12 p-3">
	    			<input class="form-control text-uppercase" type="text" placeholder="Find registered agencies" id="filterId" oninput="this.value = this.value.toUpperCase()">
	    		</div>
	    		<div class="col-lg-3 col-12"></div>
	    	</div>
	    </div>
	    <div class="col-lg-1 col-12"></div>
	</div>
	<div class="row g-2 mt-4">
	    <div class="col-lg-1 col-12"></div>
	    <div class="col-lg-10 col-12">
	        <div class="ui three stackable cards" id="agencyCardId"></div>
	    </div>
	    <div class="col-lg-1 col-12"></div>
	</div>
	<script type="text/javascript">
		function onWindowLoad() {
			onGetAgencies();
		}
		
		$("#filterId").on('keydown paste cut input', function(event) {
			$("div.card").each( function() {
				if (this.id.indexOf(event.target.value) > -1) {
					this.classList.remove("d-none");
			    } else {
					this.classList.add("d-none");
			    }
			});
		});
		
		function onGetAgencies() {
			$.ajax({
				type: "GET",
		        url: "/SpringMVCHibernate/agencies"
		    }).then(function(dataList) {
		    	for (let data of dataList) {
		    		let phoneBtn = $('<button>').addClass('ui icon button blue').click(function() { copyToClipboard(data.agencyPhoneNum); });
		    		let phoneIcon = $('<i>').addClass('phone icon');
		    		phoneBtn.append(phoneIcon);

		    		let mailBtn = $('<button>').addClass('ui icon button teal').click(function() { window.location.href = "mailto:" + data.agencyEmail; });
		    		let mailIcon = $('<i>').addClass('mail icon');
		    		mailBtn.append(mailIcon);

		    		let webBtn = $('<a>').attr('href', data.agencyWebsite).attr('target', '_blank').addClass('ui icon button green');
		    		let webIcon = $('<i>').addClass('globe icon');
		    		webBtn.append(webIcon);
		    		
		    		let extraDiv = $('<div>').addClass('extra content').append(webBtn).append(mailBtn).append(phoneBtn);
		    		
		    		let divDesc = $('<div>').addClass('description mt-0 py-3 ps-3').css('white-space', 'pre-wrap').append(data.agencyAddress);
		    		let divMeta = $('<div>').addClass('meta pb-2 ps-3 border-bottom').append(data.agencyLicenseNumber);
		    		let divHeader = $('<div>').addClass('header pt-3 ps-3').append(data.agencyName);
		    		
		    		let divContent = $('<div>').addClass('content p-0').append(divHeader).append(divMeta).append(divDesc);
		    		
		    		let divCard = $('<div>').addClass('card').attr('id', data.agencyName).append(divContent).append(extraDiv);
		    		
		    		$('#agencyCardId').append(divCard);
		    	}
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>