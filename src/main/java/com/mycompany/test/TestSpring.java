package com.mycompany.test;


import com.mycompany.dao.DepartmentMapper;
import com.mycompany.domain.Account;
import com.mycompany.domain.Department;
import com.mycompany.service.AccountService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;


public class TestSpring {

    @Test
    public void run1(){
        // 加载配置文件
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
            // 获取对象
            AccountService as = (AccountService) ac.getBean("accountService");

            // 调用方法
            List<Account> list = as.findAll();
            for (Account account : list) {
        System.out.println(account);


             }

}

}
