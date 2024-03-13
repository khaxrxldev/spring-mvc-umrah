package com.journaldev.spring.dao;

import java.util.List;

import com.journaldev.spring.dto.LoginRequest;
import com.journaldev.spring.dto.LoginResponse;
import com.journaldev.spring.model.AdminEntity;

public interface AdminDAO {
	public LoginResponse loginAdmin(LoginRequest loginRequest);
	public AdminEntity addAdmin(AdminEntity adminEntity);
	public AdminEntity updateAdmin(AdminEntity adminEntity);
	public List<AdminEntity> listAdmins();
	public AdminEntity getAdminByAdminId(String adminId);
	public Boolean removeAdmin(String adminId);
}
