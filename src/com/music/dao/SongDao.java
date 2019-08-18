package com.music.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.music.bean.Song;
import com.music.bean.View_AllMessage;

public interface SongDao {
	//删除歌曲信息
    int deleteSong(Integer id);

    /**
     * 根据歌曲编号获取歌曲信息
     * @param id
     * @return
     */
    Song getOneSong(Integer id);

    /***
     * 修改歌曲信息
     * @param song
     * @return
     */
    int updateSong(Song song);

    //根据播放次数（热度）获取全部歌曲信息
    List<View_AllMessage> getSongByType(Integer songTypeId);
    
    //根据上架时间获取歌曲信息
    List<View_AllMessage> getSongByTime();
    
    //根据类别获取歌曲信息
    List<Song> getSongBySongType(Integer songTypeId);
    
    //根据歌手获取歌曲信息
    List<Song> getSongBySinger(Integer singerId);
    //分页查询
    //多个参数用注解指定
    
    
    List<Song> getPageSongBySinger(
        @Param("singerId")Integer singerId,
    	@Param("startNum")int startNum,
    	@Param("endNum")int endNum);
    
    
    
    
    //获取单个歌手所有歌曲的笔数
    int getSongCount(Integer singerId);
   /**
    * 插入歌曲信息
    * @param song
    * @return
    */
    int insertSongMsg(Song song);
    
    //根据歌手id查询歌手热度前五
    List<Song> getSongBySingerByCount(Integer singerTypeId);
  
    /**
     * 获取华语歌曲榜
     * @return
     */
    List<View_AllMessage> getSongBySingertypeName();
    
    /**
     * 根据歌手id查询歌曲对象
     * @param id
     * @return
     */
    List<Song> searchSongById(Integer id);
    
    /**
     * 传入对象根据对象的歌曲名字查询对象集合
     * @param song
     * @return
     */
    List<Song> searchSongByName(Song song);
    

    /**
     * 查询所有歌曲中最热的六首歌曲歌名，歌手名
     * 2018年11月26日12:50:11 蓝道良
     */
    List<View_AllMessage> selectSixSong();
    
    /**
     * 查询歌手的歌曲数量
     * @return
     */
    List<Integer> selectAllSong();
    
    /**
     * 查询歌手所有歌曲的总点击数
     * @return
     */
    List<Integer> selectAllHits();
    
    /**
     * 获取歌曲类型
     * @return
     */
    List<String> selectAllSongType();

    /**
     * 查询歌单中的最新歌曲信息
     * 2018年11月25日 21:03:33 贺南彬
     */
	List<Song> getNewSongListBySongType(Integer songTypeid);

    /**
     * 根据歌曲的id查询出最热的六首歌的歌名，歌手名
     * 2018年11月26日12:54:17 蓝道良
     */
    List<View_AllMessage> selectSixSongsBySongId(Integer songId);
    
    
    Integer updateSong1(Song song);

    List<Song> findList();
    
    


}