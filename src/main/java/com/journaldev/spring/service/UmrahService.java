package com.journaldev.spring.service;

import java.util.List;

import com.journaldev.spring.dto.LoginRequest;
import com.journaldev.spring.dto.LoginResponse;
import com.journaldev.spring.model.AdminEntity;
import com.journaldev.spring.model.AgencyEntity;
import com.journaldev.spring.model.FilterEntity;

public interface UmrahService {
	public FilterEntity addFilter(FilterEntity filterEntity);
	public List<FilterEntity> listFilters();
	public LoginResponse loginAdmin(LoginRequest loginRequest);
	public AdminEntity addAdmin(AdminEntity adminEntity);
	public AdminEntity updateAdmin(AdminEntity adminEntity);
	public List<AdminEntity> listAdmins();
	public AdminEntity getAdminByAdminId(String adminId);
	public Boolean removeAdmin(String adminId);
	public AgencyEntity addAgency(AgencyEntity agencyEntity);
	public AgencyEntity updateAgency(AgencyEntity agencyEntity);
	public List<AgencyEntity> listAgencies();
	public AgencyEntity getAgencyByAgencyId(String agencyId);
	public AgencyEntity getAgencyByAdminId(String adminId);
	public Boolean removeAgency(String agencyId);
	public Boolean removeAgencyByAdminId(String adminId);
}
