package com.journaldev.spring.dao;

import java.util.List;

import com.journaldev.spring.model.AgencyEntity;

public interface AgencyDAO {
	public AgencyEntity addAgency(AgencyEntity agencyEntity);
	public AgencyEntity updateAgency(AgencyEntity agencyEntity);
	public List<AgencyEntity> listAgencies();
	public AgencyEntity getAgencyByAgencyId(String agencyId);
	public AgencyEntity getAgencyByAdminId(String adminId);
	public Boolean removeAgency(String agencyId);
	public Boolean removeAgencyByAdminId(String adminId);
}
