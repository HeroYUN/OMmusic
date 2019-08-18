package com.music.dao;

import com.music.bean.SingerType;
import java.math.BigDecimal;
import java.util.List;

public interface SingerTypeDao {
	//获取全部的歌手数据
	List<SingerType> getAllSingerType();
}