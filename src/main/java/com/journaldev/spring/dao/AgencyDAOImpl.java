package com.journaldev.spring.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.journaldev.spring.model.AgencyEntity;
import com.journaldev.spring.utility.BaseUtility;

public class AgencyDAOImpl implements AgencyDAO {

	private static final Logger logger = LoggerFactory.getLogger(AgencyDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public AgencyEntity addAgency(AgencyEntity agencyEntity) {
		agencyEntity.setAgencyId(BaseUtility.generateId());
		
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(agencyEntity);
		
		logger.info("Agency saved successfully, Agency Details="+agencyEntity);
		
		return agencyEntity;
	}

	@Override
	public AgencyEntity updateAgency(AgencyEntity agencyEntity) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(agencyEntity);
		
		logger.info("Agency updated successfully, Agency Details="+agencyEntity);
		
		return agencyEntity;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AgencyEntity> listAgencies() {
		Session session = this.sessionFactory.getCurrentSession();
		List<AgencyEntity> agencyList = session.createQuery("from AgencyEntity").list();
		
		return agencyList;
	}

	@Override
	public AgencyEntity getAgencyByAgencyId(String agencyId) {
		Session session = this.sessionFactory.getCurrentSession();		
		AgencyEntity agencyEntity = (AgencyEntity) session.load(AgencyEntity.class, agencyId);
		
		logger.info("Agency loaded successfully, Agency details="+agencyEntity);
		
		return agencyEntity;
	}

	@SuppressWarnings("unchecked")
	@Override
	public AgencyEntity getAgencyByAdminId(String adminId) {
		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery("from AgencyEntity where admin_id=:admin_id");
		query.setParameter("admin_id", adminId);
		
		List<AgencyEntity> agencyList = query.list();
		
		if (agencyList.size() == 1) {
			AgencyEntity agencyEntity = agencyList.get(0);
			
			if (BaseUtility.isObjectNotNull(agencyEntity)) {
				return agencyEntity;
			}
		}
		return null;
	}

	@Override
	public Boolean removeAgency(String agencyId) {
		Session session = this.sessionFactory.getCurrentSession();
		AgencyEntity agencyEntity = (AgencyEntity) session.load(AgencyEntity.class, agencyId);
		
		if(null != agencyEntity){
			session.delete(agencyEntity);
			
			logger.info("Agency deleted successfully, Agency details="+agencyEntity);
			return true;
		}
		
		logger.info("Agency deleted failed, Agency details="+agencyEntity);
		return false;
	}

	@Override
	public Boolean removeAgencyByAdminId(String adminId) {
		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from AgencyEntity where admin_id=:admin_id");
		query.setParameter("admin_id", adminId);
		int deleted = query.executeUpdate();
		
		if (deleted > 0) {
			return true;
		} else {
			return false;
		}
	}
}
