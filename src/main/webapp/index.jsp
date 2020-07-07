<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
	<%-- 引入样式  --%>
	<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_input" ></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<div class="radio">
								  <label>
								    <input type="radio" name="gender" id="gender1_update_input" value="M">男
								  </label>
								</div>
								<div class="radio">
								  <label>
								    <input type="radio" name="gender" id="gender2_update_input" value="F">女
								  </label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select">
								<%-- 部门ID --%>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="emp_update_btn" class="btn btn-primary">更新</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<div class="radio">
								  <label>
								    <input type="radio" name="gender" id="gender1_add_input" value="M" checked>男
								  </label>
								</div>
								<div class="radio">
								  <label>
								    <input type="radio" name="gender" id="gender2_add_input" value="F">女
								  </label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">
								<%-- 部门ID --%>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="emp_add_btn" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<%-- 标题 --%>
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<%-- 按钮 --%>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>		
		</div>
		<%-- 显示表格数据 --%>
		<div class="row">
			<table class="table table-hover" id="emps">
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="check_all"/>
						</th>
						<th>empId</th>
						<th>empName</th>
						<th>gengder</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<%-- 显示分页信息 --%>
		<div class="row">
			<%-- 左 --%>
			<div class="col-md-4" id="pageLeft">
				
			</div>
			<%-- 右 --%>
			<div class="col-md-4 col-md-offset-3" id="pageRight">

			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var totalRecord,currentNum;
		
		//加载完成以后，直接发送ajax请求要到分页数据
		$(function(){
			to_page(1);
		});
		
		function to_page(pn) {
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"get",
				success:function(msg){
					create_data_table(msg);
					create_pageData_left(msg);
					create_pageData_right(msg);
				},
				error:function(msg){
					//alert();
				}
			});
		}
		
		//清空表单和样式
		function reset_form(ele) {
			$(ele)[0].reset();
			
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮
		$("#emp_add_modal_btn").click(function(){
			//清空表单和样式
			reset_form("#empAddModal form");

			//发送ajax请求，查询部门信息
			getDepts("#dept_add_select");

			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查询所有的部门信息
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(msg){
					$.each(msg.dataMap.depts,function(){
						var select = $(ele);
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						select.append(optionEle);
					});
				}
			});
		}
		
		//校验表单数据
		function vakidate_data_form() {
			//1、拿到数据
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,10}$)/;
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input","error","用户名不合法");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
				return true;
			}
		}
		
		//显示校验结果信息
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-error has-success");
			$(ele).next("span").text(msg);
			
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//重复用户名校验
		$("#empName_add_input").change(function() {
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUserName",
				type:"POST",
				data:"empName="+empName,
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_add_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.dataMap.va_msg);
						$("#emp_add_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//保存
		$("#emp_add_btn").click(function(){
			//alert($("#empAddModal form").serialize());
			//下对要提交给服务器的数据进行校验
			if(!vakidate_data_form()){
				return false;
			}
			
			//判断ajax校验用户名是否成功
			if ($(this).attr("ajax-va") == "error") {
				return false;
			}
			
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg)
					if(result.code == 100){
					//员工保存成功
					//1、关闭模态框
					$('#empAddModal').modal('hide')
					//2、来到最后一页，显示保存的数据
					//发送ajax请求显示最后一页数据
					to_page(totalRecord);
					}else{
						//显示失败信息
						if(undefined != result.dataMap.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.dataMap.errorFields.empName);
						}
					}
				}
			});
		});
		
		

	//在按钮创建之前绑定编辑按钮的click,绑定不上
	//1）可以在创建的时候就绑定，2）绑定点击。live（）
	//jQuery新版没有live，使用on进行代替
	$(document).on("click",".edit_btn",function(){
		//清空表单和样式
		reset_form("#empUpdateModal form");
		//alert("edit");
		//查出员工信息，显示员工信息
		getEmp($(this).attr("edit-id"));
		//查出部门信息，并显示部门列表
		getDepts("#dept_update_select");
		
		//弹出编辑模态框，把员工ID传递进入
		$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
		$("#empUpdateModal").modal({
			backdrop:"static"
		});
		
	});
	
	//查询员工信息
	function getEmp(empId){
		$.ajax({
			url:"${APP_PATH}/emp/"+empId,
			type:"GET",
			success:function(result){
				//alert(result.dataMap.emp.empName);
				var empData = result.dataMap.emp;
				$("#empName_update_input").text(empData.empName);
				$("#empUpdateModal input[name=gender]").val([empData.gender]);
				//alert(empData.dId);
				setTimeout(function () {
					//alert("aa");
					$("#dept_update_select").val([empData.dId]);
			    }, 100);
			}
		});
	}
	
	
	$("#emp_update_btn").click(function(){
		$.ajax({
			url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
			type:"PUT",
			data:$("#empUpdateModal form").serialize(),
			success:function(result){
				if(result.msg = "处理成功"){
					//1、关闭模态框
					$('#empUpdateModal').modal('hide')
					//返回当前页号
					to_page(currentNum);
				}
			}
		});
	
	});
	
	//单个删除
	$(document).on("click",".delete_btn",function(){
		//alert($(this).parents("tr").find("td:eq(1)").text());
		var empName = $(this).parents("tr").find("td:eq(2)").text();
		var empId = $(this).attr("delete-id");
		if(confirm("确认删除【"+empName+"】吗？")){
			//确认，发送ajax请求删除即可 
			$.ajax({
				url:"${APP_PATH}/emp/"+empId,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					//返回当前页号
					to_page(currentNum);
				}
			});
		}
	});
	
	//全选/全不选
	$("#check_all").click(function() {
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
		
	$(document).on("click",".check_item",function(){
		//alert($(".check_item:checked").length);
		var flag = $(".check_item:checked").length == $(".check_item").length
			$("#check_all").prop("checked",flag);
		//$("#check_all").prop("checked");
	})
	
	//点击全部删除
	$("#emp_delete_all_btn").click(function(){
		var empNames = "";
		var del_idstr = "";
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		empNames = empNames.substring(0,empNames.length-1);
		del_idstr = del_idstr.substring(0,del_idstr.length-1);
		if(confirm("确认删除【"+empNames+"】吗？")){
			//确认，发送ajax请求批量删除即可 
			$.ajax({
				url:"${APP_PATH}/emp/"+del_idstr,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					//返回当前页号
					to_page(currentNum);
				}
			});
		}
		
	});
	</script>
	
	<%-- 填充表格数据 --%>
	<script type="text/javascript">
		function create_data_table(msg){
			//清空table表格
			$("#emps tbody").empty();
			var emps = msg.dataMap.pageInfo.list;
			$.each(emps,function(index,emp){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");
				var empIdTd = $("<td></td>").append(emp.empId);
				var empNameTd = $("<td></td>").append(emp.empName);
				var gengderTd = $("<td></td>").append(emp.gender=="M"?"男":"女");
				var deptNameTd = $("<td></td>").append(emp.dept.deptName);
				
				//<button type="button" class="btn btn-info">（一般信息）Info</button>
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil").css("aria-hidden","true").append("编辑"));
				//为编辑按钮添加自定义的属性，来表示当前员工的id
				editBtn.attr("edit-id",emp.empId);
				//<button type="button" class="btn btn-warning">（警告）Warning</button>
				var deleteBtn = $("<button></button>").addClass("btn btn-warning btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash").css("aria-hidden","true").append("删除"));
				deleteBtn.attr("delete-id",emp.empId);
				var $tr = $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(gengderTd).append(deptNameTd).append(editBtn).append(" ").append(deleteBtn).css("align","center");
				var $tbody = $("#emps tbody");
				$tbody.append($tr);
			});
		}
	</script>
	
	<%-- 分页信息 --%>
	<script type="text/javascript">
		function create_pageData_left(msg){
			$("#pageLeft").empty();
			$("<span></span>")
			.append("共 ")
			.append(msg.dataMap.pageInfo.total)
			.append(" 条记录，当前第 ")
			.append(msg.dataMap.pageInfo.pageNum)
			.append(" 页")
			.appendTo($("#pageLeft"));
			totalRecord = msg.dataMap.pageInfo.total;
			currentNum = msg.dataMap.pageInfo.pageNum;
		}
	</script>
	
	<%-- 分页条 --%>
	<script type="text/javascript">
		function create_pageData_right(msg){
			$("#pageRight").empty();
			var $ul = $("<ul></ul>").addClass("pagination pagination-sm");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
			var prePageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("《")));
			if(msg.dataMap.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(msg.dataMap.pageInfo.pageNum-1);
				});
			}
			
			var NextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").append("》")));
			var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
			if(msg.dataMap.pageInfo.hasNextPage == false){
				NextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				NextPageLi.click(function(){
					to_page(msg.dataMap.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(msg.dataMap.pageInfo.pages);
				});
			}
			
			
			$ul.append(firstPageLi).append(prePageLi);
			$.each(msg.dataMap.pageInfo.navigatepageNums,function(index,item){
				
				var numLi =  $("<li></li>").append($("<a></a>").append(item));
				if(msg.dataMap.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				$ul.append(numLi);
			});
			$ul.append(NextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append($ul);
			$("#pageRight").append(navEle);
		}
	</script>

</body>
</html>