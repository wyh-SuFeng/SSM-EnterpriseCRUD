package com.mycompany.dao;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
@Component
public class Msg {
    private int code;
    private String msg;
    private Map<String ,Object> extend =new HashMap<>();
    public Msg success(){
        this.setCode(100);
        this.setMsg("请求成功");
        return this;
    }
    public Msg fail(){
        this.setCode(200);
        this.setMsg("请求失败");
        return this;
    }
    public Msg add(String key,Object obj){
        this.getExtend().put(key, obj);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
}

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
