package com.music.test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.music.bean.Song;
import com.music.bean.View_AllMessage;
import com.music.service.SongService;

class SongTest {
	private SongService songService;
	
	@BeforeEach
	public void init() {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		songService = context.getBean(SongService.class);
	}
	
	
	@Test
	public void testSong() {
		Song song = songService.getOneSong(21);
		System.out.println(song);
	}
	 
	@Test
	public void updateSong() {
	    try {
	        List<Song> songList = songService.findList();
	        System.out.println("---"+songList.size());
	        for (Song song : songList) {
	            Thread.sleep(1000);
	            System.out.println("-----"+song);
	            
	            song.setReleaseTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
	            songService.updateSong(song);
	        }
            
        } catch (Exception e) {
            e.printStackTrace();
        }

	}
	
	
	@Test
	public void testSongList() {
		List<View_AllMessage> messageList = songService.getSixSong();
		for(View_AllMessage v :messageList) {
			System.out.println(v);
		}
	}
	
}
