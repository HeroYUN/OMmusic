<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		<link rel="stylesheet" type="text/css" href="./search_files/loginbox2012.css">
		<link rel="stylesheet" type="text/css" href="./search_files/base20140423.css">
		<link href="" type="image/x-icon" rel="shortcut icon">
		<title>搜索结果</title>
		<link rel="stylesheet" type="text/css" href="./search_files/index20140516002.css">
		<!-- <link href="./search_files/bdsstyle.css" rel="stylesheet" type="text/css"> -->
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() {
				//获取选择歌曲的字符串集合
				function getSongIds(status){
					var songIds = "";
					if(status == "all"){
						$.each($("#ul_song_check li .number input"), function() {
							songIds += $(this).val()+"/";
						});
					}
					if(status == "some"){
						//获取已经选择的复选框中对应的歌曲编号
						$.each($("#ul_song_check li .number input"), function() {
							if($(this).prop("checked")){
								songIds += $(this).val()+"/";
							}
						});
					}
					return songIds;
				}
				
				function showdata(pageData) {
					$.each(pageData, function(index, song) {
						$("#ul_song_check").append("<li class=\"clearfix\">" +
							"<p class=\"number\"><input class=\"song_check\" type=\"checkbox\" value='"+song.songId+"'>" + (index + 1) +
							"</p><p class=\"a_name\">" +
							"<a href=\"music-detail.jsp?songId=" + song.songId + "\">" + song.songName +
							"</a></p><p class=\"a_name\">" +
							"<a href=\"../singerInfo.action?singerId=" + song.singer.singerId + "\">" +
							song.singer.singerName + "</a></p>" +
							"<p class=\"share\" style=\"margin-left: 50px;\">" +
							"<a class=\"sharesong\"  title=\"分享\"></a>" +
							"</p><p class=\"down\" style=\"margin-left:40px;\">" +
							"<a  title=\"" + song.songName + song.singer.singerName +
							"歌曲下载\" href='${pageContext.request.contextPath}/download.action?lrc=" +
							song.lyric + "&mp=" + song.mp3 + "'></a>" + "</p>" + "</li>");
						$("#showNum").html((index + 1));
					});
					
					//全选按钮绑定事件
					$(document).on("change", "#allselect", function() {
						$.each($("#ul_song_check .song_check"), function() {
							$(this).prop("checked", $("#allselect").prop("checked"));
						});
						$(document).on("change", "#ul_song_check .song_check", function() {
							if($(this).prop("checked") == false) {
								$("#allselect").prop("checked", false);
							}
							var all = $(":checkbox[class=song_check]").length;
							var some = $(":checkbox[class=song_check]:checked").length;
							if(all == some) {
								$("#allselect").prop("checked", true);
							}
						});
					});
					
					//鼠标悬浮改边背景颜色
					$("#ul_song_check li").mouseover(function() {
						$(this).css("background","rgb(221,221,221,0.5)");
					});
					$("#ul_song_check li").mouseout(function() {
						$(this).css("background", "white");
					});
					
					//给 《播放全部》 按钮添加事件
					$("#playAll").on("click", function() {
						var songIdStrings = getSongIds("all");
						console.log("我要播放全部歌曲---" + songIdStrings);
						addListAndPlay(songIdStrings, "addListAndPlay");
						$(this).unbind("click");
					});
					
					//给 《播放选中》 按钮添加事件
					$("#playSome").on("click", function() {
						
						//获取选择歌曲对应的字符串信息
						var songIdStrings = getSongIds("some");
						if(songIdStrings == null || songIdStrings == ""){
							alert("请选择歌曲");
						}else{
							console.log("我要播放选中歌曲" + songIdStrings);
							addListAndPlay(songIdStrings, "addList");
							$(this).unbind("click");
						}
						
					});
					
					//分享按钮绑定事件
					$(document).on("click", ".sharesong", function(event) {
						x = event.clientX;
						y = event.clientY;
						console.log("x:" + x + " y:" + y);
						$("#sharediv").css({
							"display": "block"
						});
					});
					//body绑定全局事件
					$('body').bind('click', function(event) {
						// IE支持 event.srcElement ， FF支持 event.target    
						var evt = event.srcElement ? event.srcElement : event.target;
						if(evt.id == 'sharesong') return; // 如果是元素本身，则返回
						else {
							$('#sharediv').hide(); // 如不是则隐藏元素
						}
					});
					//回车键绑定事件
					$(document).keypress(function(e) {
						var eCode = e.keyCode;
						if(eCode == 13) {
							$("#subsearch").click();
						}
					});
				}
				
				//获取搜索排行榜，并追加
				function getSearchHot(){
					//获取搜索排行版
					var num = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];
					$.ajax({
						url: "../getSearchHot.action",
						data: {
							"searchmsg": "searchhot"
						},
						contextType: "application/json;charset=utf-8",
						type: "post",
						dataType: "json",
						success: function(pageData) {
							console.log(pageData);
							$.each(pageData, function(index, search) {
								/* console.log(search.searchContent); */
								$("#searchHot").append("<li ><span class='topnum1'>"+num[index]+"</span><a class='topnumfont' href='search.jsp?msg="+search.searchContent+"'>"+search.searchContent+"</a></li>");
							});
							$(".topnum1:lt(3)").css({
								"color": "#f48a34"
							});
							$(".topnumfont:lt(3)").css({
								"color": "#f48a34"
							});
						}
					});
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
				
				//根据搜索框的文本信息获取歌曲列表
				function getSongList(msg){
					$.ajax({
						url: "../getSongBySearch.action",
						data: {
							"searchmsg": msg
						},
						contextType: "application/json;charset=utf-8",
						type: "post",
						dataType: "json",
						success: function(pageData) {
							console.log("追加页面数据")
							console.log(pageData)
							//页面追加数据
							showdata(pageData);
						}
					});
				}
				
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
							console.log("length=" + length);
							console.log(operation);
							console.log(operation == "addListAndPlay");
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
				
				
				
				
				//获取搜索排行榜
				console.log("获取搜索表单追加")
				getSearchHot();
				
				//根据msg获取歌曲列表
				var msg = decodeURI(getQueryString("msg"));
				if(msg != null && msg != "") {
					$("#chKey").prop("value", msg);
					getSongList(msg);
				}
				
				//搜索按钮绑定事件
				$(document).on("click", "#subsearch", function() {
					console.log("点击搜索");
					//移除原有的歌曲列表
					$("#ul_song_check li").remove();
					console.log($("#chKey").val());
					getSongList($("#chKey").val());
				});
			});
		</script>
	</head>

	<body>
		<!-- 进行分享的设置 -->
		<%-- <input type="hidden" id="hiddenvalue" value="<%=request.getParameter(" msg ")%>" /> --%>
	<!-- 头部 开始 -->
	<div id="top" style="height: 55px;">
		<object style="border: 0px" type="text/x-scriptlet" data="head.jsp" width="100%" height="100%"></object>
	</div>
	<!-- 头部 结束 -->
	<!-- 内容开始 -->
	<div id="container">
		<div id="content">
			<div class="w1000 clearfix">
				<div class="wrapper clearfix">
					<div class="searchbox">
						<input type="text" class="txt" name="key" id="chKey" /> 
						<input id="subsearch" type="button" class="submit" value="搜索" />
						<div id="sharediv" style="position:fixed;top :50%; left:38%; padding-left:20px; height:40px; width: 140px;  border:5px solid #f4f4f4; display:none;">
							<div class="bdsharebuttonbox">
								<a class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
								<a class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
								<a class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
								<a class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
							</div>
							<script>
								window._bd_share_config = {
									"common": {
										"bdText": "",
										"bdMiniList": false,
										"bdStyle": "1",
										"bdSize": "24"
									},
									"share": {},
									"selectShare": {
										"bdContainerClass": null,
										"bdSelectMiniList": ["qzone", "tsina", "tqq",
											"renren"
										]
									}
								};
								with(document)
								0[(getElementsByTagName('head')[0] || body)
									.appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' +
									~(-new Date() / 36e5)];
							</script>
						</div>
					</div>
					<div class="tabs">
						<ul class="clearfix">
							<li>
								<a class="current">歌曲</a>
							</li>
						</ul>
					</div>
					<!-- 相关歌曲 begin -->
					<div class="mainwrap fl">
						<div class="m_list clearfix">
							<h1 class="title">
								&nbsp;相关歌曲<span id="showNum">0</span>首
							</h1>
							<div class="top">
								<p class="fl">
									<input id="allselect" type="checkbox"  />全选
								</p>
								<p class="fl" style="margin-left: 20px; display: inline;"></p>
								<p class="fr">
									<a title="全部播放" id="playAll" style="cursor:pointer">播放全部</a> 
									<a title="播放选中 " id="playSome" style="cursor:pointer">播放选中</a>
								</p>
							</div>
							<div class="list">
								<dl class="clearfix ">
									<dd class="m_name ">歌曲名称</dd>
									<dd class="s_name " style="margin-left: 80px; ">歌手</dd>
									<dd class="share " style="margin-left: 150px; ">分享</dd>
									<dd class="down " style="margin-left: 50px; ">下载</dd>
								</dl>
								<ul id="ul_song_check">
									<!-- <li>歌曲列表</li> -->
								</ul>
							</div>
						</div>
					</div>
					<!-- 相关歌曲 end -->
					<!-- 搜索排行榜 开始 -->
					<div class="sider fl ">
						<div class="searchRank">
							<h1 class="title">搜索排行榜</h1>
							<ul id="searchHot">
								<!-- 
								<li>
									<span class="topnum1">1</span>
									<a class="topnumfont">测试列</a>
								</li> 
								-->
							</ul>
						</div>
					</div>
					<!-- 搜索排行榜 结束 -->
				</div>
			</div>
		</div>
	</div>
	<!-- 内容 结束 -->
	<!-- 底部开始 -->
	<div id="bottom " style="height: 270px; ">
		<object style="border: 0px " type="text/x-scriptlet " data="bottom.jsp " width="100% " height="100% "></object>
	</div>
	<!-- 底部结束 -->
</body>

</html>