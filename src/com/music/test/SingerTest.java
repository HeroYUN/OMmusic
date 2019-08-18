package com.music.test;

import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.music.bean.Singer;
import com.music.bean.Song;
import com.music.bean.View_AllMessage;
import com.music.dao.SingerDao;
import com.music.dao.SongDao;
import com.music.service.SingerService;
import com.music.service.SongService;


class SingerTest {
	SingerDao singerDao;
	SingerService singerService;
	
	SongDao songDao;
	
	
	@BeforeEach
	public void init() {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

		singerDao = context.getBean(SingerDao.class);
		singerService=context.getBean(SingerService.class);
		
		songDao=context.getBean(SongDao.class);
		
	}
	@Test
	void test() {
		fail("Not yet implemented");
	}
	@Test
	public void selectOneSingerInfoDao() {
		Singer singer=singerDao.getOneSinger(2);
		System.out.println(singer);
	}
	@Test
	public void selectOneSingerInfoService() {
		Singer singer=singerService.getOneSinger(2);
		System.out.println(singer);
	}
	
	//歌手所有歌曲获取
	@Test
	public void getSongBySingerDao() {
		List<Song> songList=songDao.getSongBySinger(2);
		for(Song song:songList) {
			System.out.println(song);
		}
	}
	@Test
	public void getgetSongBySingerService() {
		List<Song> songList=singerService.getSongBySinger(2);
		for(Song song:songList) {
			System.out.println(song);
		}
	}
}
