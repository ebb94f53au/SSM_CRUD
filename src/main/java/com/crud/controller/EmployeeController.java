package com.crud.controller;

import com.crud.bean.Employee;
import com.crud.bean.Msg;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.bcel.internal.generic.RETURN;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;

/**
 * @author study
 * @create 2019-07-14 16:30
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    /**
     * 查询所有员工信息
     * 需要导入jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //使用pagehelper 输入查询的页码以及查询多少条数据
        PageHelper.startPage(pn,5);
        //紧接着查询语句就可以自动分页
        List<Employee> all = employeeService.getAll();
//        pageinfo中有分页的各种属性，也有分页的数据，将数据传入进去，以及分页显示的页码
        PageInfo pageInfo = new PageInfo(all,5);
        return Msg.success().add("pageInfo",pageInfo);

    }

    /**
     * 添加员工POST请求
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST )
    public Msg addEmp(@Valid  Employee employee, BindingResult result){
        //判断是否格式正确
        if(result.hasErrors()){
            HashMap<String, Object> map = new HashMap<>();
            //取出所有的错误信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                //将错误发给前端
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorField",map);
        }else{
            employeeService.addEmp(employee);
            return Msg.success();
        }

    }

    /**
     * 检查名字格式
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName") String empName){
        String reg="(^[a-z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        boolean matches = empName.matches(reg);
        //客户端先检查名字格式是否正确
        if(!matches){
            return Msg.fail().add("check_msg","用户名允许3-16位的英文数字_ -等字符组合或者2-5位的中文.");
        }
        //再检测用户名是否重复
        Boolean b=employeeService.checkName(empName);
        return b?Msg.success():Msg.fail().add("check_msg","用户名已存在");
    }

    /**
     * 基于id 更新员工信息
     * @param employee
     * @param result
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.PUT)
    public Msg updateEmpWithId(@Valid Employee employee,BindingResult result){
        if(employeeService.empExist(employee.getEmpId())){
        //判断是否格式正确
        if(result.hasErrors()){
            HashMap<String, Object> map = new HashMap<>();
            //取出所有的错误信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                //将错误发给前端
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorField",map);
        }else{
            employeeService.updateEmpWithId(employee);
            return Msg.success();
        }
        }else{
            return Msg.fail().add("msg","员工不存在");
        }

    }
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.DELETE)
    public Msg deleteEmpWithId(@RequestParam("empId") Integer id){
        if(employeeService.empExist(id)){
            employeeService.deleteEmpWithId(id);
            return Msg.success();
        }else{
            return Msg.fail().add("msg","员工不存在");
        }

    }
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
//        //使用pagehelper 输入查询的页码以及查询多少条数据
//        PageHelper.startPage(pn,5);
//        //紧接着查询语句就可以自动分页
//        List<Employee> all = employeeService.getAll();
////        pageinfo中有分页的各种属性，也有分页的数据，将数据传入进去，以及分页显示的页码
//        PageInfo pageInfo = new PageInfo(all,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "list";
//
//    }
}
