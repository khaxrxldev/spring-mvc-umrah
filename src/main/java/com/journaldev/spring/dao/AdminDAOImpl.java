package com.journaldev.spring.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.journaldev.spring.dto.LoginRequest;
import com.journaldev.spring.dto.LoginResponse;
import com.journaldev.spring.model.AdminEntity;
import com.journaldev.spring.utility.BaseUtility;

public class AdminDAOImpl implements AdminDAO {

	private static final Logger logger = LoggerFactory.getLogger(AdminDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@SuppressWarnings("unchecked")
	@Override
	public LoginResponse loginAdmin(LoginRequest loginRequest) {
		LoginResponse loginResponse = new LoginResponse();
		
		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery("from AdminEntity where admin_email=:admin_email");
		query.setParameter("admin_email", loginRequest.getLoginUsername());
		
		List<AdminEntity> adminList = query.list();
		
		if (adminList.size() == 1) {
			AdminEntity adminEntity = adminList.get(0);
			
			if (BaseUtility.isObjectNotNull(adminEntity)) {
				if (adminEntity.getAdminStatus().equals("APPROVED")) {
					if (adminEntity.getAdminPassword().equals(loginRequest.getLoginPassword())) {
						loginResponse.setLoginId(adminEntity.getAdminId());
						loginResponse.setLoginType(adminEntity.getAdminType());
						loginResponse.setLoginStatus(true);
						loginResponse.setLoginMessage("Login successfully.");
					} else {
						loginResponse.setLoginStatus(false);
						loginResponse.setLoginError("Wrong password entered.");
					}
				} else {
					loginResponse.setLoginStatus(false);
					loginResponse.setLoginError("Profile has not been approved.");
				}
			} else {
				loginResponse.setLoginStatus(false);
				loginResponse.setLoginError("Email is not registered.");
			}
		} else {
			loginResponse.setLoginStatus(false);
			loginResponse.setLoginError("Email is not registered.");
		}
		
		return loginResponse;
	}

	@Override
	public AdminEntity addAdmin(AdminEntity adminEntity) {
		adminEntity.setAdminId(BaseUtility.generateId());
		adminEntity.setAdminType("ADMIN");
		adminEntity.setAdminStatus("PENDING");
		
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(adminEntity);
		
		logger.info("Admin saved successfully, Admin Details="+adminEntity);
		
		return adminEntity;
	}

	@Override
	public AdminEntity updateAdmin(AdminEntity adminEntity) {
		Session session = this.sessionFactory.getCurrentSession();
		AdminEntity updateAdminEntity = (AdminEntity) session.load(AdminEntity.class, adminEntity.getAdminId());
		if (BaseUtility.isNotBlank(adminEntity.getAdminEmail())) {
			updateAdminEntity.setAdminEmail(adminEntity.getAdminEmail());
		}
		if (BaseUtility.isNotBlank(adminEntity.getAdminGender())) {
			updateAdminEntity.setAdminGender(adminEntity.getAdminGender());
		}
		if (BaseUtility.isNotBlank(adminEntity.getAdminName())) {
			updateAdminEntity.setAdminName(adminEntity.getAdminName());
		}
		if (BaseUtility.isNotBlank(adminEntity.getAdminPassword())) {
			updateAdminEntity.setAdminPassword(adminEntity.getAdminPassword());
		}
		if (BaseUtility.isNotBlank(adminEntity.getAdminType())) {
			updateAdminEntity.setAdminType(adminEntity.getAdminType());
		}
		if (BaseUtility.isNotBlank(adminEntity.getAdminStatus())) {
			updateAdminEntity.setAdminStatus(adminEntity.getAdminStatus());
		}
		session.update(updateAdminEntity);
		
		logger.info("Admin updated successfully, Admin Details="+updateAdminEntity);
		
		return updateAdminEntity;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AdminEntity> listAdmins() {
		Session session = this.sessionFactory.getCurrentSession();
		List<AdminEntity> adminList = session.createQuery("from AdminEntity").list();
		
		return adminList;
	}

	@Override
	public AdminEntity getAdminByAdminId(String adminId) {
		Session session = this.sessionFactory.getCurrentSession();
		AdminEntity adminEntity = (AdminEntity) session.load(AdminEntity.class, adminId);
		
		logger.info("Admin loaded successfully, Admin details="+adminEntity);
		
		return adminEntity;
	}

	@Override
	public Boolean removeAdmin(String adminId) {
		Session session = this.sessionFactory.getCurrentSession();
		AdminEntity adminEntity = (AdminEntity) session.load(AdminEntity.class, adminId);
		
		if(null != adminEntity){
			session.delete(adminEntity);
			
			logger.info("Admin deleted successfully, Admin details="+adminEntity);
			return true;
		}
		
		logger.info("Admin deleted failed, Admin details="+adminEntity);
		return false;
	}
}
