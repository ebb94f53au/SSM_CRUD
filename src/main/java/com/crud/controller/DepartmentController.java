package com.crud.controller;

import com.crud.bean.Department;
import com.crud.bean.Msg;
import com.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author study
 * @create 2019-07-16 16:21
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    /**
     * 查询所有的部门信息
     * @return 返回所有部门的名单
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getAllDept(){
        List<Department> depts = departmentService.getAll();
        return Msg.success().add("depts",depts);
    }
}
