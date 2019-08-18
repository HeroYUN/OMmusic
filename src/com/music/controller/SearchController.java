package com.music.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.music.bean.Search;
import com.music.bean.Song;
import com.music.service.SearchService;

@Controller
public class SearchController {
	@Resource
	private SearchService searchService;
	
	@RequestMapping(value="/getSongBySearch",method=RequestMethod.POST)
	@ResponseBody
	public List<Song> getSongListBySearch(String searchmsg) {
		
		//System.out.println("控制层的ajax-----获取歌曲列表");
		//System.out.println("searchmsg="+searchmsg);
		List<Song> songList= searchService.getSongListByLike(searchmsg);
		//System.out.println("songList="+songList);
		return songList;
	}

	
		//批量文件压缩后下载
		@RequestMapping("/download")
		public ResponseEntity<byte[]> download2(HttpServletRequest request) throws IOException {
			String lrc=request.getParameter("lrc");
			String mp3=request.getParameter("mp");
			String strurl=Thread.currentThread().getContextClassLoader().getResource("").toString();
			////System.out.println("*****strurl:"+strurl);
			//str.substring(6,(str.substring(6).length()-10))
			String needUrl=strurl.substring(6);
			
			String addurl=needUrl.substring(0, (needUrl.length()-16));
			
			
			////System.out.println("需要的字符串："+addurl);
			String addutl1=addurl.replace("%20", " ");
			String lyricPath=addutl1+"front/"+lrc;
			String[] strs=lrc.split("/");
			//String lyricName=new String(strs[3].getBytes("UTF-8"),"iso-8859-1");
			String lyricName=strs[3];
			String mp3Path=addutl1+"front/"+mp3;
			String[] mp3Str=mp3.split("/");;
			//String mp3Name=new String(mp3Str[3].getBytes("UTF-8"),"iso-8859-1");
			String mp3Name=mp3Str[3];
			
			//需要压缩的文件
			List<String> list = new ArrayList<String>();
			list.add(lyricPath);
			list.add(mp3Path);
			//System.out.println("mp3Name:"+mp3Name+" mp3Path:"+mp3Path+" lyricName:"+lyricName+" lyricPath"+lyricPath);
			//压缩后的文件
			String resourcesName =mp3Name+".zip";
			
			ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(resourcesName));
			InputStream input = null;
			
			for (String str : list) {
				String name = str;
				input = new FileInputStream(new File(name));  
	            zipOut.putNextEntry(new ZipEntry(str));  
	            int temp = 0;  
	            while((temp = input.read()) != -1){  
	                zipOut.write(temp);  
	            }  
	            input.close();
			}
			zipOut.close();
			File file = new File(resourcesName);
			HttpHeaders headers = new HttpHeaders();
			headers.setContentDispositionFormData("attachment", resourcesName);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
		}

		@RequestMapping(value="/getSearchHot",method=RequestMethod.POST)
		@ResponseBody
		public List<Search> getSearchHot(){
			List<Search> hotList=searchService.getHotSearch();
			//System.out.println("hotList"+hotList);
			return hotList;
		}
	
	
}
