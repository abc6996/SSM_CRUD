package com.study.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.dao.DeptMapper;
import com.study.entity.Dept;
import com.study.entity.Msg;
import com.study.service.DeptService;
@Service
public class DeptServiceImpl implements DeptService {

	@Autowired
	private DeptMapper deptMapper;

	@Override
	public List<Dept> getAll() {
		return deptMapper.selectByExample(null);
	}

}
