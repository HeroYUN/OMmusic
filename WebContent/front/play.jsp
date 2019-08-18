<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>

	<head>
		<base target="_blank">
		<meta charset="UTF-8">
		<meta name="keywords" content="html5,css3,javascript,音乐,音乐播放器,audio">
		<meta name="description" content="一款基于HTML5、Css3的列表式音乐播放器，包含列表，音量，进度，时间以及模式等功能，不依赖任何库">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="renderer" content="webkit">
		<meta name="version" content="1.0.0">
		<link rel="stylesheet" type="text/css" href="css/play.css" />
		<link rel="stylesheet" href="src/css/smusic.css" />
		<link rel="stylesheet" type="text/css" href="./index/reset.css">
		<link rel="stylesheet" href="./index/jquery.mCustomScrollbar.css">
		<link rel="stylesheet" href="./index/common.css">
		<!-- <link rel="stylesheet" href="./index/player.css"> -->
		<link type="text/css" rel="stylesheet" href="./index/index.css">
		<link type="text/css" rel="stylesheet" href="./index/ugc.css">
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<title>播放列表</title>
		<style type="text/css">
			#top {
				background-color: black;
			}
			
			#play {
				margin-top: 8px;
				width: 65%;
				margin-left: 150px;
				height: 680px;
			}
			
			#list {
				height: 540px;
				width: 62%;
			}
			
			#lyric {
				width: 45%;
			}
		</style>
		<script>
		$(function(){
				$(document).on("click","#searchmsg",function(){
				var msg=$("#search").val();
				
			
			$("#searchmsg").prop("href","/OMmusic/front/search.jsp?msg="+msg);
					
					
				});
				var username = "${user.username}"
				if(username !== ""){
					$("#loginBtn").html(username);
					$("#loginBtn").prop("href","javascript:");
					$("#removeUser").prop("style","display:block");
				}
				//退出事件
				$("#removeUser").on("click",function(){
					window.location.href = "../removeUser";
				})
				
			});
		</script>
	</head>

	<body>
		<!-- 头部 开始 -->
		<div id="top" kw_ver="1.0.0">
			<div class="top">
				<a class="logo" href="index.jsp"> <img src="./index/logo2.png" alt="logo" style="width: 120px; margin-right: 20px; margin-top: 8px;">
				</a>
				<ul class="nav">
					<li>
						<a href="index.jsp">首页</a>
					</li>
					<li>
						<a href="ranking.jsp">榜单</a>
					</li>
					<li>
						<a href="singer.jsp">歌手</a>
					</li>
					<li>
						<a href="songList.jsp">歌单</a>
					</li>
					<li>
						<a href="play.jsp" target="_top">播放列表</a>
					</li>
				</ul>
				<div class="tools">
					<div class="search">
						<input type="text" id="search" name="search" placeholder="找到好音乐">
						<a class="searchBtn" title="搜索" id="searchmsg" target="_top"></a>
					</div>
				</div>
			</div>
		</div>
		<!-- 头部 结束 -->

		<div class="grid-music-container f-usn" id="play" style="">
			<!-- 播放组件 开始 -->
			<div class="m-music-play-wrap" id="controll">
				<div class="u-cover"></div>
				<div class="m-now-info">
					<h1 class="u-music-title">
					<strong>标题</strong><small>歌手</small>
				</h1>
					<div class="m-now-controls">
						<div class="u-control u-process">
							<span class="buffer-process"></span> <span class="current-process"></span>
						</div>
						<div class="u-control u-time">00:00/00:00</div>
						<div class="u-control u-volume">
							<div class="volume-process" data-volume="0.50">
								<span class="volume-current"></span> <span class="volume-bar"></span>
								<span class="volume-event"></span>
							</div>
							<a class="volume-control"></a>
						</div>
					</div>
					<div class="m-play-controls">
						<a class="u-play-btn prev" title="上一曲"></a>
						<a class="u-play-btn ctrl-play play" title="暂停"></a>
						<a class="u-play-btn next" title="下一曲"></a>
						<a class="u-play-btn mode mode-list current" title="列表循环"></a>
						<a class="u-play-btn mode mode-random" title="随机播放"></a>
						<a class="u-play-btn mode mode-single" title="单曲循环"></a>
					</div>
				</div>
			</div>
			<!-- 播放组件 结束  -->
			<div class="f-cb">&nbsp;</div>
			<!-- 播放列表 开始 -->
			<div class="m-music-list-wrap" id="list" style=""></div>
			<!-- 播放列表 结束 -->
			<!-- 歌词列表 开始 -->
			<div class="m-music-lyric-wrap" id="lyric" style=" ">
				<div class="inner">
					<ul class="js-music-lyric-content">
						<li class="eof">暂无歌词...</li>
					</ul>
				</div>
			</div>
			<!-- 歌词列表 结束 -->
		</div>

		<!-- <script src="src/js/musicList.js"></script> -->
		<script src="src/js/smusic.js"></script>
		<script>
			$(document).ready(function() {
				//打开新的窗口
				function openNewWindow(url) {
					//var a = $('a')[0];
					let a = $("<a href='" + url + "' target='_blank'>播放界面</a>").get(0);
					let e = document.createEvent('MouseEvents');
					e.initEvent('click', true, true);
					a.dispatchEvent(e);
				}
				/**
				 * 获取请求参数里面的东西 hnb 2018年11月27日 13:32:20
				 */
				function getQueryString(str) {
					var result = window.location.search.match(new RegExp("[\?\&]" + str + "=([^\&]+)", "i"));
					if(result == null || result.length < 1) {
						return "";
					}
					return result[1];
				}
				/**
				*	加载播放列表
				*/
				function loadPlayList(musicList,defaultIndex){
					new SMusic({
						musicList: musicList,
						autoPlay: true, //是否自动播放
						defaultMode: 1, //默认播放模式，随机
						callback: function(obj) { //返回当前播放歌曲信息
							//console.log("当前播放歌曲为：");
							//console.log(obj);
						},
						defaultIndex: defaultIndex //默认播放索引
					});
				}
				
				
				//跳转到上一个界面
				//openNewWindow(document.referrer);
				
				//获取上个地址传递过来的原始播放列表的长度
				var defaultIndex = getQueryString("length");
				
				if(defaultIndex == null) {
					defaultIndex = 0;
				}

				var songName;
				var singerName;
				var cover;
				var src;
				var lyric;
				var songId;
				var musicList = [];

				//页面加载获取用户的播放列表
				$.ajax({
					url: "../loadPlay.action",
					data: '{"content" : "加载播放列表"}',
					contentType: "application/json;charset=utf-8",
					dataType: "json",
					type: "post",
					success: function(data) {
						$.each(data, function(index, song) {
							songName = song.songName;
							singerName = song.singer.singerName;
							cover = song.singer.picture;
							src = song.mp3;
							lyric = song.lyric;
							songId = song.songId;
							/* console.log("name='" + name + "',singerName='" +
								singerName + "',cover='" + cover +
								"',src='" + src + "',lyric='" + lyric + "'"); */
							musicList.push({
								title: songName,
								singer: singerName,
								cover: cover,
								src: src,
								lyric: lyric,
								songId : songId
							});
						});
						//console.log("默认播放索引为：" + defaultIndex);
						//加载播放列表
						loadPlayList(musicList,defaultIndex);
						
						//console.log("列表长度为=" + $(".f-toe a").length)
						$.each($(".f-toe"), function() {
							$(this).hover(function() { //鼠标悬浮上去
								$(this).children("a").css("display", "block");
								$(this).css("backgroundColor", "rgb(220,215,215,0.5)");
							}, function() { //鼠标离开
								$(this).children("a").css("display", "none");
								$(this).css("backgroundColor", "white");
							})
						});
						$(document).on("click",".f-toe a",function(){
							//获取当前a标签所在的li
							//移除li
							$(this).parent("li").remove();
							//获取当前对象在列表中的索引
							for(i=0 ; i < musicList.length ; i++){
								if(i == $(this).prev("input").val()){
									//console.log("------------i="+i);
									var x = i;
									//console.log(x);
									//console.log("==================歌曲编号="+musicList[i].songId);
									//当前播放列表中移除该歌曲
									$.ajax({
										url: "../removeSongToPlayList.action?songId="+musicList[i].songId,
										data: {"removeSongToPlayList":"播放列表移除歌曲" },
										contentType: "application/json;charset=utf-8",
										dataType: "json",
										type: "post",
										success: function(data) {
											//console.log(data);
											//console.log("i="+i);
											//musicList.pop(i);
											//loadPlayList(musicList,i);
											window.location.href="http://localhost:8090/OMmusic/front/play.jsp?length="+x;
										}
									});
									
								}
							}
						});
						
						//获取上个页面传过来的operation
						var operation = getQueryString("operation");
						if(operation == "addList"){
							openNewWindow(document.referrer);
							window.location.href="http://localhost:8090/OMmusic/front/play.jsp";
						}
					}
					
					
				});

			});
		</script>
	</body>

</html>