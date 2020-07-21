<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
http://localhost:3306/crud
-->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
    <%--<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

    <%--搭建显示页面--%>
    <div class="container">
        <%--显示标题--%>
        <div class="row">
            <div class="col-md-12">
                <h2>企业管理系统</h2>
            </div>
        </div>
            <%--显示按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-9">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-success">删除</button>
            </div>
        </div>
            <%--显示表格--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover ">
                    <tr>
                        <th>#</th>
                        <th>mepName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender=="M"?"男":"女"}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-sm" aria-label="Left Align">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>增加
                                </button>
                                <button type="button" class="btn btn-success btn-sm" aria-label="Left Align">
                                    <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
            <%--显示分页信息--%>
        <div class="row">
            <%--当前记录数--%>
            <div class="col-md-6">
                当前${pageInfo.pageNum}页，总共${pageInfo.pages}页，总共${pageInfo.total}记录
            </div>
                <%--分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <c:if test="${page_num==pageInfo.pageNum}">
                                <li class="active">
                                    <a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a>
                                </li>
                            </c:if>
                            <c:if test="${page_num!=pageInfo.pageNum}">
                                <li>
                                    <%--${APP_PATH}代表当前项目下的路径--%>
                                    <a href="${APP_PATH}emps?pn=${page_num}">${page_num}</a>
                                </li>
                            </c:if>
                      </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
