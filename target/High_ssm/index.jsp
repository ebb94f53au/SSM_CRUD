<%--
  Created by IntelliJ IDEA.
  User: Sy
  Date: 2019/7/14
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>

<%--    导入jq 以及bootstrap--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.min.js"></script>
    <script  src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
</head>
<body>

        <!-- 员工添加模态框 -->
        <div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="addEmpModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="addEmpModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="empNameInput" class="col-sm-2 control-label">员工姓名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="empName" id="empNameInput" placeholder="员工姓名">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="emailInput" class="col-sm-2 control-label">员工邮箱</label>
                                <div class="col-sm-10">
                                    <input type="email" class="form-control" name="email" id="emailInput" placeholder="员工邮箱">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">员工性别</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" value="男" checked> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" value="女"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="departmentInput" class="col-sm-2 control-label">员工部门</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="deptId" id="departmentInput">

                                    </select>
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="saveEmp">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- 员工修改模态框--%>
        <div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="addEmpModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="updateEmpModalLabel">员工修改</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="empNameInput" class="col-sm-2 control-label">员工姓名</label>
                                <div class="col-sm-10">
                                    <input type="hidden" name="_method" value="PUT">
                                    <input type="hidden" class="form-control" name="empId" id="empId" >
                                    <h5></h5>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="emailInput" class="col-sm-2 control-label">员工邮箱</label>
                                <div class="col-sm-10">
                                    <input type="email" class="form-control" name="email" id="update_emailInput" placeholder="员工邮箱">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">员工性别</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" value="男" checked> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" value="女"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="departmentInput" class="col-sm-2 control-label">员工部门</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="deptId" id="update_departmentInput">

                                    </select>
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="updateEmp">保存</button>
                    </div>
                </div>
            </div>
        </div>

<%--    搭建页面--%>
        <div class="container">
<%--    标题--%>
        <div class="row">
            <div class="col-md-12"><h1>SSM-CRUD</h1></div>

        </div>
<%--    按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-success" id="add_emp_button">新增</button>
                <button class="btn btn-danger" id="delete_emp_button">删除</button>
            </div>
        </div>
<%--    信息--%>
        <div class="row">
            <div class="col-md-12" style="margin-top: 20px;">
                <table class="table table-striped table-bordered table-hover" id="emps_table">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="chose_all_emp"/></th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮箱</th>
                        <th>员工部门</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody></tbody>

                </table>
            </div>
        </div>
<%--    分页信息--%>
        <div class="row">
            <div class="col-md-6" id="emps_detail">

            </div>
            <div class="col-md-6 col-md-offset-8">
                <nav aria-label="Page navigation">
                    <ul class="pagination" id="emps_pages">

                    </ul>
                </nav>
            </div>
        </div>

    </div>
    <script type="text/javascript">
        var totalPageNum;
        //主函数
        $(function () {
            show_all(1);


        });
        //显示所有员工
        function show_emps(pageInfo) {
            $(pageInfo.list).each(function (index,emp) {
                var checkbox=$("<td></td>").append("<input type='checkbox' empId='"+emp.empId+"'/>");
                var id=$("<td></td>").append(emp.empId);
                var name=$("<td></td>").append(emp.empName);
                var gender=$("<td></td>").append(emp.gender);
                var email=$("<td></td>").append(emp.email);
                var department=$("<td></td>").append(emp.department.deptName);

                //修改按钮与修改员工信息模态框事件
                var upb=$("<button></button>").addClass("btn btn-info btn-sm").append(
                    $("<span></span>").addClass("glyphicon glyphicon-file")
                ).append("修改").click(function () {
                    $("#updateEmpModal").modal({
                        "backdrop":"static"
                    });

                    //清除表单中所有 has-success 与has-error class
                    $("#updateEmpModal").find("*").removeClass("has-success has-error");
                    //清除表单中输入框下help-block数据
                    $("#updateEmpModal").find("span").text("");
                    //给修改模态框赋值
                    $("#updateEmpModal form #empId").val(emp.empId);
                    $("#updateEmpModal form h5").text(emp.empName);
                    $("#updateEmpModal form #update_emailInput").val(emp.email);
                    $("#updateEmpModal form input[name='gender'][value="+emp.gender+"]").attr("checked",true);
                    $("#updateEmpModal form #update_departmentInput option[value="+emp.department.deptId+"]").attr("selected",true);

                });

                var deb=$("<button></button>").addClass("btn btn-danger btn-sm").append(
                    $("<span></span>").addClass("glyphicon glyphicon-trash")
                ).append("删除").click(function () {
                    var data={"empId":emp.empId,"_method":"DELETE"};
                    $.post("${pageContext.request.contextPath}/emp",data,function (result) {
                        if(result.code==100){
                            //显示信息
                            alert(result.msg);
                            //刷新网页
                            //判断是否为单页最后一个
                            if($("#emps_detail .badge:last").text()%pageInfo.pageSize==1){
                                show_all($("#emps_detail .badge:first").text()-1);
                            }else{
                                show_all($("#emps_detail .badge:first").text());
                            }
                        }else if(result.code==200){
                            alert(result.extend.msg);
                        }
                    });
                });
                var bu=$("<td></td>").append(upb).append("&nbsp;").append(deb);
                $("<tr></tr>").append(checkbox).append(id).append(name).append(gender).append(email).append(department).append(bu).appendTo("#emps_table tbody");
            })
        }
        //显示细节信息
        function show_detail(pageInfo){
            /**
             * 当前第<span class="badge">${pageInfo.pageNum}</span>页，
             总共<span class="badge">${pageInfo.pages}</span>页，总共<span class="badge">${pageInfo.total}</span>条记录
             */
            $("#emps_detail").append("当前第").append($("<span></span>").addClass("badge").append(pageInfo.pageNum)).append("页，总共")
                .append(
                    $("<span></span>").addClass("badge").append(pageInfo.pages)
                ).append("页，总共")
                .append(
                    $("<span></span>").addClass("badge").append(pageInfo.total)
                ).append("条记录");
            totalPageNum=pageInfo.total%pageInfo.pageSize==0?pageInfo.pages+1:pageInfo.pages;
        }
        //显示分页信息
        function show_Pagination(pageInfo) {
            //首页
            var head=$("<li></li>").append(
                $("<a></a>").append("首页").attr("href","#")
            );
            if(pageInfo.pageNum==1){
                head=head.addClass("disabled");
            }else{
                head=head.click(function () {
                    show_all(1);
                });
            }
            //上一页
            var Previous=null;
            if(pageInfo.hasPreviousPage==true){
                Previous=$("<li></li>").append($("<a></a>").attr("href","#").append(
                    $("<span></span>").append("&laquo;"))
                ).click(function () {
                    show_all(pageInfo.prePage);
                });
            }

            //遍历页数
            var page=$("#emps_pages").append(head).append(Previous);
            $(pageInfo.navigatepageNums).each(function (index,num) {
                var p= $("<li></li>").append(
                    $("<a></a>").append(num).attr("href","#")
                ).click(function () {
                    show_all(num);
                });
                if(num==pageInfo.pageNum){
                    p=p.addClass("active");
                }
                page=page.append(p);

            });

            //下一页
            var Next=null;
            if(pageInfo.hasNextPage==true){
                Next=$("<li></li>").append($("<a></a>").attr("href","#").append(
                    $("<span></span>").append("&raquo;"))
                ).click(function () {
                    show_all(pageInfo.nextPage);
                });
            }

            //尾页
            var foot=$("<li></li>").append(
                $("<a></a>").append("末页").attr("href","#")
            );
            if(pageInfo.pageNum==pageInfo.pages){
                foot=foot.addClass("disabled");
            }else{
                foot=foot.click(function () {
                    show_all(pageInfo.pages);
                });
            }

            page.append(Next).append(foot);

        }
        //查询，并展示所有的department信息
        function show_allDepartment(){
            $.get("${pageContext.request.contextPath}/depts",{},function (result) {
                $(result.extend.depts).each(function (index,dept) {
                    //这里注意 如果定义一个参数 2次传入，会出现先append的无法传入
                    $("#update_departmentInput").append(
                        $("<option></option>").append(dept.deptName).attr("value",dept.deptId)
                    );
                    $("#departmentInput").append(
                        $("<option></option>").append(dept.deptName).attr("value",dept.deptId)
                    );
                });
            });
        }
        //显示所有信息
        function show_all(pn) {
            // console.log(result);
            clear_all();
            $.get("${pageContext.request.contextPath}/emps",{"pn":pn},function (result) {
                show_emps(result.extend.pageInfo);
                show_detail(result.extend.pageInfo);
                show_Pagination(result.extend.pageInfo);
            });
            show_allDepartment();
        }
        //清除所有信息
        function clear_all() {
            $("#emps_table tbody").empty();
            $("#emps_table thead input[type='checkbox']").prop("checked",false);
            $("#emps_detail").empty();
            $("#emps_pages").empty();
            $("#departmentInput").empty();
        }
        //清除模态框数据
        function clear_modal(selector){
            //清除表单格式
            $(selector)[0].reset();
            //清除表单中所有 has-success 与has-error class
            $(selector).find("*").removeClass("has-success has-error");
            //清除表单中输入框下help-block数据
            $(selector).find("span").text("");
        }
        //绑定员工添加模块框
        $('#add_emp_button').click(function () {
            //每次打开清除模态框数据
            clear_modal("#addEmpModal form");
            $("#addEmpModal").modal({
                "backdrop":"static"
            });
        });
        //校验数据反馈
        function vail_back(selector,status,context) {

            $(selector).parent().removeClass("has-error has-success");
            $(selector).next("span").text("");
            if(status=="success"){
                $(selector).parent().addClass("has-success");
            }else if(status=="error"){
                $(selector).parent().addClass("has-error").append();
            }
            $(selector).next("span").text(context);
        }
        //校验数据
        function validata_add_form(){
            var flag=true;
            //验证姓名
            var empName=$("#empNameInput").val();
            var reg_empName=/(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
            if(!reg_empName.test(empName)){

                vail_back("#empNameInput","error","用户名允许3-16位的英文数字_ -等字符组合或者2-5位的中文");
                flag=false;
            }else{
                vail_back("#empNameInput","success","");
            }
            //验证邮箱
            var email=$("#emailInput").val();
            var reg_email=/(^[a-z0-9_\.-]+)@([\da-z\.]+)\.([a-z\.]{2,6})$/;
            if(!reg_email.test(email)){
                vail_back("#emailInput","error","邮箱不符合规范");
                flag=false;
            } else{
                vail_back("#emailInput","success","");
            }
            if(flag){
                return true;
            }else{
                return false;
            }

        }
        //添加员工按钮获取资料并上传服务器
        $("#saveEmp").click(function () {
            //验证数据
            if (!validata_add_form()) {
                return false;
            }
            //检验姓名是否重复以及符合格式标准，取出标示
            if(!($("#empNameInput").attr("check_name")=="success")){
                return false;
            }
            //获取数据
            var emp=$("#addEmpModal form").serialize();
            //提交的数据可以是xx=xx&xx=xx 或json 格式的类型
            $.post("${pageContext.request.contextPath}/emp",emp,function (result) {
                if(result.code==100){
                    //显示信息
                    alert(result.msg);
                    //关闭模态框
                    $("#addEmpModal").modal("hide");
                    //来到最后一页显示数据。前面已赋值
                    show_all(totalPageNum);
                }else if(result.code==200){
                    if(undefined!=result.extend.errorField.email){
                        vail_back("#emailInput","error",result.extend.errorField.email)
                    }
                    if(undefined!=result.extend.errorField.empName){
                        vail_back("#empNameInput","error",result.extend.errorField.empName)
                    }
                }

            });

        });
        //跟员工框添加更改内容时查询是否已存在同样的用户名
        $("#empNameInput").change(function () {
            $.get("${pageContext.request.contextPath}/checkEmpName",{"empName":$(this).val()},function (result) {
                    if(result.code==100){
                        //
                        vail_back("#empNameInput","success","用户名可以使用");
                        //做一个标示，使验证数据格式防止提交
                        $("#empNameInput").attr("check_name","success");
                    }else if(result.code==200){
                        vail_back("#empNameInput","error",result.extend.check_msg);
                        $("#empNameInput").attr("check_name","error");
                    }
            })
        });
        //跟邮箱框添加更改操作
        $("#emailInput").change(function () {
            validata_add_form();
        });
        //更新验证操作
        function validata_update_form(){
            var email=$(update_emailInput).val();
            var reg_email=/(^[a-z0-9_\.-]+)@([\da-z\.]+)\.([a-z\.]{2,6})$/;
            if(!reg_email.test(email)){
                vail_back("#update_emailInput","error","邮箱不符合规范");
                return false;
            } else{
                vail_back("#update_emailInput","success","");
                return true;
            }
        }
        //跟邮箱框update更改操作
        $("#update_emailInput").change(function () {
            validata_update_form();
        });
        //修改按钮事件绑定
        $("#updateEmp").click(function () {
            if(!validata_update_form()){
                return false;
            }
            var data=$("#updateEmpModal form").serialize();
            $.post("${pageContext.request.contextPath}/emp",data,function (result) {
                if(result.code==100){
                    //提示修改成功
                    alert(result.msg);
                    //关闭窗口
                    $("#updateEmpModal").modal("hide");
                    //跳转到修改那行的页数
                    show_all($("#emps_detail .badge:first").text());
                }else if(result.code==200){
                    alert(result.extend.msg);
                    if(undefined!=result.extend.errorField.email){
                        vail_back("#update_emailInput","error",result.extend.errorField.email)
                    }
                    if(undefined!=result.extend.errorField.empName){
                        vail_back("#update_empNameInput","error",result.extend.errorField.empName)
                    }
                }
            })
        });
        //（不）选择所有员工
        $("#chose_all_emp").click(function () {
            if($(this).prop("checked")==true){
                $("#emps_table tbody").find("input[type='checkbox']").prop("checked",true);
            }else if($(this).prop("checked")==false){
                $("#emps_table tbody").find("input[type='checkbox']").prop("checked",false);
            }
        });
        //批量删除按钮
        $("#delete_emp_button").click(function () {
            var total=$("#emps_table tbody").find("input[type='checkbox']").length;
            var count=$("#emps_table tbody").find("input[type='checkbox']:checked").length;

            $("#emps_table tbody").find("input[type='checkbox']:checked").each(function (i,e) {
                var data={"_method":"DELETE","empId":$(e).attr("empid")};
                //这里将ajax转换为同步确保执行完后刷新网页
                $.ajaxSettings.async = false;
                $.post("${pageContext.request.contextPath}/emp",data,function (result) {
                    if(result.code==200){
                        alert(result.extend.msg+" : id = "+$(e).attr("empid"));
                    }
                });

            });
            console.log("当前页数 "+$("#emps_detail span:first").text()+"  总页数 "+$("#emps_detail span:eq(1)").text());
            if($("#emps_detail span:first").text()==1){
                //如果是删除开头
                console.log("开头");
                if(count==total){
                    console.log("删除所有");
                    //全部删完
                    //显示下一页
                    show_all($("#emps_detail span:first").text()+1)
                }else{
                    console.log("没有全部删完");
                    //没有全部删完
                    //显示这一页
                    show_all($("#emps_detail span:first").text())
                }


            }else if($("#emps_detail span:eq(1)").text()==$("#emps_detail span:first").text()){
                console.log("尾页");
                //如果是删除结尾
                if(count==total){
                    console.log("删除所有");
                    //全部删完
                    //显示上一页
                    show_all($("#emps_detail span:first").text()-1)
                }else{
                    console.log("没有全部删完");
                    //没有全部删完
                    //显示这一页
                    show_all($("#emps_detail span:first").text())
                }

            }else{
                console.log("中间");
                //如果是中间
                //全部删完
                //没有全部删完
                //显示这一页
                show_all($("#emps_detail span:first").text())
            }

        });


</script>
</body>
</html>
