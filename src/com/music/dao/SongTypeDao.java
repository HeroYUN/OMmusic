package com.music.dao;

import com.music.bean.SongType;
import java.math.BigDecimal;
import java.util.List;

public interface SongTypeDao {
	//获取全部的歌曲类别信息
	List<SongType> getAllSongType();
}