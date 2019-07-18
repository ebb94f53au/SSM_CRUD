package com.crud.service;

import com.crud.bean.Employee;
import com.crud.bean.EmployeeExample;
import com.crud.dao.EmployeeMapper;
import com.sun.org.apache.bcel.internal.generic.RETURN;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author study
 * @create 2019-07-14 16:33
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 显示所有的员工
     * @return
     */
    public List<Employee> getAll(){
        //使查询排序为正序
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id");

        return employeeMapper.selectByExampleWithDept(employeeExample);
    }

    /**
     * 添加员工
     * @param employee
     */
    public void addEmp(Employee employee){
        employeeMapper.insertSelective(employee);

    }

    /**
     * 检验用户名是否可用
     *
     * @param empName
     * @return l==0代表没有使用返回true
     */
    public Boolean checkName(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        //建立表达式，判断表中存在相同的员工姓名没
        criteria.andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(employeeExample);
        return l==0;
    }

    /**
     * 修改员工
     * @param employee
     */
    public void updateEmpWithId (Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除员工
     * @param id
     */
    public void deleteEmpWithId (Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 该id员工是否存在
     * @param id
     * @return
     */
    public Boolean empExist (Integer id){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdEqualTo(id);
        long count = employeeMapper.countByExample(employeeExample);
        return count==1;
    }
}
