package com.mycompany.service.impl;

import com.mycompany.dao.EmployeeMapper;
import com.mycompany.domain.Employee;
import com.mycompany.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;


    //查询所有员工
    public List<Employee> getAll(){
      return employeeMapper.selectByExampleWithDept(null);

    }
    //存储员工信息
    public void saveEmp(Employee emp) {
        employeeMapper.insertSelective(emp);
    }

    public boolean checkName(String empName) {
        System.out.println("servicecheckName");
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria=employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count=employeeMapper.countByExample(employeeExample);
        return count==0;

    }

    public Employee getEmpById(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
         employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmps(List<Integer> deleteEmpsList) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(deleteEmpsList);
        employeeMapper.deleteByExample(example);
//        employeeMapper.deleteByPrimaryKey(empId);
    }
}
