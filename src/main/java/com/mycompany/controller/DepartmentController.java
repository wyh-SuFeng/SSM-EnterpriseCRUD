package com.mycompany.controller;

import com.mycompany.dao.Msg;
import com.mycompany.domain.Department;
import com.mycompany.service.impl.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    @Autowired
    Msg msg;
    //查询出所有部门
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
       List<Department> list= departmentService.getDepts();
        return msg.success().add("depts", list);
    }


}
