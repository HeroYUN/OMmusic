<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		<title>歌曲详细</title>
		<link href="" type="image/x-icon" rel="shortcut icon">
		<link type="text/css" rel="stylesheet" href="./music-detail_files/reset.css">
		<link rel="stylesheet" href="./music-detail_files/common.css">
		<link type="text/css" rel="stylesheet" href="./music-detail_files/singles.css">
		<link type="text/css" rel="stylesheet" href="./music-detail_files/ugc.css">
		<link href="./music-detail_files/comm_COMMENT.css" rel="stylesheet" type="text/css">
		<!--引入css样式文件-->
		<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.css" />
		<!--引入jquery库-->
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<!-- 关于qq表情的jQuery -->
		<script type="text/javascript" src="dist/js/jquery-migrate-1.2.1.js"></script>
		<script type="text/javascript" src="dist/js/jquery.qqFace.js"></script>
		<script src="dist/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			.dianzan {
				height: 16px;
				line-height: 16px;
				padding: 2px 21px 0 0;
				background: url("http://www.kuwo.cn/static/image/comment/bg3.jpg") no-repeat right 0;
				margin-right: 0
			}
			
			/*滚动条样式*/
			 ::-webkit-scrollbar {
				width: 8px;
				/*height: 4px;*/
			}
			 ::-webkit-scrollbar-thumb {
				border-radius: 10px;
				-webkit-box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
				background: rgba(0, 0, 0, 0.2);
			}
			 ::-webkit-scrollbar-track {
				-webkit-box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
				border-radius: 0;
				background: rgba(0, 0, 0, 0.1);
			}
		</style>
		<script>
			$(function() {
				
				//根据传入的参数打开新的窗口
				function openNewWindow(url) {
					let a = $("<a href='" + url + "' target='_blank'>播放界面</a>").get(0);
					let e = document.createEvent('MouseEvents');
					e.initEvent('click', false, false);
					a.dispatchEvent(e);
				}

				//实现播放和添加到播放列表的方法
				function addListAndPlay(songIdStrings, operation) {
					// 执行操作 
					$.ajax({
						url: "../addListAndPlay.action?songIdStrings=" + songIdStrings,
						data: '{"addListAndPlay" : "添加到播放列表并且播放"}',
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						type: "post",
						success: function(length) {
							//console.log("length=" + length);
							//console.log(operation);
							//console.log(operation == "addListAndPlay");
							if(operation == "addListAndPlay") {
								openNewWindow("play.jsp?operation=" + operation + "&length=" + length);
							} else {
								alert("添加播放列表成功！");
								//openNewWindow("front/play.jsp?operation=" + operation);
								//window.close();
							}
						}
					});
				}
				//为
				$("#wp_playBtn").on("click" , function(){
					var songId = $("#songIdB").val();
					//console.log(songId);
					addListAndPlay(songId,"addListAndPlay");
				});
				
				
				
				
				//获取请求参数里面的东西
				function getQueryString(str) {
					var result = window.location.search.match(new RegExp("[\?\&]" + str +
						"=([^\&]+)", "i"));
					if(result == null || result.length < 1) {
						return "";
					}
					return result[1];
				}
			
				
				var songId = getQueryString("songId"); //获取请求参数里面的songId
				
				
				
				//发表评论的点击事件
				$("#messageBtn").on("click", function() {
					var commentMessage = $("#messageCon").val();
					console.log(decodeURI(commentMessage));
					if(commentMessage == null || commentMessage == "") {
						alert("请输入内容");
						$("#messageCon").focus();
						return;
					}
					//ajax的异步提交
					$.ajax({
						url: "../addComments?songId=" + songId,
						contentType: "application/json;charset=utf-8",
						type: "post",
						data : {"" : decodeURI(commentMessage) },
						dataType: "json",
						success: function(data) {
							if(data == "1") {
								alert("评论成功");
								history.go(0);
							} else {
								alert("评论失败");
							}
						}
					});
				});

				
				//页面加载的时候调用获取全部信息
				getMessage(songId);
				
				$("#sinlesDownBtn").on("click",function(){
					//使用ajax获取到当前song的歌词和歌曲文件的路径
					$.ajax({
						url:"../basicMessage?songId="+songId,
						contentType:"application/json;charset=utf-8",
						method:"post",
						dataType:"json",
						success:function(data){
							//跳转到下载页面
							window.location.href="${pageContext.request.contextPath}/download.action?lrc="+data.lyric+"&mp="+data.mp3;
						}
					})
				})
				
				//获取页面主要信息的方法
			function getMessage(songId) {
				//获取歌词
				$.ajax({
					url:"../lyric?songId="+songId,
					contentType:"application/json;charset=utf-8",
					type:"post",
					dataType:"json",
					success:function(data){
						//往p标签添加内容
						$.each(data,function(index,lyric){
							$("#llrcId").append("<p class=\"lrcItem\">"+lyric+"</p>")
						})
						$("#llrcId").append("<p class=\"lrcItem\"></p>")
					}
				})
				
				
				$.ajax({
					url: "../basicMessage?songId=" + songId,
					contentType: "applicationi/json;charset=utf-8",
					type: "post",
					dataType: "json",
					success: function(data) {
						
						console.log("------>data = ");
						console.log(data);
						//填充数据
						$("#songIdB").val(data.songId);
						$("#lrcName").text(data.songName);
						$("#musiclrc span a").text(data.singer.singerName);
						$("#musiclrc span a").prop("href","../singerInfo.action?singerId="+data.singer.singerId);
						$(".photopic").prop("src", data.singer.picture);
						$(".photopic").parent("a").prop("href", "../singerInfo.action?singerId="+data.singer.singerId);
					}
				});
				//获取当前歌曲对应歌手的六首最热歌曲
				$.ajax({
					url: "../sixSongBySongId?songId=" + songId,
					contentType: "application/json;charset=utf-8",
					type: "post",
					dataType: "json",
					success: function(data) {
						$("#singerTop").text(data[0].singername + "歌榜TOP6") //设置歌手名字
						$.each(data, function(index, sixSong) { //填充榜单数据
							$("#singerTopBang").append(
								"<li><button class='songId' value='"+sixSong.songid+"'></button><span class = \"red\">" +(index + 1) +"</span>" +
								"<a class = \"name\" href=\"music-detail.jsp?songId=" +sixSong.songid +"\">" +
								sixSong.songname +"</a>" +
								"<a class = \"artist\" href =\"../singerInfo.action?singerId=" +
								sixSong.singerid +"\">" +sixSong.singername +
								"</a>" +
								"<a class = \"listen\" title='播放'></a></li>");
						});
						//给 《听》 按钮添加事件
						$("#singerTopBang li .listen").on("click", function() {
							//获取选择歌曲对应的字符串信息
							var songIdStrings = $(this).parent("li").children(".songId").val();
							//console.log("我要播放选中歌曲" + songIdStrings);
							addListAndPlay(songIdStrings, "addListAndPlay");
							$(this).unbind("click");
							
						});

					}
				});

				//获取全系统最热的六首歌曲
				$.ajax({
					url: "../sixSong",
					contentType: "application/json;charset=utf-8",
					type: "post",
					dataType: "json",
					success: function(data) {
						$.each(data, function(index, sixSong) {
							$("#allTopBang").append("<li><span class = \"red\">" +
								(index + 1) +
								"</span>" +
								"<a class = \"name\" href=\"music-detail.jsp?songId=" +
								sixSong.songid +
								"\">" +
								sixSong.songname +
								"</a>" +
								"<a class = \"artist\" href =\"../singerInfo.action?singerId=" +
								sixSong.singerid +
								"\">" +
								sixSong.singername +
								"</a>" +
								"<a class = \"listen\" href = \" \"></a></li>");
						});
					}
				});

				//获取全部的评论信息
				$.ajax({
					url: "../showAllComment?songId=" + songId,
					contentType: "application/json;charset=utf-8",
					type: "post",
					dataType: "json",
					success: function(data) {
						//console.log("获取的评论信息以及对应对的回复评论信息为");
						//console.log(data);
						$("#commentArea .title_ .num").text(data.length); //总共多少条评论
						$.each(data, function(index, comment) {
							var replyCommentList = data[index].replyCommentList;
							$("#rec_list").append("<div class=\"box\" data-id=\"531906166\" data-uid=\"94513228\">" +
								"<div class=\"picBox\" id=\"" + comment.commentsId + "\">" +
								"<img class = \"head\" src=\"" + comment.users.picture + "\"></div>" +
								"<div class = \"contentComment\">" +
								"<div class = \"main\">" +
								"<div class = \" replyBox\">" +
								"<span class = \"user\" style=\"color:#cd9800\">" +
								comment.users.username +
								"</span>" +
								"<span class = \"replyCon\">" +
								replace_em(decodeURI(comment.commentsContent)) +
								"</span></div></div>" +
								"<div class = \"info_\">" +
								"<a class = \"reply\">回复</a>" +
								"<a class = \"praise\" >" +
								comment.greatCount +
								"</a><span class=\"delLine\"></span>" +
								"<p class = \"time\">" +
								comment.commentsTime +
								"</p></div></div><div class=\"replay\" style=\"width:80%;margin-left:150px\"></div>");
							//处理回复评论会重复添加的问题
							$.each($(".replay"), function(index2) {
								if(index == index2) {
									var $reply = $(this);
									$.each(replyCommentList, function(index1, remark) {
										if(index1 != 0){
											$reply.append("<p><span style=\"color:#cd9800\" style='width:200px'>" + remark.users.username +
											"</span>&nbsp;&nbsp;&nbsp;：" + remark.rContent + "</p>");
										}
									});
								}
							});
						});
						//点赞事件，ajax是在页面加载之后填充数据，所以写在$(function)中是无效的
						$(".praise").on("click", function() {
							//获取评论的Id
							var commentId = $(this).parent().parent().prev().attr("id");
							$(this).removeClass("praise");
							$(this).addClass('dianzan');
							$(this).text(
								(eval($(this).text()) + 1));
							//解除绑定
							$(this).unbind("click");
							//点赞
							$.ajax({
								url: "../thumbs?commentId=" + commentId,
								contentType: "application/json;charset=utf-8",
								type: "post",
								dataType: "json",
								success: function(data) {

								}
							})
						});
						//回复事件
						$(".reply").on("click", function() {
							$("#myModal").modal('show')
							//获取该评论的id
							var commentId = $(this).parent().parent().prev().attr("id");
							//点击回复按钮出发ajax提交
							$(".btn-primary").on("click", function() {
								var repComments = $("#repComment").val();
								//console.log(commentId+","+repComments);
								 //回复
								$.ajax({
									url: "../repComment?commentId=" + commentId + "&repComment=" + repComments,
									contentType: "application/json;charset=utf-8",
									type: "post",
									dataType: "json",
									success: function(data) {
										//console.log(data)
										if(data == 1){
											alert("评论回复成功！");
										}else{
											alert("回复评论发表失败！")
										}
										history.go(0);
									}
								}); 
							});

						});

					}
				});
			}
				
				/* 表情的处理 */
				$(".emotion").qqFace({
					assign: 'messageCon', //接收表情的文本域
					path: 'face/' //表情图片存放的路径
				});

				//查看结果  替换文本显示表情
				function replace_em(str) {
					str = str.replace(/\</g, '<;');
					str = str.replace(/\>/g, '>;');
					str = str.replace(/\n/g, '<;br/>;');
					str = str.replace(/\[em_([0-9]*)\]/g,
						'<img src="face/$1.gif" border="0" />');
					return str;
				}
		});

			
		</script>

	</head>

	<body avalonctrl="dqPlayer">

		<!-- 头部 开始 -->
		<div id="top" style="height: 55px;">
			<object style="border: 0px" type="text/x-scriptlet" data="head.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 头部 结束 -->

		<!-- content start -->
		<div id="musicCon">
			<div class="music">
				<!--musicLeft begin-->
				<div id="musiclrc">
					<p id="lrcName"></p>
					<div class="info">
						<p class="artist">
							歌手：<span><a href=""data-id="992315"></a></span>
						</p>
						<div class="singleShareBox"></div>
						<a class="goComment">评论</a>
					</div>
					<div id="lrcContent" class="scrollbar" style="position: relative;">
						<!-- 歌词 开始 -->
						<!-- 从文件中获取歌词 -->
						<div id="llrcArea">
							<div id="llrcId" style="overflow:scroll; top: 0px;height:474px;">

							</div>
						</div>
						<!-- 歌词 结束 -->
						<div id="bar_box">
							<div id="bar" style="top: 0px;"></div>
						</div>
					</div>
				</div>
				<!--musicLeft end-->

				<!--musicRight begin-->
				<div id="playerBox">
					<!-- 歌手图片 begin -->
					<div class="musiciPic">
						<a href="">
							<!-- 跳转到歌手详细界面 -->
							<img class="photopic" src="">
						</a>
					</div>
					<!-- 歌手图片 end -->

					<!-- 播放器  begin -->
				<!-- 	<div class="play" id="wp_playBtn" title="暂停/播放" style=""></div> -->
					<!--<div class="playerMid">
						<div id="prograssBar" class="borderRadius">
							<div id="wp_bufBar" class="borderRadius">
								<div class="prograssBar borderRadius" id="wp_processBar"></div>
								<a href="javascript:;" class="schedule_btn" id="wp_processBtn" style="left: 0"></a>
							</div>
						</div>
					</div>-->
					<!--<p id="wp_playTime" class="wp_playTime_singles">03:20</p>-->
					<!--<div class="sound" id="wp_mute"></div>
					<!-- 播放器 end -->
					<div class="down">
						<div class="play" id="wp_playBtn" title="播放这首歌">
							<button id="songIdB" value=""></button>
						</div>
					</div>
					<div class="down">
						<a id="sinlesDownBtn" class="click_log" ><span class="icon"></span><span style="color:white">免费下载这首歌</span></a>
					</div>
				</div>
				<!--musicRight end-->
			</div>
			<!-- 评论 -->
			<div id="singleComment" style="width: 789px; overflow: hidden">
				<div id="commentArea" style="">
					<!--评论次数是从获取数据库的所有评论次数-->
					<p class="title_">
						评论<span class="num"></span><span>条评论</span>
					</p>
					<!-- 用户的头像 -->
					<img class="commentCover" src="${user.picture}">
					<div id="message" class="msg">
						<div class="textBox">
							<textarea id="messageCon" class="scrollBox msgCon"></textarea>
						</div>
						<a id="messageBtn" class="msgBtn" style="cursor:pointer">评论</a>

						<!--添加表情按钮  -->
						<span class="emotion"></span>

					</div>

					<div class="listBox">
						<h4>全部评论</h4>
						<div id="rec_list">
							<!-- ajax填充 -->

						</div>
					</div>
					<!-- 分页 开始 -->
					<!-- <div class="pageComment">
						<a hidefocus="" href="javascript:;" class="noprev"><img src="./music-detail_files/prev.png"></a>
						<a hidefocus="" href="javascript:;" class="current">1</a>
						<a hidefocus="" href="javascript:;" class="">2</a>
						<a hidefocus="" href="javascript:;" class="">3</a><span class="point">...</span>
						<a hidefocus="" href="javascript:;" class="">36</a>
						<a hidefocus="" href="javascript:;" class="next"><img src="./music-detail_files/next.png"></a>
					</div> -->
					<!-- 分页 结束 -->
				</div>
			</div>
			<!--列表 begin-->
			<div class="list">
				<div class="model artistHot">
					<div class="modelTitle">
						<!-- 进来的时候获取的歌曲id中的歌手的name -->
						<h2 id="singerTop">
						<!-- ajax填充 -->
					</h2>
					</div>
					<ul id="singerTopBang">
						<!-- ajax填充数据 -->
					</ul>
				</div>
				<div class="model topBang">
					<div class="modelTitle">
						<h2>歌曲榜TOP6</h2>
					</div>
					<ul id="allTopBang">
						<!--使用ajax填充  -->
					</ul>
				</div>
			</div>
			<!--列表 end-->
		</div>
		<!-- context end -->
		<!-- 底部开始 -->
		<div id="bottom" style="height: 270px;">
			<object style="border: 0px" type="text/x-scriptlet" data="bottom.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 底部结束 -->
		<!-- 模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">回复评论</h4>
					</div>
					<div class="modal-body" style="height:100px">
						<div class="form-group">
							<div class="col-sm-10">
								<input type="text" class="form-control" id="repComment" placeholder="最多50个字" name="username">
							</div>
							<div class="col-sm-2">
								<button class=" btn btn-primary">回复</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
	</body>

</html>