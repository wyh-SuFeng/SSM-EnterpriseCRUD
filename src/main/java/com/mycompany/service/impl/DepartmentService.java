package com.mycompany.service.impl;

import com.mycompany.dao.DepartmentMapper;
import com.mycompany.domain.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.ws.WebServiceClient;
import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
       return departmentMapper.selectByExample(null);
    }
}
