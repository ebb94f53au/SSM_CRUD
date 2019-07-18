package com.crud.service;

import com.crud.bean.Department;
import com.crud.bean.DepartmentExample;
import com.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author study
 * @create 2019-07-16 16:18
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    /**
     *
     * 查询所有部门信息
     * @return
     */
    public List<Department> getAll(){
        DepartmentExample departmentExample = new DepartmentExample();
        departmentExample.setOrderByClause("dept_id");
        return departmentMapper.selectByExample(departmentExample);
    }

}
