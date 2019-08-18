package com.music.dao;

import com.music.bean.Singer;
import com.music.bean.Song;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface SingerDao {
	// 删除歌手信息
	int deleteSinger(Integer id);

	// 插入歌手信息
	int insertSinger(Singer singer);

	// 获取单个歌手信息
	Singer getOneSinger(Integer id);

	// 获取所有歌手信息根据播放次数排序
	List<Singer> getAllSingerByCount();

	/**
	 * 根据歌手全部歌曲的点赞次数之和 降序排序获取歌手信息
	 * @param prevPage
	 * @param currPage
	 * @return
	 */
	List<Singer> getPageSingerByCount(
			@Param(value = "startNum") Integer startNum, 
			@Param(value = "endNum") Integer endNum);

	// 根据歌手首字母获取歌手信息
	List<Singer> getSingerByFirstName(String firstName);

	// 根据歌手类别，歌手首字母获取歌手信息
	List<Singer> getSingerBySingerTypeAndFirstNameAndSex(Integer singerTypeId, String firstName, String sex);
	
	//根据歌手类型获取歌手信息
	List<Singer> getSingerByKind(String type);
	
	
	// 更新歌手信息
	int updateSinger(Singer singer);
	// 获取所有歌手数量

	int getSingerCount();

	/**
	 * 传入对象根据对象名字进行模糊查询
	 * 
	 * @param singer
	 * @return
	 */
	List<Singer> searchSingerId(Singer singer);

}