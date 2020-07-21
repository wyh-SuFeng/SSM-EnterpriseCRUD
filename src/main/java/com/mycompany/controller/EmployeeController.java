package com.mycompany.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mycompany.dao.Msg;
import com.mycompany.domain.Employee;
import com.mycompany.service.impl.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
  private Msg msg;
    @RequestMapping("/emps2")
    //查询所有员工
    @ResponseBody
    public Msg getEmps2(@RequestParam(value="pn",defaultValue = "1")Integer pn, Model model){
        //引入pageHelper分页插件
        //查询之前只需调用，传入页码与没有数据条数
        PageHelper.startPage(pn, 5);
        //startPage后紧跟的就是分页查询
        List<Employee> emps= employeeService.getAll();
        //使用pageinfo包装查询后的结果,这便包装了页的详细信息,连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        msg.success().add("pageInfo",page);
        return msg;
//        model.addAttribute("pageInfo",page);
//        return "list";
    }
    @RequestMapping(value = "/saveEmp", method = RequestMethod.POST)
    @ResponseBody
    public Msg save(@Valid Employee emp, BindingResult result) {
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return msg.fail().add("errorFields", map);
        }else{
            employeeService.saveEmp(emp);
            return msg.success();
        }

    }

    @RequestMapping(value = "/checkName", method = RequestMethod.POST)
    @ResponseBody
    public Msg checkName(String empName){
        System.out.println("controcheckName");
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        //查看数据库中是否有重复姓名
        System.out.println("controcheckName2");
       boolean b= employeeService.checkName(empName);
       if(b) return msg.success();
       else return msg.fail().add("va_msg","姓名不可用");
    }

    @RequestMapping(value = "getEmp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id) {
        Employee employee=employeeService.getEmpById(id);
        return msg.success().add("emp", employee);
    }
    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee
     * [empId=1014, empName=null, gender=null, email=null, dId=null]
     *
     * 问题：
     * 请求体中有数据；
     * 但是Employee对象封装不上；
     * update tbl_emp  where emp_id = 1014;
     *
     * 原因：
     * Tomcat：
     * 		1、将请求体中的数据，封装一个map。
     * 		2、request.getParameter("empName")就会从这个map中取值。
     * 		3、SpringMVC封装POJO对象的时候。
     * 				会把POJO中每个属性的值，request.getParamter("email");
     * AJAX发送PUT请求引发的血案：
     * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     * org.apache.catalina.connector.Request--parseParameters() (3111);
     *
     * protected String parseBodyMethods = "POST";
     * if( !getConnector().isParseBodyMethod(getMethod()) ) {
     success = true;
     return;
     }
     *
     *
     * 解决方案；
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1、配置上HttpPutFormContentFilter；
     * 2、他的作用；将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "updateEmp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        System.out.println(employee);

       employeeService.updateEmp(employee);
       return msg.success();
    }
    @RequestMapping(value = "deleteEmp/{empId}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("empId") String empId) {
        String[] deleteEmps = empId.split("-");
//        System.out.println(deleteEmps[0]);
        List<Integer> deleteEmpsList = new ArrayList<>();
        for(int i=0;i<deleteEmps.length;i++){
            deleteEmpsList.add(Integer.parseInt(deleteEmps[i]));
        }
        employeeService.deleteEmps(deleteEmpsList);
        return msg.success();
    }
//
//    @RequestMapping("/emps")
//    //查询所有员工
//    public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model){
//        //引入pageHelper分页插件
//        //查询之前只需调用，传入页码与没有数据条数
//        PageHelper.startPage(pn, 5);
//        //startPage后紧跟的就是分页查询
//       List<Employee> emps= employeeService.getAll();
//       //使用pageinfo包装查询后的结果,这便包装了页的详细信息,连续显示的页数
//        PageInfo page = new PageInfo(emps,5);
//
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }
}
