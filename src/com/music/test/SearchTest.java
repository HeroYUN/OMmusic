package com.music.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.music.bean.Singer;
import com.music.bean.Song;
import com.music.dao.SingerDao;
import com.music.dao.SongDao;
import com.music.service.SearchService;

public class SearchTest {
	ApplicationContext context;
	
	@BeforeEach
	public void init() {
		context = new ClassPathXmlApplicationContext("applicationContext.xml");
		
	}
	
	@Test
	public void searchTest() {
		SearchService searchService=context.getBean(SearchService.class);
		String searchmsg="心";
		List<Song> songs= searchService.getSongListByLike(searchmsg);
		System.out.println(songs);
	}
	
/*	@Test
	public void searchDaoTest() {
		SingerDao singerDao=context.getBean(SingerDao.class);
		Singer singer=new Singer();
		singer.setName("庄心妍");
		Singer songs= (Singer) singerDao.searchSingerId(singer);
		System.out.println(songs);
	}*/
	
	
/*	@Test
	public void searchDaoTest1() {
		SongDao songDao=context.getBean(SongDao.class);
		List<Song> songs= songDao.searchSongById(2);
		System.out.println(songs);
	}*/
	
	@Test
	public void StrTest() {
		/*String newstr="file:/C:/Program%20Files/Apache%20Software%20Foundation/Tomcat%208.0/wtpwebapps/OMmusic/WEB-INF/classes/";
		String url1=newstr.substring(6);
		System.out.println(url1);
		int iw=newstr.indexOf("W");
		System.out.println("index:"+iw);
		String url2=newstr.substring(6, 88);
		System.out.println(url2);*/
		/*Map<Integer,String> themap=new HashMap<Integer,String>();
		themap.put(1, "ceshi1");
		themap.put(2, "ceshi2");
		themap.put(3, "ceshi3");
		
		   for(Integer mapPath:themap.keySet())
	        {C:/Program%20Files/Apache%20Software%20Foundation/Tomcat%208.0/wtpwebapps/OMmusic/
	         System.out.println("Key: "+mapPath+" Value: "+themap.get(mapPath));
	        }*/
	     String str="C:/Program%20Files/Apache%20Software%20Foundation/Tomcat%208.0/wtpwebapps/OMmusic/WEB-INF/classes/";   
	     System.out.println("可能成功的字符串："+str.substring(0,(str.length()-16)));
		
		
	}
	
}	
