package com.mycompany.service.impl;


import com.mycompany.dao.AccountDao;
import com.mycompany.domain.Account;
import com.mycompany.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
   private AccountDao accountDao;

    public List<Account> findAll() {
        System.out.println("业务层：查询所有账户...");
       List<Account> list= accountDao.findAll();
        return list;
    }

    public void saveAccount(Account account) {
        System.out.println("业务层：保存帐户...");
        accountDao.saveAccount(account);

    }
}
