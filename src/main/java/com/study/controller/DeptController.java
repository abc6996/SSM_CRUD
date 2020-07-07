package com.study.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.entity.Dept;
import com.study.entity.Msg;
import com.study.service.DeptService;

/**
 * 处理部门有关的请求
 * @author DWJ
 * @Date 2020-05-16 16:03:32
 * @Description
 *
 */
@Controller
public class DeptController {

	@Autowired
	private DeptService deptService;
	
	@RequestMapping(value = "depts")
	@ResponseBody
	public Msg getDepts() {
		List<Dept> list = deptService.getAll();
		return Msg.success().add("depts", list);
	}
}
