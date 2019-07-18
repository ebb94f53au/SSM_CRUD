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
<%--    <script type="text/javascript" src="static/js/jquery-3.4.1.min.js"></script>--%>
<%--    <script  src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>--%>
<%--    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>--%>
</head>
<body>
<%--<c:forEach items="${pageInfo.list}" var="emp">--%>
<%--    ${pageInfo.pageNum}&nbsp;--%>
<%--    ${emp.empId}--%>
<%--    <br>--%>
<%--    <button class="btn btn-success">11</button>--%>
<%--</c:forEach>--%>
<%--搭建页面--%>
    <div class="container">
<%--        标题--%>
        <div class="row">
            <div class="col-md-12"><h1>SSM-CRUD</h1></div>
        </div>
<%--    按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-success">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
<%--    信息--%>
        <div class="row">
            <div class="col-md-12" style="margin-top: 20px;">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th><input type="checkbox"/></th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮箱</th>
                        <th>员工部门</th>
                        <th>操作</th>
                    </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td><input type="checkbox"/></td>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.deptName}</td>
                        <td>
                            <button class="btn btn-info btn-sm">
                            <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
                                修改</button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除</button>
                        </td>
                    </tr>
                </c:forEach>
                </table>
            </div>
        </div>
<%--    分页信息--%>
        <div class="row">
            <div class="col-md-6">
                    当前第<span class="badge">${pageInfo.pageNum}</span>页，
                总共<span class="badge">${pageInfo.pages}</span>页，总共<span class="badge">${pageInfo.total}</span>条记录
            </div>
            <div class="col-md-6 col-md-offset-8">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li
                            <c:if test="${pageInfo.pageNum==1}">
                                class="disabled"
                            </c:if>
                        ><a href="${pageContext.request.contextPath}/emps?pn=1">首页</a></li>
                        <li
                            <c:if test="${pageInfo.pageNum==1}">
                                class="disabled"
                            </c:if>
                        >
                            <a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.prePage}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                            <c:choose>
                                <c:when test="${num==pageInfo.pageNum}">
                                    <li class="active"><a href="${pageContext.request.contextPath}/emps?pn=${num}">${num}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li ><a href="${pageContext.request.contextPath}/emps?pn=${num}">${num}</a></li>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                        <li
                                <c:if test="${pageInfo.pageNum==pageInfo.pages}">
                                    class="disabled"
                                </c:if>
                        >
                            <a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.nextPage}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li
                                <c:if test="${pageInfo.pageNum==pageInfo.pages}">
                                    class="disabled"
                                </c:if>
                        ><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>

</body>
</html>
