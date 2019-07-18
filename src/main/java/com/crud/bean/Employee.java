package com.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;
    @Pattern(regexp = "(^[a-z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)",message = "用户名允许3-16位的英文数字_ -等字符组合或者2-5位的中文")
    private String empName;

    private String gender;
    @Pattern(regexp = "(^[a-z0-9_\\.-]+)@([\\da-z\\.]+)\\.([a-z\\.]{2,6})$",message = "邮箱不符合规范")
    private String email;

    private Integer deptId;

    //希望查询员工的时候也查询员工的部门信息
    private Department department;

    public Employee(Integer empId, String empName, String gender, String email, Integer deptId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.deptId = deptId;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", deptId=" + deptId +
                '}';
    }

    public Employee() {
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }
}