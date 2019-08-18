<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		<title>首页</title>
		<link rel="stylesheet" type="text/css" href="./index/reset.css">
		<link rel="stylesheet" href="./index/jquery.mCustomScrollbar.css">
		<link rel="stylesheet" href="./index/common.css">
		<link rel="stylesheet" href="./index/player.css">
		<link type="text/css" rel="stylesheet" href="./index/index.css">
		<link type="text/css" rel="stylesheet" href="./index/ugc.css">
		<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.css" />
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<script src="dist/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>

		<script type="text/javascript">
			$(function() {
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
				
				if(status == 6){
					window.location.href = "/front/index.jsp";
				}
				
				/* 歌曲数 */
				$.ajax({
					url: "../selectAllSong.action",
					contentType: "application/json;charset=utf-8",
					dataType: "json",
					type: "post",
					success: function(data) {
						 $.each(data, function(index, num) {
							$.each($(".info .num"), function(index1) {
								if(index == index1) {
									if(num == null) {
										num = 0;
									}
									$(this).append("<span class=\"share\">" + num + "</span>")
								}
							});
						});
					}
				});
				
				/* 歌曲点击量 */
				$.ajax({
					url: "../selectAllHits.action",
					contentType: "application/json;charset=utf-8",
					dataType: "json",
					type: "post",
					success: function(data) {
						 $.each(data, function(index, sum) {
							$.each($(".info .num "), function(index1) {
								if(index == index1) {
									if(sum == null) {
										sum = 0;
									}
									$(this).append("<span class=\"like\">"+sum+"</span>")
								}
							});
						});
					}
				});
				
				
			});
		</script>

	</head>

	<body avalonctrl="player">

		<!-- 头部 开始 -->
		<div id="top" style="height: 55px;">
			<object style="border:0px" type="text/x-scriptlet" data="head.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 头部 结束 -->

		<!-- 幻灯片开始 -->
		<div class="carousel slide" id="carousel-326975">
			<ol class="carousel-indicators">
				<li data-slide-to="0" data-target="#carousel-326975">
				</li>
				<li data-slide-to="1" data-target="#carousel-326975" class="active">
				</li>
				<li data-slide-to="2" data-target="#carousel-326975">
				</li>
			</ol>
			<div class="carousel-inner" data-ride="carousel">
				<div class="item">
					<img  src="index/1542423362435_.jpg" class="bgImg" />
				</div>
				<div class="item active">
					<img  src="index/1542351105448_.jpg" class="bgImg" />
				</div>
				<div class="item">
					<img  src="index/1476867184096_.jpg" class="bgImg" />
				</div>
			</div>
			<a class="left carousel-control" href="#carousel-326975" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#carousel-326975" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
		<!-- 幻灯片 结束 -->

		<!-- 内容区域开始 -->
		<div id="content">
			<div id="conBanner">
				<div class="conBanner">
					<div class="conBox">
						<a  title="因为遇见你-王源" href="music-detail.jsp?songId=38">
							<img width="579" height="320" src="./index/wangyuan.jpg">
						</a>
						<a  title="稻香-周杰伦" href="music-detail.jsp?songId=63">
							<img width="579" height="320" src="./index/daodao.jpg">
						</a>
					</div>
				</div>
			</div>
			<!-- 歌单 开始 -->
			<div id="song" class="list">
				<div class="title_">
					<h2>歌单</h2>
				</div>
				<ul>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=9">
								<img width="220" height="220" src="./index/1461561898863_.jpg">
							</a>
						</div>
						<span class="name"><a >每日推荐单曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=10">
								<img width="220" height="220" src="./index/1455342310364_132026710b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=10">每日热门单曲</a> </span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=1">
								<img width="220" height="220" src="./index/1455592122915_132026710b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=1">每日最新网络单曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=2">
								<img width="220" height="220" src="./index/1453967239975_185766193b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=2">每日最新DJ舞曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=3">
								<img width="220" height="220" src="./index/1444623850992_185766193b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=3">每日最新伤感情歌</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=4">
								<img width="220" height="220" src="./index/1452244369390_185766193b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=4">每日最新影视单曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=5">
								<img width="220" height="220" src="./index/1437030245804_185766193b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=5">每日最新KTV舞曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=6">
								<img width="220" height="220" src="./index/1435275959597_141050697b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=6">每日最新民谣单曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=7">
								<img width="220" height="220" src="./index/1432971445330_141050697b.jpg">
							</a>						</div>
						<span class="name"><a href="songList.jsp?songTypeString=7">每日最新欧美单曲</a></span>
					</li>
					<li>
						<div class="cover">
							<a href="songList.jsp?songTypeString=8">
								<img width="220" height="220" src="./index/1432544148941_141050697b.jpg">
							</a>
						</div>
						<span class="name"><a href="songList.jsp?songTypeString=8">每日最新日韩单曲</a></span>
					</li>
				</ul>
			</div>
			<!-- 歌单 结束 -->
			
			<!-- 歌手 开始 -->
			<div id="singer" class="list">
				<div class="title_">
					<h2>歌手</h2>
					<a href="singer.jsp">查看更多</a>
				</div>
				<ul>
					<li>
						<a href="../singerInfo.actioon?singerId=15">
							<img src="./index/1525752083294_.jpg">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">周杰伦</span><span>代表作：告白气球</span>
							<div id="onestar" class="num">
							</div>
						</div>
					</li>

					<li>
						<a href="../singerInfo.actioon?singerId=17">
							<img src="./index/1542100509950_.jpg" data-src="http://img3.kwcdn.kuwo.cn/star/upload/14/14/1542100509950_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;">
							<span class="name">Eminem</span>
							<span>代表作：Without Me</span>
							<div class="num">
							</div>
						</div>
						
					</li>
					
					<li>
						<a href="../singerInfo.actioon?singerId=5">
							<img src="./index/1541041795306_.jpg" data-src="http://img4.kwcdn.kuwo.cn/star/upload/10/10/1541041795306_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">林俊杰</span><span>代表作：不能说的秘密</span>
							<div class="num">
							</div>
						</div>
						
					</li>
					
					<li>
						<a href="../singerInfo.actioon?singerId=3">
							<img src="./index/1540277452876_.jpg" data-src="http://img4.kwcdn.kuwo.cn/star/upload/12/12/1540277452876_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">陈奕迅</span><span>代表作：破坏王</span>
							<div class="num">
							</div>
						</div>
						
					</li>
					
					<li>
						<a href="../singerInfo.actioon?singerId=6">
							<img src="./index/1542100398806_.jpg" data-src="http://img2.kwcdn.kuwo.cn/star/upload/6/6/1542100398806_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">王嘉尔</span><span>代表作：Papillon</span>
							<div class="num">
							</div>
						</div>
					</li>

					<li>
						<a href="../singerInfo.actioon?singerId=10">
							<img src="./index/1541041878778_.jpg" data-src="http://img4.kwcdn.kuwo.cn/star/upload/10/10/1541041878778_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">吴亦凡</span><span>代表作：Coupe(feat. rich the kid)</span>
							<div class="num">
							</div>
						</div>
						<div class="songListSplice opacity70" style="display: none;"></div>

					</li>
						
					<li>
						<a href="../singerInfo.actioon?singerId=18">
						<img src="http://img3.kwcdn.kuwo.cn/star/upload/6/6/1553658872150_.jpg" data-src="http://img3.kwcdn.kuwo.cn/star/upload/6/6/1553658872150_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">邓紫棋</span><span>代表作：泡沫</span>
							<div class="num">
							</div>
						</div>
					</li>
					
					<li>
						<a href="../singerInfo.actioon?singerId=9">
							<img src="./index/1532435849635_.jpg" data-src="http://img3.kwcdn.kuwo.cn/star/upload/3/3/1532435849635_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">王源</span><span>代表作：The Wrong Things</span>
							<div class="num">
							</div>
						</div>
						
					</li>


					<li>
						<a href="../singerInfo.actioon?singerId=7">
						<img src="./index/1535459088095_.jpg" data-src="http://img4.kwcdn.kuwo.cn/star/upload/15/15/1535459088095_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">王俊凯</span><span>代表作：树读</span>
							<div class="num">
							</div>
						</div>
						
					</li>
					
					<li>
						<a href="../singerInfo.actioon?singerId=14">
							<img src="./index/1539082528346_.jpg" data-src="http://img4.kwcdn.kuwo.cn/star/upload/10/10/1539082528346_.jpg" class="lazyLoad" onerror="imgOnError(this,&#39;singer&#39;)">
						</a>
						<div class="infoSplice opacity70" style="display: block;"></div>
						<div class="info" style="display: block;"><span class="name">张艺兴</span><span>代表作：SHEEP</span>
							<div class="num">
							</div>
						</div>
					</li>

				</ul>
			</div>
			<!-- 歌手 结束 -->
		</div>
		<!-- 内容区域结束 -->

		<!-- 底部开始 -->
		<div id="bottom" style="height: 270px;">
			<object style="border:0px" type="text/x-scriptlet" data="bottom.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 底部结束 -->
	</body>

</html>