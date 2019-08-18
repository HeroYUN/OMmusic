package com.music.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.bean.SongType;
import com.music.dao.SongTypeDao;

@Service
public class SongTypeService {
	@Resource
	private SongTypeDao songTypeDao;

	public List<SongType> selectAllSongType() {
		return songTypeDao.getAllSongType();
	}
}
