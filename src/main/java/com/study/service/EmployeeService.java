package com.study.service;

import java.util.List;

import com.study.entity.Employee;

public interface EmployeeService {

	List<Employee> getAll();
	
	void saveEmp(Employee employee);

	boolean checkUserName(String empName);

	Employee getEmp(Integer empId);

	void updateEmp(Employee employee);
	
	void deleteEmpById(Integer id);

	void deleteBatch(List<Integer> ids);

}
