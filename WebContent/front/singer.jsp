<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		<link href="" type="image/x-icon" rel="shortcut icon">
		<style type="text/css">
			#test-tip {
				font-size: 0.3rem;
				height: 30px;
				background-color: red;
				color: white;
				font-weight: bolder;
				position: fixed;
				width: 100%;
				z-index: 99;
				text-align: center;
				line-height: 30px;
				top: 0;
			}
		</style>
		<title>歌手分类</title>
		<link rel="stylesheet" type="text/css" href="./singer_files/reset.css">
		<link rel="stylesheet" href="./singer_files/jquery.mCustomScrollbar.css">
		<link rel="stylesheet" href="./singer_files/common.css">
		<link rel="stylesheet" href="./singer_files/player.css">
		<link rel="stylesheet" type="text/css" href="./singer_files/artist.css">
		<link type="text/css" rel="stylesheet" href="./singer_files/ugc.css">
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<script type="text/javascript">
		
			$(document).ready(function() {
				//分页实现
				//页面加载获取歌手
				remen();
				//---------------------------------------------字母搜索歌曲开始-----------------------------
				function remen() {
					$.ajax({
						url: "../pageSingerByCount.action",
						data: {
							"currPage": 1
						},
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						type: "get",
						success: function(data) {
							//console.log('------------------')
							//console.log(data);
							showSingerList(data);
						}
					});
					//上一页
					$(document).on("click", ".noprev", function() {

						$.ajax({
							url: "../pageSingerByCount.action",
							data: {
								"currPage": $("a.current").text() - 1
							},
							contentType: "application/json;charset=utf-8",
							type: "get",
							dataType: "json",
							success: function(data) {
								showSingerList(data);
							}

						});
					});
					//下一页
					$(document).on("click", ".next", function() {

						$.ajax({
							url: "../pageSingerByCount.action",
							data: {
								"currPage": eval($("a.current").text() + "+1")
							},
							contentType: "application/json;charset=utf-8",
							type: "get",
							dataType: "json",
							success: function(data) {
								showSingerList(data);
							}

						});
					});
					//选中页
					$(document).on("click", ".currPageNo", function() {

						$.ajax({
							url: "../pageSingerByCount.action",
							data: {

								"currPage": $(this).text()
							},
							contentType: "application/json;charset=utf-8",
							type: "get",
							dataType: "json",
							success: function(data) {
								showSingerList(data);
							}

						});
					});

				}
				// ----------------------------------------------字母搜索歌手结束----------------
				
				//---------------------显示某个歌手的热歌-------------
				function showSingerList(data) {
					$("#page").css("cursor", "pointer")
					$("#artistList ul li").remove();
					$("#page a").remove();
					$.each(data.list, function(index, singer) {
						
						//添加热歌
						$("#artistList ul").append('<li><div class="artistTop"><a href="../singerInfo.action?singerId=' + singer.singerId + '" class="artistLeft fl"><img src="' + singer.picture + '"><span class="splice"></span></a><div class="artistRight fr"><div class="artistnav" data-id="336"><a  class="title active">热歌</a></div><ol class="hotlist' + index + '"></ol></div></div><a href="" class="a_name">' + singer.singerName + '</a></li>');
						//根据歌手id获得歌曲  singer.singerId
						$.ajax({
							type: "get",
							url: "../songBySingerByCount.action",
							data: {
								singerId: singer.singerId
							},
							contentType: "application/json;charset=utf-8",
							dataType: "json",
							success: function(data) {

								$.each(data, function(index1, song) {
									/*console.log("*********************"+song.songId)*/
									$(".hotlist" + index).append('<li style="clear: both;width: auto;height: 28px;line-height: 28px;margin: 0;font-size: 12px;"><a href="music-detail.jsp?songId=' + song.songId + '" >' + (index1 + 1) + '.' + song.songName + '</a></li>');
								})
							}
						});
					})
					//分页
					$("#page").append('<a  class="noprev"><img src="../front/singerInfo_files/prev.png"></a>');

					for(var i = 1; i <= data.allPage; i++) {

						if(data.currPage == i) {
							$("#page").append('<a class="current currPageNo" id="">' + i + '</a>');
						} else {
							$("#page").append('<a class="currPageNo" id="currPageNo">' + i + '</a>');
						}

					}

					$("#page").append('<a class="next"><img src="../front/singerInfo_files/next.png"></a>');
				}
				//----------------------------显示热歌结束
				
				//热门歌曲的点击事件
				$("#remen").click(function() {
					remen();

				});
			})
		</script>
	</head>

	<body avalonctrl="player">
		<!-- 头部 开始 -->
		<div id="top" style="height: 55px;">
			<object style="border:0px" type="text/x-scriptlet" data="head.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 头部 结束 -->
		<!-- 内容 开始 -->
		<div id="artistContent" class="comW" data-catid="0" data-letter="">
			<div class="leftNav fl">
				<span class="activeline" style="top: 18px; display: inline;"></span>
				<a data-index="0" class="all active">全部歌手</a>
				<dl class="area">
					<dt>
       			 		<span>华语歌手</span>
     				 </dt>
					<dd>
						<a id="kind1" href="javascript:">华语男歌手</a>
					</dd>
					<dd>
						<a id="kind2" href="javascript:">华语女歌手</a>
					</dd>
					<dd>
						<a id="kind3" href="javascript:">华语组合</a>
					</dd>
				</dl>
				<dl class="area">
					<dt>
        				<span>日韩歌手</span>
      				</dt>
					<dd>
						<a id="kind4" href="javascript:">日韩男歌手</a>
					</dd>
					<dd>
						<a id="kind5" href="javascript:">日韩女歌手</a>
					</dd>
					<dd>
						<a id="kind6" href="javascript:">日韩组合</a>
					</dd>
				</dl>
				<dl class="area" style="border:none;">
					<dt>
        				<span>欧美歌手</span>
      				</dt>
					<dd>
						<a id="kind7" href="javascript:">欧美男歌手</a>
					</dd>
					<dd>
						<a id="kind8" href="javascript:">欧美女歌手</a>
					</dd>
					<dd>
						<a id="kind9" href="javascript:">欧美组合</a>
					</dd>
				</dl>
			</div>

			<div class="rightContentBox fr">
				<!-- 字母 查询 start -->
				<div class="topSelect">
					<a href="javascript:void(0)" class="hot fl active" id="remen">热门</a>
					<a href="javascript:void(0)" class="select ">A</a>
					<a href="javascript:void(0)" class="select ">B</a>
					<a href="javascript:void(0)" class="select ">C</a>
					<a href="javascript:void(0)" class="select ">D</a>
					<a href="javascript:void(0)" class="select ">E</a>
					<a href="javascript:void(0)" class="select ">F</a>
					<a href="javascript:void(0)" class="select ">G</a>
					<a href="javascript:void(0)" class="select ">H</a>
					<a href="javascript:void(0)" class="select ">I</a>
					<a href="javascript:void(0)" class="select ">J</a>
					<a href="javascript:void(0)" class="select ">K</a>
					<a href="javascript:void(0)" class="select ">L</a>
					<a href="javascript:void(0)" class="select ">M</a>
					<a href="javascript:void(0)" class="select ">N</a>
					<a href="javascript:void(0)" class="select ">O</a>
					<a href="javascript:void(0)" class="select ">P</a>
					<a href="javascript:void(0)" class="select ">Q</a>
					<a href="javascript:void(0)" class="select ">R</a>
					<a href="javascript:void(0)" class="select ">S</a>
					<a href="javascript:void(0)" class="select ">T</a>
					<a href="javascript:void(0)" class="select ">U</a>
					<a href="javascript:void(0)" class="select ">V</a>
					<a href="javascript:void(0)" class="select ">W</a>
					<a href="javascript:void(0)" class="select ">X</a>
					<a href="javascript:void(0)" class="select ">Y</a>
					<a href="javascript:void(0)" class="select ">Z</a>
					<a href="javascript:void(0)" class="select ">#</a>
				</div>
				
				<!--根据首字母分类开始-->
				<script>
					$(document).ready(function() {
						
						$(".topSelect a").each(function() {
							$(this).click(function() {
								$("#page a").remove();
								console.log("111111112222222")
								$("#artistList ul li").remove();
								console.log($(this).text())
								$.ajax({
									url: "../singerByFirstName.action",
									data: {
										firstName: $(this).text()
									},
									contentType: "application/json;charset=utf-8",
									dataType: "json",
									type: "get",
									success: function(data) {

										$.each(data, function(index, singer) {

											$("#artistList ul").append('<li><div class="artistTop"><a href="../singerInfo.action?singerId=' + singer.singerId + '" class="artistLeft fl"><img src="' + singer.picture + '"><span class="splice"></span></a><div class="artistRight fr"><div class="artistnav" data-id="336"><a href="javascript:;" class="title active">热歌</a></div><ol class="hotlist' + index + '"></ol></div></div><a href="" class="a_name">' + singer.singerName + '</a></li>');
											//根据歌手id获得歌曲  singer.singerId
											$.ajax({
												type: "get",
												url: "../songBySingerByCount.action",
												data: {
													singerId: singer.singerId
												},
												contentType: "application/json;charset=utf-8",
												dataType: "json",
												success: function(data) {

													$.each(data, function(index1, song) {

														$(".hotlist" + index).append('<li style="clear: both;width: auto;height: 28px;line-height: 28px;margin: 0;font-size: 12px;"><a href="music-detail.jsp?songId=' + song.songId + '" target="_blank">' + (index1 + 1) + '.' + song.songName + '</a></li>');
													})
												}
											});
										})

									}
								});
							})

						})

					})
				</script>
				<!--根据首字母分类结束-->
				
				<!-- 字母 查询 end -->
				<!-- 列表 start -->
				<div id="artistList">
					<ul class="artistBox">

					</ul>
					<!-- 分页 开始 -->
					<div class="page" id="page" data-page="6780" style="margin-left: 354px;">

					</div>
					<!-- 分页 结束 -->
				</div>
				<!-- 列表 end -->
			</div>
		</div>
		<!-- 内容 结束 -->
		<!-- 底部开始 -->
		<div id="bottom" style="height: 270px;">
			<object style="border:0px" type="text/x-scriptlet" data="bottom.jsp" width="100%" height="100%"></object>
		</div>
		<!-- 底部结束 -->
	</body>

</html>