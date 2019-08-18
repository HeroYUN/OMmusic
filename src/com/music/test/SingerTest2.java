package com.music.test;

import javax.annotation.Resource;


import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.music.bean.Singer;
import com.music.service.SingerService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class SingerTest2 {
	@Resource
	private SingerService singerService;
	
	@Test
	public void selectOneSingerInfoService() {
		Singer singer=singerService.getOneSinger(2);
		System.out.println(singer);
	}
}
