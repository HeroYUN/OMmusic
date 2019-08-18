package com.music.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.bean.Song;
import com.music.bean.View_AllMessage;
import com.music.dao.SongDao;

@Service
public class SongService {
	@Resource
	private SongDao songDao;

	/**
	 * 根据歌曲类型获得榜单信息
	 * @return
	 */
	public List<View_AllMessage> getSongByType(String songTypeString){
		Integer songTypeId = Integer.parseInt(songTypeString);
		return songDao.getSongByType(songTypeId);
	}

	/**
	 * 根据歌曲id 获得歌曲，歌手的信息
	 * @param songId
	 * @return
	 */
	public Song getOneSong(Integer songId) {
		return songDao.getOneSong(songId);
	}
	/**
	 * 根据传入的类别获取最新的歌曲集合
	 * 2018年11月25日 21:13:56 贺南彬
	 */
	public List<Song> getNewSongList(String songTypeString) {
		Integer songTypeid = Integer.parseInt(songTypeString);
		List<Song> songList = songDao.getNewSongListBySongType(songTypeid);
		return songList;
	}
	
	/**
	 * 根据歌曲id查询出所有的歌曲中的六笔最热歌曲
	 * 2018年11月26日12:46:15 蓝道良
	 */
	
	public List<View_AllMessage> getSixSongsBySongId(Integer songId){
		return songDao.selectSixSongsBySongId(songId);
	}
	
	/**
	 * 查询出所有的歌曲中的六笔最热歌曲
	 * 2018年11月26日12:46:15 蓝道良
	 */
	public List<View_AllMessage> getSixSong(){
		return songDao.selectSixSong();
	}
	
	/**
	 * 查询歌手的总歌曲量
	 * @return
	 */
	public List<Integer> selectAllSong(){
		//Integer songTypeId = Integer.parseInt(songTypeString);
		return songDao.selectAllSong();
	}
	
	/**
	 * 查询歌手所有歌曲的总点击数
	 * @return
	 */
	public List<Integer> selectAllHits(){
		//Integer songTypeId = Integer.parseInt(songTypeString);
		return songDao.selectAllHits();
	}
	
	
	public int insertSongMsg(Song song){
		return songDao.insertSongMsg(song);
	}
	
	/**
	 * 修改歌曲信息
	 * @param string
	 */
    public Integer updateSong(Song song) {
        return this.songDao.updateSong1(song);
    }

    public List<Song> findList() {
         return songDao.findList();
    }
	
}
