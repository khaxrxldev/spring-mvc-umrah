package com.journaldev.spring.dto;

import com.journaldev.spring.model.AdminEntity;
import com.journaldev.spring.model.AgencyEntity;

public class AdminAgencyResponse {
	
	private AdminEntity admin;
	
	private AgencyEntity agency;

	public AdminEntity getAdmin() {
		return admin;
	}

	public void setAdmin(AdminEntity admin) {
		this.admin = admin;
	}

	public AgencyEntity getAgency() {
		return agency;
	}

	public void setAgency(AgencyEntity agency) {
		this.agency = agency;
	}
}
