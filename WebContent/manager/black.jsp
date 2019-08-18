<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<meta charset="utf-8" />
<title></title>
<meta name="description"
	content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
<link rel="stylesheet" href="css/font.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/scrollBar.css" />
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>

<script type="text/javascript">
	$(function() {

		$.ajax({
			url : "../allSingerByCount",
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			type : "post",
			success : function(data) {
				console.log(data);
				$.each(data, function(index, singer) {
					$("#singername").append(
							"<option value=\""+singer.singerId+"\">"
									+ singer.singerName + "</option>")
				});
			}
		});

		
		$.ajax({
			url : "../allSongType",
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			type : "post",
			success : function(data) {
				console.log(data);
				$.each(data, function(index, songType) {
					$("#songtype").append(
							"<option value='"+songType.songTypeId+"'>"
									+ songType.songTypeName + "</option>")
				});
			}
		});
		
	});
	
</script>

</head>
<body>
<!--    action="../upSong.action" -->
	<form   action="../upSong.action"  method="post" enctype="multipart/form-data">

		<div>
			<table border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td>歌曲名:</td>
					<td><input type="text" name="songName" id="songName" /></td>
				</tr>
				<tr>
					<td>音频文件:</td>
					<td><input type="file" name="upsongFile" /></td>
				</tr>
				<tr>
					<td>歌词:</td>
					<td><input type="file" name="upsongFile" /></td>
				</tr>
				<tr>
					<td>歌手：</td>
					<td><select id="singername" name="singerid">
							<option value="">请选择</option>
					</select></td>
				</tr>
				<tr>
					<td>歌曲类型：</td>
					<td><select id="songtype" name="songTypeid">
							<option>请选择</option>
					</select></td>
				</tr>
				<!-- <tr>
					<td>时间：</td>
					<td><input type="text" name="releaseTime" id="releaseTime" /></td>
				</tr> -->
				<tr>
					<td colspan="2" align="center">
					<input type="submit" value="上传" id="upload" /></td>
				</tr>
			</table>
		</div>
	</form>
	<div>${msg}</div>
</body>

</html>