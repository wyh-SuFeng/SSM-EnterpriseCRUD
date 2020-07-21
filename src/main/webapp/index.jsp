<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-success" id="emp_delete_modal_btn">删除</button>
        </div>
    </div>
    <%--显示表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover " id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>#</th>
                    <th>mepName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--当前记录数--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条--%>
        <div>
            <nav aria-label="Page navigation">
                <ul class="pagination" id="page_nav">

                </ul>
            </nav>
        </div>


    </div>
</div>
<%--编辑员工信息对话框--%>
<div class="modal fade" id="myUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >编辑员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="emp_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_edit_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_update_input"
                                   placeholder="emial@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input name="gender" type="radio" id="inlineRadioUpdate1" value="M" > 男
                            </label>
                            <label class="radio-inline">
                                <input name="gender" type="radio" id="inlineRadioUpdate2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_save">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 添加员工对话框 -->
<div class="modal fade" id="myAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="emp_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input name="empName" type="text" class="form-control" id="emp_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_add_input"
                                   placeholder="emial@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input name="gender" type="radio" id="inlineRadio1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input name="gender" type="radio" id="inlineRadio2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="add_save">添加</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //总页数与当前页
    var totalPage,currentPage;
    // 加载完成时间
    $(function () {
        to_page(1);

    });
    //发型ajax请求寻求页
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps2",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                // console.log(result);
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }
    //表数据
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkItem=$("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var eidtButton = $("<button></button>")
                .addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil "))
                .append("编辑");
            eidtButton.attr("emp_id",item.empId);
            var deleteButton = $("<button></button>")
                .addClass("btn btn-success btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-minus "))
                .append("删除");
            deleteButton.attr("emp_id",item.empId);
            var binButton = $("<td></td>").append(eidtButton).append(deleteButton);

            $("<tr></tr>").append(checkItem)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(binButton)
                .appendTo("#emps_table tbody");

        });
    }
    //页数据
    function build_page_info(result) {
        $("#page_info_area").empty();
        var pageInfo = result.extend.pageInfo;
        $("#page_info_area").append("当前" + pageInfo.pageNum + "页，总共" + pageInfo.pages + " 页，总共" + pageInfo.total + " 记录");
        totalPage = pageInfo.total;
        currentPage=pageInfo.pageNum;
    }
    //导航数据
    function build_page_nav(result) {
        $("#page_nav").empty();
        var firPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append($("<span></sapn>").append("&laquo;")));
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append($("<span></sapn>").append("&raquo;")));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            $(firPageLi).addClass("disabled");
            $(prePageLi).addClass("disabled");
        } else {
            firPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        if (result.extend.pageInfo.hasNextPage == false) {
            //禁用
            $(lastPageLi).addClass("disabled");
            $(nextPageLi).addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        $("#page_nav").append(firPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
            if (result.extend.pageInfo.pageNum == item) {
                //激活，高亮
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            $("#page_nav").append(numLi);
        });
        $("#page_nav").append(nextPageLi).append(lastPageLi);
    }
    //清空表单数据和样式
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");


    }
    // 点击添加按钮添加员工绑定事件
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据
        reset_form("#myAddModal form");
        //发送ajax请求查询部门信息
        getDepts("#myAddModal select");
        //显示添加窗口
        $("#myAddModal").modal({
            backdrop: "static"
        })
    });
    //查询部门信息显示在下拉列表中
    function getDepts(ele) {
        $(ele ).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }
    //表单员工和邮箱校验
    function validate_add_form() {
        //员工姓名校验
        var empName = $("#emp_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        // console.log("validate_add_form");
        if (regName.test(empName)) {
            show_validate_msg("#emp_add_input", "success", "");
        } else {
            show_validate_msg("#emp_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }

        //邮箱校验
        var empEmail = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (regEmail.test(empEmail)) {
            show_validate_msg("#email_add_input", "success", "");
        } else {
            show_validate_msg("#email_add_input", "error", "邮箱格式错误");
            return false;
        }
        return true;
    }
    //显示校验提示信息
    function show_validate_msg(id, status, msg) {

        //校验前清空状态
        $(id).parent().removeClass("has-success has-error");
        $(id).next("span").text("");
        //校验
        if ("success" == status) {

            $(id).parent().addClass("has-success");
        } else {

            $(id).parent().addClass("has-error");
            $(id).next("span").text(msg);
        }
    }
    //重复添加检测
    $("#emp_add_input").change(function(){
        var empName=this.value;
        $.ajax( {
            url:"${APP_PATH}/checkName",
            type:"POST",
            data:"empName="+empName,
            success:function(result) {
                if(result.code==100){
                    show_validate_msg("#emp_add_input","success","");
                    $("#emp_add_input").attr("ajax_va","success");
                }else{
                    show_validate_msg("#emp_add_input","error",result.extend.va_msg);
                    $("#emp_add_input").attr("ajax_va","error");
                }
            }

        })
    });
    //增加员工
    $("#add_save").click(function () {

        // console.log($("#myAddModal form").serialize());
        //校验表单数据知否符合规则
          if (!validate_add_form()) return false;
        //检查姓名是否重复
        if ($("#emp_add_input").attr("ajax_va")=="error") return false;
        $.ajax({
            url: "${APP_PATH}/saveEmp",
            type: "POST",
            data: $("#myAddModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                if (result.code == 100) {
                    //员工保存成功；
                    //1、关闭模态框
                    $("#myAddModal").modal('hide');

                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalPage);
                } else {
                    //显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                }
            }
        });
    });
    //编辑员工按钮点击事件
    //1、我们是按钮创建之前就绑定了click，所以绑定不上。
    //1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    $(document).on("click",".edit_btn",function () {
        // alert("endtie");
        getDepts("#myUpdateModal select");
        //发送ajax请求员工信息
        getEmp($(this).attr("emp_id"));
        //把id帮到表单保存按钮上
        $("#update_save").attr("emp_id",$(this).attr("emp_id"));

        //显示添加窗口
        $("#myUpdateModal").modal({
            backdrop: "static"
        })
    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/getEmp/"+id,
            type:"GET",
            success: function (result) {
                var empData = result.extend.emp;
                $("#emp_edit_static").text(empData.empName);
                $("#email_add_input").val(empData.email);
                $("#myUpdateModal input[name=gender]").val([empData.gender]);
                $("#myUpdateModal select").val([empData.dId]);
            }

        })


    }

    $("#update_save").click(function () {

        //邮箱校验
        var empEmail = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (regEmail.test(empEmail)) {
            show_validate_msg("#email_update_input", "success", "");
        } else {
            show_validate_msg("#email_update_input", "error", "邮箱格式错误");
            return false;
        }
        var emp_id = $(this).attr("emp_id");
        $.ajax({
            url:"${APP_PATH}/updateEmp/"+emp_id,
            type:"PUT",
            data:$("#myUpdateModal form").serialize(),
            success: function (result) {

                //1、关闭模态框
                $("#myUpdateModal").modal('hide');

                //2、更新当前页，显示刚才保存的数据
                to_page(currentPage);
            }
        })

    });

    //单一删除
    $(document).on("click",".delete_btn",function () {
        //获取员工姓名和id
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("emp_id").toString();

        //弹出确认框
        if(confirm("确认删除【"+empName+"】吗")){
            //发送ajax请求删除员工
            $.ajax({
                url:"${APP_PATH}/deleteEmp/"+empId,
                type:"DELETE",
                success: function (result) {
                    //回到当前页面
                    to_page(currentPage);
                }
            })
        }
    });
    //完成全选/全不选功能
    $("#check_all").click( function () {
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        // $(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"))
    })
    $(document).on("click",".check_item",function () {
        //判断当前选择中的元素是否5个
       var bool= $(".check_item:checked").length==$(".check_item").length
         $("#check_all").prop("checked", bool);
    });


    //批量删除
    $("#emp_delete_modal_btn").click(function () {
        var empsName="";
        var empsId="";
        //显示要删除的员工姓名
        $.each($(".check_item:checked"),function () {
            empsName+=$(this).parents("tr").find("td:eq(2)").text()+",";
            empsId+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        if(confirm("确认删除【"+empsName+"】吗")){
            //发送ajax请求批量删除
                $.ajax({
                    url:"${APP_PATH}/deleteEmp/"+empsId,
                    type:"DELETE",
                    success: function (result) {
                        //回到当前页面
                        to_page(currentPage);
                    }
                });
        }
    });

</script>

</body>
</html>
