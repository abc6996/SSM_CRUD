package com.study.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.entity.Employee;
import com.study.entity.Msg;
import com.study.service.EmployeeService;

/**
 * 处理员工CRUD
 * 
 * @author DWJ
 * @Date 2020-05-10 17:33:22
 * @Description
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	/**
	 * 单个/批量删除员工
	 * 
	 */
	@RequestMapping(value = "emp/{id}",method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("id")String ids) {
		System.out.println(ids);
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			employeeService.deleteEmpById(Integer.parseInt(ids));
		}
		return Msg.success();
	}
	
	
	
	/**
	 * 员工更新
	 */
	@RequestMapping(value = "emp/{empId}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 查询员工信息
	 */
	@RequestMapping(value = "emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable(value = "id") Integer empId) {
		Employee emp = employeeService.getEmp(empId);
		System.out.println(emp);
		return Msg.success().add("emp", emp);
	}
	
	
	@RequestMapping(value = "checkUserName")
	@ResponseBody
	public Msg checkUserName(@RequestParam(value = "empName")String empName) {
		String regx="(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,10}$)";
		if (!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名非法");
		}
		
		boolean b = employeeService.checkUserName(empName);
		System.out.println(b);
		if (b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}

	@RequestMapping(value = "emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

//	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//		PageHelper.startPage(pn, 5);
//		List<Employee> emps = employeeService.getAll();
//		PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps, 5);
//		model.addAttribute("pageInfo", pageInfo);
//		System.out.println(pageInfo);
//		return "list";
//	}

	@RequestMapping(value = "emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> list = result.getFieldErrors();
			for (FieldError fieldError : list) {
				System.out.println("错误字段："+fieldError.getField());
				System.out.println("错误字段信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
				return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	
}
