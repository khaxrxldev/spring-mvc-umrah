package com.journaldev.spring.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.journaldev.spring.dao.AdminDAO;
import com.journaldev.spring.dao.AgencyDAO;
import com.journaldev.spring.dao.FilterDAO;
import com.journaldev.spring.dto.LoginRequest;
import com.journaldev.spring.dto.LoginResponse;
import com.journaldev.spring.model.AdminEntity;
import com.journaldev.spring.model.AgencyEntity;
import com.journaldev.spring.model.FilterEntity;

public class UmrahServiceImpl implements UmrahService {

	private FilterDAO filterDAO;
	
	private AdminDAO adminDAO;
	
	private AgencyDAO agencyDAO;
	
	public void setFilterDAO(FilterDAO filterDAO) {
		this.filterDAO = filterDAO;
	}

	public void setAdminDAO(AdminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}

	public void setAgencyDAO(AgencyDAO agencyDAO) {
		this.agencyDAO = agencyDAO;
	}
	
	@Override
	@Transactional
	public FilterEntity addFilter(FilterEntity filterEntity) {
		return filterDAO.addFilter(filterEntity);
	}

	@Override
	@Transactional
	public List<FilterEntity> listFilters() {
		return filterDAO.listFilters();
	}

	@Override
	@Transactional
	public LoginResponse loginAdmin(LoginRequest loginRequest) {
		return adminDAO.loginAdmin(loginRequest);
	}
	
	@Override
	@Transactional
	public AdminEntity addAdmin(AdminEntity adminEntity) {
		return adminDAO.addAdmin(adminEntity);
	}

	@Override
	@Transactional
	public List<AdminEntity> listAdmins() {
		return adminDAO.listAdmins();
	}

	@Override
	@Transactional
	public AdminEntity updateAdmin(AdminEntity adminEntity) {
		return adminDAO.updateAdmin(adminEntity);
	}

	@Override
	@Transactional
	public AdminEntity getAdminByAdminId(String adminId) {
		return adminDAO.getAdminByAdminId(adminId);
	}

	@Override
	@Transactional
	public Boolean removeAdmin(String adminId) {
		return adminDAO.removeAdmin(adminId);
	}

	@Override
	@Transactional
	public AgencyEntity addAgency(AgencyEntity agencyEntity) {
		return agencyDAO.addAgency(agencyEntity);
	}

	@Override
	@Transactional
	public AgencyEntity updateAgency(AgencyEntity agencyEntity) {
		return agencyDAO.updateAgency(agencyEntity);
	}

	@Override
	@Transactional
	public List<AgencyEntity> listAgencies() {
		return agencyDAO.listAgencies();
	}

	@Override
	@Transactional
	public AgencyEntity getAgencyByAgencyId(String agencyId) {
		return agencyDAO.getAgencyByAgencyId(agencyId);
	}

	@Override
	@Transactional
	public AgencyEntity getAgencyByAdminId(String adminId) {
		return agencyDAO.getAgencyByAdminId(adminId);
	}

	@Override
	@Transactional
	public Boolean removeAgency(String agencyId) {
		return agencyDAO.removeAgency(agencyId);
	}

	@Override
	@Transactional
	public Boolean removeAgencyByAdminId(String adminId) {
		return agencyDAO.removeAgencyByAdminId(adminId);
	}
}
