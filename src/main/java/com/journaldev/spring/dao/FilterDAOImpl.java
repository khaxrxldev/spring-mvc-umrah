package com.journaldev.spring.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.journaldev.spring.model.FilterEntity;
import com.journaldev.spring.utility.BaseUtility;

public class FilterDAOImpl implements FilterDAO {

	private static final Logger logger = LoggerFactory.getLogger(FilterDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}
	
	@Override
	public FilterEntity addFilter(FilterEntity filterEntity) {
		filterEntity.setFilterId(BaseUtility.generateId());
		
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(filterEntity);
		
		logger.info("Filter saved successfully, Filter Details="+filterEntity);
		
		return filterEntity;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FilterEntity> listFilters() {
		Session session = this.sessionFactory.getCurrentSession();
		List<FilterEntity> filterList = session.createQuery("from FilterEntity").list();
		
		return filterList;
	}
}
