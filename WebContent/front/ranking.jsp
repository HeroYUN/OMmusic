<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		<link href="" type="image/x-icon" rel="shortcut icon">
		<link rel="stylesheet" type="text/css" href="./ranking_files/reset.css">
		<link rel="stylesheet" href="./ranking_files/jquery.mCustomScrollbar.css">
		<link rel="stylesheet" href="./ranking_files/common.css">
		<link rel="stylesheet" href="./ranking_files/player.css">
		<link type="text/css" rel="stylesheet" href="./ranking_files/charts.css">
		<title>欧米榜单</title>
		<link type="text/css" rel="stylesheet" href="./ranking_files/ugc.css">
		<link href="./ranking_files/comm_COMMENT.css" rel="stylesheet" type="text/css">
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() {
				/**
				*	实现播放和添加到播放列表的方法
				*/
				function addListAndPlay(songIdStrings,operation){
					// 执行操作 
					 $.ajax({
						url : "../addListAndPlay.action?songIdStrings="+songIdStrings,
						data : '{"addListAndPlay" : "添加到播放列表并且播放"}',
						contentType : "application/json;charset=utf-8",
						dataType : "json",
						type : "post",
						success : function(length) {
							if(operation == "addListAndPlay"){
								openNewWindow("play.jsp?operation="+operation+"&length="+length);
							}else{
								alert("添加播放列表成功！");
							}
						}
					});  
				}
				//根据传入的参数打开新的窗口
				function openNewWindow(url) {
		            let a = $("<a href='"+url+"' target='_blank'>播放界面</a>").get(0);
		            let e = document.createEvent('MouseEvents');
		            e.initEvent( 'click', false, false );
		            a.dispatchEvent(e);
		        }
				$.each($("#chartsContent .leftNav .classify ul li"), function() {
					$(this).css("cursor", 'pointer');
				});
				
				showMessage(1);
				
				function showMessage(songTypeString) {
					var num = 0;
					$.ajax({
						url: "../getSongByType.action?songTypeString=" + songTypeString,
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						type: "get",
						success: function(data) {
							console.log("data = "+data);
							$.each(data, function(index, song) {
								var i = index + 1;
								num = num + 1;
								
								$(".listMusic").append(
									"<li class='showbtn'>"+
										"<button class='songId' value='"+song.songid+"'></button>"+
										"<div class='leftInfo'>"+
											"<p class='num'>" + i +"</p>"+
											"<div class='mTrend'>"+
												"<span class='e0'></span>"+
											"</div>"+
										"</div>"+
										"<div class='name'>"
											+"<a href='music-detail.jsp?songId="+song.songid+"'>" + song.songname + "</a>"+
										"</div>" +
										"<div class='artist'>"+
											"<a href='../singerInfo.action?singerId="+song.singerid+"'>" + song.singername + "</a>"+
										"</div>" +
										"<div class='heat'>"+
											"<div class='heatValue' style='width:"+song.songcount+";'></div>"+
										"</div>" +
										"<div class='listRight'>"+
											"<div class='tools' style='display: none; padding-left:20px'>" +
												"<a class='play playSong' title='播放'></a>"+
												"<a class='add' title='添加到播放列表' ></a>" +
												"<a class='down click_log' href='${pageContext.request.contextPath}/download.action?lrc="+song.lyric+"&mp="+song.mp3+"' title='下载'/>"+
											"</div>" +
											"<span style='display:block;'>" + song.songtime + "</sapn>"+
										"</div>"+
									"</li>"
								);
							});
							//设置鼠标悬浮在歌曲列表上，显示下载，播放，加入播放列表组件
							$.each($(".listMusic li"), function() {

								$(this).hover(function() { //上去
									$(this).children(".listRight").children(".tools").css("display", "block");
									$(this).children(".listRight").children("span").css("display", "none");
								}, function() { //下来
									$(this).children(".listRight").children(".tools").css("display", "none");
									$(this).children(".listRight").children("span").css("display", "block");
								})
							});
							
							//设置鼠标悬浮
							$("#songControll .playAll").css("cursor","pointer");
							$("#songControll .addAll").css("cursor","pointer");
							$(".listMusic li .listRight .tools .play").css("cursor","pointer");
							$(".listMusic li .listRight .tools .add").css("cursor","pointer");
							
							//获取全部的歌曲编号，拼接到字符串中
							var songIdStrings = "";
							$.each($(".listMusic li .songId"),function(index){
								//存放全部的歌曲编号的字符串
								songIdStrings += $(this).val()+"/"; 
							});
							//给 《播放全部》 按钮添加事件
							$("#songControll .playAll").on("click",function(){
								console.log("我要播放全部歌曲---"+songIdStrings);
								addListAndPlay(songIdStrings,"addListAndPlay");
							});
						
							//给 《添加》 按钮添加事件
							$("#songControll .addAll").on("click",function(){
								console.log("我要播放添加全部歌曲到我的播放列表"+songIdStrings);
								addListAndPlay(songIdStrings,"addList");
							});
							
							//给组件中的 《播放 》按钮绑定事件
							$.each($(".listMusic li .listRight .tools .play"),function(){
								$(this).on("click",function(){
									console.log("我要播放这首歌");
									songIdString = $(this).parent(".tools").parent(".listRight").parent("li").children(".songId").val()+"/";
									console.log("songIdString="+songIdString);
									addListAndPlay(songIdStrings,"addListAndPlay");
									//$(this).unbind("click");
								})
							});
							
							//给组件中的 《添加到播放列表》 按钮绑定事件
							$.each($(".listMusic li .listRight .tools .add"),function(){
								$(this).on("click",function(){
									console.log("我要添加这首歌曲到我的播放列表");
									songIdString = $(this).parent(".tools").parent(".listRight").parent("li").children(".songId").val()+"/";
									console.log("songIdString="+songIdString);
									addListAndPlay(songIdStrings,"addList");
									//$(this).unbind("click")
								})
							})
							//给组件中的 《下载》 按钮绑定事件
						}
					});
				};
				

				$.each($("#chartsContent .leftNav .classify ul .songtype"), function() {

					$(this).on("click", function() {
						$("#chartsContent .leftNav .classify ul .songtype").children("a").prev("span").css("visibility", "hidden");
						$(this).children("a").prev("span").css("visibility", "visible");
					})
				})

				/* 热搜榜 */
				$("#ahotsong").click(function() {
					$(this).addClass("clicked");
					$("#anewsong").removeClass("clicked");
					$("#achineselksong").removeClass("clicked");
					$("#afolksong").removeClass("clicked");
					$("#anetsong").removeClass("clicked");
					$("#aeasong").removeClass("clicked");
					$("#ajssong").removeClass("clicked");
					//$("#hotsong span").css("visibility","visible")
				});
				$("#hotsong").click(function() {
					$(".listMusic li").remove();
					showMessage(1);
				});
				/* 新歌榜*/
				$("#anewsong").click(function() {
					$("#ahotsong").removeClass("clicked");
					$(this).addClass("clicked");
					$("#achineselksong").removeClass("clicked");
					$("#afolksong").removeClass("clicked");
					$("#anetsong").removeClass("clicked");
					$("#aeasong").removeClass("clicked");
					$("#ajssong").removeClass("clicked");
				});
				$("#newsong").click(function() {
					$(".listMusic li").remove();
					showMessage(2);
				});
				/* 华语榜*/
				$("#achineselksong").click(function() {
					$("#ahotsong").removeClass("clicked");
					$("#anewsong").removeClass("clicked");
					$(this).addClass("clicked");
					$("#afolksong").removeClass("clicked");
					$("#anetsong").removeClass("clicked");
					$("#aeasong").removeClass("clicked");
					$("#ajssong").removeClass("clicked");
				});
				$("#chineselksong").click(function() {
					$(".listMusic li").remove();
					showMessage(3);
				});
				/* 民谣榜*/
				$("#afolksong").click(function() {
					$("#ahotsong").removeClass("clicked");
					$("#anewsong").removeClass("clicked");
					$("#achineselksong").removeClass("clicked");
					$(this).addClass("clicked");
					$("#anetsong").removeClass("clicked");
					$("#aeasong").removeClass("clicked");
					$("#ajssong").removeClass("clicked");
				});
				$("#folksong").click(function() {
					$(".listMusic li").remove();
					showMessage(4);
				});
				/* 网络榜 */
				$("#anetsong").click(function() {
					$("#ahotsong").removeClass("clicked");
					$("#anewsong").removeClass("clicked");
					$("#achineselksong").removeClass("clicked");
					$("#afolksong").removeClass("clicked");
					$(this).addClass("clicked");
					$("#aeasong").removeClass("clicked");
					$("#ajssong").removeClass("clicked");
				});
				$("#netsong").click(function() {
					$(".listMusic li").remove();
					showMessage(5);
				});
				/* 欧美 */
				$("#aeasong").click(function() {
					$("#ahotsong").removeClass("clicked");
					$("#anewsong").removeClass("clicked");
					$("#achineselksong").removeClass("clicked");
					$("#afolksong").removeClass("clicked");
					$("#anetsong").removeClass("clicked");
					$(this).addClass("clicked");
					$("#ajssong").removeClass("clicked");
				});
				$("#easong").click(function() {
					$(".listMusic li").remove();
					showMessage(6);
				});
				/* 日韩 */
				$("#ajssong").click(function() {
					$("#ahotsong").removeClass("clicked");
					$("#anewsong").removeClass("clicked");
					$("#achineselksong").removeClass("clicked");
					$("#afolksong").removeClass("clicked");
					$("#anetsong").removeClass("clicked");
					$("#aeasong").removeClass("clicked");
					$(this).addClass("clicked");
				});
				$("#jssong").click(function() {
					$(".listMusic li").remove();
					showMessage(7);
				});
				//修改更新时间
				var myDate = new Date();
				var time = myDate.toLocaleDateString();
				$("#songControll p").text("最近更新："+time);
				
			});
		</script>
		<script>
					window._bd_share_config = {
						"common": {
							"bdText": "",
							"bdMiniList": false,
							"bdPic": "",
							"bdStyle": "1",
							"bdSize": "24"
						},
						"share": {},
						"selectShare": {
							"bdContainerClass": null,
							"bdSelectMiniList": ["more","qzone", "tsina", "tqq", "renren"]
						}
					};
					with(document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
				</script>
	</head>

	<body avalonctrl="player">
		
		<!-- 头部 开始 -->
		<div id="top" style="height: 55px;">
			<object style="border: 0px" type="text/x-scriptlet" data="head.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 头部 结束 -->
		<!-- 内容 开始 -->
		<div id="chartsContent" class="comW">
			<!-- 排行榜 开始 -->
			<div class="leftNav">
				<div class="classify bang" data-choosed="酷我新歌榜">
					<h2 id="bang_navbar_class" class="down" data-flag="true">分类榜</h2>
					<ul style="display: block;">

						<li id="hotsong" data-name="欧米热歌榜" data-bangid="16" class="songtype"><span style="visibility: visible;"></span>
							<a> <img src="./ranking_files/1444901362664_.jpg" onerror="imgOnError(this,&#39;artist&#39;)">
							</a>
							<a id="ahotsong" class="name clicked song">欧米热歌榜</a>
						</li>

						<li id="newsong" data-name="欧米新歌榜" data-bangid="17" class="songtype"><span></span>
							<a><img src="./ranking_files/1444901569447_.jpg" onerror="imgOnError(this,&#39;artist&#39;)"></a>
							<a id="anewsong" class="name song">欧米新歌榜</a>
						</li>

						<li id="chineselksong" data-name="欧米华语榜" data-bangid="62" class="songtype"><span></span>
							<a><img src="./ranking_files/1530587833022_.png" onerror="imgOnError(this,&#39;artist&#39;)"></a>
							<a id="achineselksong" class="name song">欧米华语榜</a>
						</li>

						<li id="folksong" data-name="欧米民谣榜" data-bangid="158" class="songtype"><span></span>
							<a><img src="./ranking_files/1531102994754_.png" onerror="imgOnError(this,&#39;artist&#39;)"></a>
							<a id="afolksong" class="name">欧米民谣榜</a>
						</li>

						<li id="netsong" data-name=欧米网络榜 data-bangid="157" class="songtype"><span></span>
							<a><img src="./ranking_files/1531102994740_.png" onerror="imgOnError(this,&#39;artist&#39;)"></a>
							<a id="anetsong" class="name">欧米网络榜</a>
						</li>

						<li id="easong" data-name="欧米欧美榜" data-bangid="22" class="songtype"><span></span>
							<a><img src="./ranking_files/1444901107656_.jpg" onerror="imgOnError(this,&#39;artist&#39;)"></a>
							<a id="aeasong" class="name">欧米欧美榜</a>
						</li>

						<li id="jssong" data-name="欧米日韩榜" data-bangid="23" class="songtype"><span></span>
							<a><img src="./ranking_files/1444901436021_.jpg" onerror="imgOnError(this,&#39;artist&#39;)"></a>
							<a id="ajssong" class="name">欧米日韩榜</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- 排行版 结束 -->
			<!-- 右边 内容 开始 -->
			<div class="rightContentBox">
				<!-- 头部 图片 开始 -->
				<div class="banner">
					<img data-id="17" src="./ranking_files/bang_xgb.png">
				</div>
				<!-- 头部 图片 结束 -->

				<div id="songControll">
					<a class="playAll" >播放全部</a>
					<a class="addAll" >添加</a>
					<p>最近更新：2018-11-17</p>
				</div>

				<div class="chooseAll">
					<dl>
						<dd class="trend">&nbsp;</dd>
						<dd class="name">歌曲</dd>
						<dd class="artist">歌手</dd>
						<dd class="heat">热度</dd>
						<dd class="listRight">时长</dd>
					</dl>
				</div>

				<!-- 歌曲列表 开始 -->
				<ul class="listMusic">
				</ul>
				<!-- 歌曲列表 结束 -->

			</div>
			<!-- 右边 内容 结束 -->
		</div>
		<!-- 内容 结束 -->
		<!-- 底部 开始 -->
		<div id="bottom" style="height: 270px;">
			<object style="border: 0px" type="text/x-scriptlet" data="bottom.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 底部 结束 -->
	</body>

</html>