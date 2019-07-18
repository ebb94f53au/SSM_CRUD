package com.crud.test;


import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

/**
 * 测试dao层的工作
 * @author study
 * @create 2019-07-14 15:04
 * 推荐spring的项目就可以使用Spring的测试单元，可以自动注入我们需要的组件
 * 注意：Junit版本需要4.1.2版本或者以上
 * 1.导入spring Test
 * 2.@ContextConfiguration指定spring配置文件的位置
 * 3.@Autowired 导入组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD (){
//        //1.创建spirng的IOC容器
//        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //2.从容器中获取mapper
//        DepartmentMapper departmentMapper = ac.getBean(DepartmentMapper.class);
//        测试查询
//        Department department = departmentMapper.selectByPrimaryKey(1001);
//        System.out.println(department);
//        测试插入
//        employeeMapper.insertSelective(new Employee(null, "溜溜", "女", "130@qq.com", 1001));
//        employeeMapper.insertSelective(new Employee(null, "洗吧", "女", "1377@qq.com", 1004));
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 500; i++) {
            List<String> strings = Arrays.asList("赵", "钱", "孙", "李", "周", "吴", "郑", "王");
            Random random = new Random();
            String name =strings.get(random.nextInt(8))+"#0"+i;
            String gender = i%2==0?"男":"女";
            String email ="13777"+i+"@qq.com";
            int deptid=i%4+1001;

            mapper.insertSelective(new Employee(null, name, gender, email, deptid));

        }
        System.out.println("添加完毕");



    }
}
