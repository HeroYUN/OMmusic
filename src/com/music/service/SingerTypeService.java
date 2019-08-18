package com.music.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.dao.SingerTypeDao;

@Service
public class SingerTypeService {
	@Resource
	private SingerTypeDao singerTypeDao;
}
