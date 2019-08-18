package com.music.test;

import javax.annotation.Resource;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.music.bean.Users;
import com.music.service.PlayListService;
import com.music.service.SongService;

class PlayListTest {
    @Resource
    PlayListService playListService;

    @Resource
    SongService songService;

    @BeforeEach
    public void init() {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        playListService = context.getBean(PlayListService.class);
    }

    @Test
    public void addPlayList() {
        Users user = new Users();
        user.setUsersId(2);
        System.out.println(playListService.getOriginalLength(user));
    }

    @Test
    public void updateSong() {
        System.out.println(songService.getSixSongsBySongId(12));
    }
}
