package com.journaldev.spring;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.journaldev.spring.dto.AdminAgencyResponse;
import com.journaldev.spring.dto.LoginRequest;
import com.journaldev.spring.dto.LoginResponse;
import com.journaldev.spring.model.AdminEntity;
import com.journaldev.spring.model.AgencyEntity;
import com.journaldev.spring.model.FilterEntity;
import com.journaldev.spring.service.UmrahService;
import com.journaldev.spring.utility.BaseUtility;

@Controller
public class UmrahController {
	
	private UmrahService umrahService;
	
	@Autowired(required=true)
	@Qualifier(value="umrahService")
	public void setUmrahService(UmrahService us){
		this.umrahService = us;
	}
	
    @RequestMapping(value = "/", method = RequestMethod.GET)
	public String indexPage() {
		return "index";
	}
	
    @RequestMapping(value = "/admin/login/page", method = RequestMethod.GET)
	public String adminLoginPage() {
		return "admin_login";
	}
	
    @RequestMapping(value = "/admin/login", method = RequestMethod.POST)
    @ResponseBody
	public LoginResponse adminLogin(@RequestBody LoginRequest loginRequest) {
		return umrahService.loginAdmin(loginRequest);
	}
	
    @RequestMapping(value = "/user/filters/page", method = RequestMethod.GET)
	public String userFiltersPage() {
		return "user_filters";
	}
	
    @RequestMapping(value = "/user/agencies/page", method = RequestMethod.GET)
	public String userAgenciesPage() {
		return "user_agencies";
	}
	
    @RequestMapping(value = "/admin/filters/page", method = RequestMethod.GET)
	public String adminFiltersPage() {
		return "admin_filters";
	}

    @RequestMapping(value = "/filter", method = RequestMethod.POST)
    @ResponseBody
	public FilterEntity addFilter(@RequestBody FilterEntity filterEntity) {
		return umrahService.addFilter(filterEntity);
	}
    
    @RequestMapping(value = "/admin/filters", method = RequestMethod.GET)
    @ResponseBody
	public List<FilterEntity> adminFilters() {
		return umrahService.listFilters();
	}
	
    @RequestMapping(value = "/admins/page", method = RequestMethod.GET)
	public String adminsPage() {
		return "admins";
	}
	
    @RequestMapping(value = "/admin/profile/page", method = RequestMethod.GET)
	public String adminProfilePage() {
		return "admin_profile";
	}
	
    @RequestMapping(value = "/admin", method = RequestMethod.POST)
    @ResponseBody
	public AdminEntity addAdmin(@RequestBody AdminEntity adminEntity) {
		return umrahService.addAdmin(adminEntity);
	}
	
    @RequestMapping(value = "/admin", method = RequestMethod.PUT)
    @ResponseBody
	public AdminEntity updateAdmin(@RequestBody AdminEntity adminEntity) {
		return umrahService.updateAdmin(adminEntity);
	}
    
    @RequestMapping(value = "/admins", method = RequestMethod.GET)
    @ResponseBody
	public List<AdminAgencyResponse> admins() {
    	List<AdminAgencyResponse> adminAgencyResponses = new ArrayList<AdminAgencyResponse>();
    	List<AdminEntity> adminEntities = umrahService.listAdmins();
    	
    	for (AdminEntity adminEntity : adminEntities) {
			AdminAgencyResponse adminAgencyResponse = new AdminAgencyResponse();
			adminAgencyResponse.setAdmin(adminEntity);
			
			AgencyEntity agencyEntity = umrahService.getAgencyByAdminId(adminEntity.getAdminId());
			if (BaseUtility.isObjectNotNull(agencyEntity)) {
				adminAgencyResponse.setAgency(agencyEntity);
			}
			
			adminAgencyResponses.add(adminAgencyResponse);
		}
		return adminAgencyResponses;
	}
    
    @RequestMapping(value = "/admin/{admin_id}", method = RequestMethod.GET)
    @ResponseBody
	public AdminEntity getAdminByAdminId(@PathVariable("admin_id") String admin_id) {
		return umrahService.getAdminByAdminId(admin_id);
	}
    
    @RequestMapping(value = "/admin/{admin_id}", method = RequestMethod.DELETE)
    @ResponseBody
	public Boolean removeAdmin(@PathVariable("admin_id") String admin_id) {
		return umrahService.removeAdmin(admin_id);
	}
	
    @RequestMapping(value = "/agency/profile/page", method = RequestMethod.GET)
	public String agencyProfilePage() {
		return "agency_profile";
	}
	
    @RequestMapping(value = "/agency", method = RequestMethod.POST)
    @ResponseBody
	public AgencyEntity addAgency(@RequestBody AgencyEntity agencyEntity) {
		return umrahService.addAgency(agencyEntity);
	}
	
    @RequestMapping(value = "/agency", method = RequestMethod.PUT)
    @ResponseBody
	public AgencyEntity updateAgency(@RequestBody AgencyEntity agencyEntity) {
		return umrahService.updateAgency(agencyEntity);
	}
    
    @RequestMapping(value = "/agencies", method = RequestMethod.GET)
    @ResponseBody
	public List<AgencyEntity> agencies() {
		return umrahService.listAgencies();
	}
    
    @RequestMapping(value = "/agency/{agency_id}", method = RequestMethod.GET)
    @ResponseBody
	public AgencyEntity getAgencyByAgencyId(@PathVariable("agency_id") String agency_id) {
		return umrahService.getAgencyByAgencyId(agency_id);
	}
    
    @RequestMapping(value = "/agency/admin/{admin_id}", method = RequestMethod.GET)
    @ResponseBody
	public AgencyEntity getAgencyByAdminId(@PathVariable("admin_id") String admin_id) {
		return umrahService.getAgencyByAdminId(admin_id);
	}
    
    @RequestMapping(value = "/agency/{agency_id}", method = RequestMethod.DELETE)
    @ResponseBody
	public Boolean removeAgency(@PathVariable("agency_id") String agency_id) {
		return umrahService.removeAgency(agency_id);
	}
    
    @RequestMapping(value = "/agency/admin/{admin_id}", method = RequestMethod.DELETE)
    @ResponseBody
	public Boolean removeAgencyByAdminId(@PathVariable("admin_id") String admin_id) {
		return umrahService.removeAgencyByAdminId(admin_id);
	}
}
