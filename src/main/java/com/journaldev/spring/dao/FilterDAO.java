package com.journaldev.spring.dao;

import java.util.List;

import com.journaldev.spring.model.FilterEntity;

public interface FilterDAO {
	public FilterEntity addFilter(FilterEntity filterEntity);
	public List<FilterEntity> listFilters();
}
