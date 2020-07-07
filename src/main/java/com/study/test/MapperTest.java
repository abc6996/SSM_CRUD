package com.study.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.study.dao.DeptMapper;
import com.study.dao.EmployeeMapper;
import com.study.entity.Dept;
import com.study.entity.Employee;

/***
 * 测试dao层
 * 
 * @author DWJ
 * @Date 2020-05-10 16:39:14
 * @Description
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DeptMapper deptMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试dept
	 */
	@Test
	public void testTest() {
//		// 创建springioc容器
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		Dept dept = ioc.getBean(Dept.class);
		
		System.out.println(deptMapper);
		
//		deptMapper.insertSelective(new Dept(null,"开发部"));
//		deptMapper.insertSelective(new Dept(null,"测试部"));
		
		
//		employeeMapper.insertSelective(new Employee(null, "DWJ", "V", "DWJ@qq.com", 1));
		
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		for (int i = 0; i < 1000; i++) {
//			String name = UUID.randomUUID().toString().substring(0, 5)+i;
//			mapper.insertSelective(new Employee(null, name, "M", name+"@qq.com", 1));
//		}
		
		List<Employee> list = employeeMapper.selectByExampleWithDept(null);
		System.out.println(list);
		
		
		
	}
}
