<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="zh">

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>翻转式用户登录注册界面设计</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/front/css/styles.css">
		<!--引入css样式文件-->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/front/dist/css/bootstrap.css" />
		<!--引入jquery-->
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<!--bootstrap-->
		<script src="${pageContext.request.contextPath}/front/dist/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
		<script>
		
/* 		手机号的正则表达式
		if(!(/^1[34578]\d{9}$/.test(phone))){ 
	        alert("手机号码有误，请重填");  
	        return false;
	        
	        [@#\$%\^&\*]
	    }  */
			$(function(){
				
				var status = getQueryString("status"); //获取请求参数里面的songId
				//获取请求参数里面的东西
				function getQueryString(str) {
					var result = window.location.search.match(new RegExp("[\?\&]" + str
							+ "=([^\&]+)", "i"));
					if (result == null || result.length < 1) {
						return "";
					}
					return result[1];
				}
				//注册成功
				if(status == 1){
					alert("注册成功");
					window.location.href='loginAndRegister.jsp';
				}else if(status == 2){
					alert("该手机号已经被注册");
					window.location.href='loginAndRegister.jsp';
				}else if(status == 3){
					alert("账号密码错误");
					window.location.href='loginAndRegister.jsp';
				}else if(status == 4){
					alert("该账号未注册");
					$("#myModal").modal('show');
					window.location.href='loginAndRegister.jsp';
				}else if(status == 5){
					alert("验证码错误");
					$("#myModal").modal('show');
					window.location.href='loginAndRegister.jsp';
				}
				
			
				
				
				//手机号判断
				$("#mobile").on("blur",function(){
					
					var mobileNumber = $(this).val();
					var mobileReg = /^1[34578]{1}[0-9]{9}/;
					
					//手机号验证是否注册过
					if(mobileNumber == ""){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("手机号不能为空");
						$("#regbtn").attr("disabled","disabled");
					}else if(!mobileReg.test(mobileNumber)){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("手机号不正确");
						$("#regbtn").attr("disabled","disabled");
					}else{
						$(this).next().remove();
						$(this).css("border","2px solid green");
						$(this).next().css("color","green");
						$("#regbtn").attr("disabled",false);
					}
				});
				
				
				
				
				//用户名的判断
				$("#register_user").on("blur",function(){
					var username = $(this).val();
					var reg = /[@#\$%\^&\*]/;
					if(username == ""){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("昵称不能为空");
						$("#regbtn").attr("disabled","disabled");
					}else if(reg.test(username)){//如果有非法字符
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("请输入合法字符");
						$("#regbtn").attr("disabled","disabled");
					}else{
						$(this).next().remove();
						$(this).css("border","2px solid green");
						$(this).next().css("color","green");
						$("#regbtn").attr("disabled",false);
					}
					
				});
				
				//密码的验证
				$("#register_pass").on("blur",function(){
					var password = $(this).val();
					if(password == ""){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("密码不能为空");
						$("#regbtn").attr("disabled","disabled");
					}else if(password.length<7){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("密码不能小于6位");
						$("#regbtn").attr("disabled","disabled");
					}else{
						$(this).next().remove();
						$(this).css("border","2px solid green");
						$(this).next().css("color","green");
						$("#regbtn").attr("disabled",false);
					}	
				});
				
				
				//确认密码的验证
				$("#register_pass1").on("blur",function(){
					var password = $("#register_pass").val();
					var password1 = $(this).val();
					
					if(password1 == ""){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("密码不能为空");
						$("#regbtn").attr("disabled","disabled");
					}else if(password != password1){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("两次输入的密码不一致");
						$("#regbtn").attr("disabled","disabled");
					}else{
						$(this).next().remove();
						$(this).css("border","2px solid green");
						$(this).next().css("color","green");
						$("#regbtn").attr("disabled",false);
					}
				});
				
				//登录验证
				$("#user").on("blur",function(){
					var mobileNumber = $(this).val();
					var mobileReg = /^1[34578]{1}[0-9]{9}/;
					if(mobileNumber == ""){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("手机号不能为空");
						$("#loginbtn").attr("disabled","disabled");
					}else if(!mobileReg.test(mobileNumber)){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("手机号不正确");
						$("#loginbtn").attr("disabled","disabled");
					}else{
						$(this).next().remove();
						$(this).css("border","2px solid green");
						$(this).next().css("color","green");
						$("#loginbtn").attr("disabled",false);
					}
					
				});
				
				//密码验证
				$("#pass").on("blur",function(){
					var password = $(this).val();
					if(password == ""){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("密码不能为空");
						$("#loginbtn").attr("disabled","disabled");
					}else if(password.length<7){
						$(this).css("border","2px solid red");
						$(this).next().css("color","red");
						$(this).next().text("密码不能小于6位");
						$("#loginbtn").attr("disabled","disabled");
					}else{
						$(this).next().remove();
						$(this).css("border","2px solid green");
						$(this).next().css("color","green");
						$("#loginbtn").attr("disabled",false);
					}	
				});
				
				//验证码登录模态框
				$("#yanzheng").on("click",function(){
					$("#myModal").modal('show');
					//输入手机号框的离焦事件
					$("#telphone").on("blur",function(){
						var phone = $("#telphone").val();
						var mobileReg = /^1[34578]{1}[0-9]{9}/;
						if(phone == ""){
							$(this).css("border","2px solid red");
							$(this).next().css("color","red");
							$(this).next().text("手机号不能为空");
							$("#loginbtn").attr("disabled","disabled");
						}else if(!mobileReg.test(phone)){
							$(this).css("border","2px solid red");
							$(this).next().css("color","red");
							$(this).next().text("手机号不正确");
							$("#loginbtn").attr("disabled","disabled");
						}else{
							$(this).next().remove();
							$(this).css("border","2px solid green");
							$(this).next().css("color","green");
							$("#loginbtn").attr("disabled",false);
						}
					})
					
					
					
					//获取验证码的点击事件
					$(".btn-primary").on("click",function(){
						getMessage();
					});
					
					
					
					
				})
				
				
				
			});
			//$(function)之外的东西
			function getMessage(){
				var phone = $("#telphone").val();
				if($(".btn-primary").text()=="获取验证码"||$(".btn-primary").text()=="重新获取"){
					start11();
					$.ajax({
						url:"../getCode?phone="+phone,
						contentType:"application/json;charset=utf-8",
						type:"post",
						dataType:"json",
						success:function(data){//返回值为一个验证码
							
						}
					});
					
				}
			}
			//倒计时
			var d = 60;
			var n;
			function daojishi(){
				$(".btn-primary").attr("disabled",true);
				var j = d+"s后可重新发送"
				//清除计时
				//倒计时
				d--;
				//把文本赋值进去
				$(".btn-primary").html(j)
				//一秒刷新
				if(d == 0){
					$(".btn-primary").html("重新获取");
					$(".btn-primary").attr("disabled",false);
					d = 60;
					clearInterval(n);
					return;
				} 
			}
			function start11(){//每秒调用函数
			 	n = setInterval("daojishi()",1000);
			}
			
			
			
			
		
		
		</script>
		
	</head>

	<body>
		<c:if test="${not empty msg_filter }">
			<script>
				alert("${msg_filter}");
			</script>
		</c:if>
		<!-- 头部 开始 -->
		<div id="top" style="height: 55px;">
			<object style="border:0px" type="text/x-scriptlet" data="${pageContext.request.contextPath}/front/head.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 头部 结束 -->

		<!-- 内容 开始 -->
		<div class="jq22-container" style="padding-top:20px;">
			<div class="login-wrap" style="background-color: white;">
				<div class="login-html">
					<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
					<label for="tab-1" class="tab">登录</label>

					<input id="tab-2" type="radio" name="tab" class="sign-up">
					<label for="tab-2" class="tab">注册</label>
					
					<div class="login-form">
					
						<!-- 登录 开始 -->
						<div class="sign-in-htm">
							<form action = "../loginVerify" method="post">
							<div class="group" style="margin-top: 20px;">
								<span style="color:#ccc">手机号</span>
								<input required id="user" type="text" class="input" name="tel" maxlength="11 " placeholder="请输入手机号">
								<label style="float:right;"></label>
							</div>
							<div class="group" style="margin-top: 50px;">
								<span style="color:#ccc">密码</span>
								<input required id="pass" type="password" class="input" name="password" placeholder="请输入密码">
								<label style="float:right;"></label>
							</div>
							<div class="group" style="margin-top: 50px;">
								<input id="loginbtn" type="submit" class="button" value="登录">
							</div>
							</form>
							<div class="hr"></div>
							<div class="foot-lnk" id="yanzheng">
								<span style="color:#ccc">验证码登录</span>
							</div>
						</div>
						<!-- 登录 结束 -->
						
						
						<!-- 注册 开始 -->
						<form action = "../registe" method = "post">
						<div class="sign-up-htm">
							<div class="group">
								<span style="color:#ccc">手机号</span>
								<input name="tel" required id="mobile" type="text" class="input" maxlength="11" placeholder="请输入手机号">
								<label style="float:right;"></label>
							</div>
							<div class="group">
								<span style="color:#ccc">用户名</span>
								<input name="username" required id="register_user" type="text" class="input" maxlength="6" placeholder="请输入一个昵称">
								<label style="float:right;"></label>
							</div>
							<div class="group">
								<span style="color:#ccc">密码</span>
								<input name="password" required id="register_pass" type="password" class="input" data-type="password" placeholder="请输入密码">
								<label style="float:right;"></label>
							</div>
							<div class="group">
								<span style="color:#ccc">确认密码</span>
								<input required id="register_pass1" type="password" class="input" data-type="password" placeholder="请再次输入密码">
								<label style="float:right;"></label>
							</div>
							
							<div class="group">
								<input id="regbtn" type="submit" class="button" value="注册">
								<label style="float:right;"></label>
							</div>
							<div class="hr"></div>
							<div class="foot-lnk">
								<label for="tab-1"><span style="color:#ccc">存在账号？</span></a>
							</div>
						</div>
					<!-- 注册 结束 -->
					</form>
				</div>
			</div>
		</div>
	</div>
		<!-- 内容 结束 -->
			
		<!-- 底部开始 -->
		<div id="bottom" style="height: 270px;">
			<object style="border:0px" type="text/x-scriptlet" data="${pageContext.request.contextPath}/front/bottom.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 底部结束 -->
		
		
		<!-- 验证码登录的模态框 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:450px;height:350px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">验证登录</h4>
				</div>
				<div class="modal-body" style="background-color:white;">
					<!--这里面是一个表单-->
					<div id="wrap" class="bg-info">
						<form class="form-horizontal" role="form" action="../codeLogin"
							method="post">
							<div class="form-group">
								<label class="col-sm-2"></label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="telphone"
										placeholder="请输入手机号" name="phonenumber"><label style="float:right;"></label>
								</div>
							</div>
							<div class="form-group">
								<div class = "col-sm-2"></div>
								<div class="col-sm-5">
									<input required type="password" class="form-control" id="lastname"
										placeholder="请输入验证码" name="userpwd">
								</div>
								<div class = "col-sm-3">
									<button type="button" class="btn btn-primary">获取验证码</button>
								</div>
							</div>
							<div class = "form-group">
								<div class="col-sm-2">
								
								</div>
								<div class="col-sm-8">
									<button class=" btn btn-warning col-sm-12">登录</button>
								</div>
							
							</div>
							
							
							
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		
		
		
		
		
</body>
</html>