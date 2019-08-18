package com.music.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.bean.PlayList;
import com.music.bean.Song;
import com.music.bean.Users;
import com.music.dao.SongDao;
/***
 * 播放列表 service
 * @author user
 * @date 2019/03/31
 */
@Service
public class PlayListService {
	@Resource
	private SongDao songDao;

	static List<PlayList> playListList = new ArrayList<PlayList>();

	/**
	 * 获取当前用户的播放列表大小
	 * @param user
	 * @return
	 */
	public Integer getOriginalLength(Users user) {
		if(playListList.size() != 0 ) {
			// 判断播放列表集合是否存在该用户
			for (PlayList playList : playListList) {
				if(playList.getUser() == null) {
					return 0;
				}
				if (playList.getUser().getUsersId().equals(user.getUsersId())) {
					// 存在该用户，获取该用户播放列表大小
					return playList.getSongList().size();
				}
			}
		}
		return 0;

	}

	/**
	 *  根据传入的用户信息和集合信息往播放列表中加入数据
	 * @param user
	 * @param songIds
	 */
	public void addList(Users user, String songIds) {
		System.out.println("播放列表集合的大小为：" + playListList.size());
		String songIds2 ;
		if((songIds.charAt(songIds.length()-1)) == '/') {
			songIds2 = songIds.substring(0, songIds.length() - 1);
		}else {
			songIds2 = songIds;
		}
		
		String[] songIdArr = songIds2.split("/");
		//去除数组中重复的值
		List<Integer> songIdList = new ArrayList<>();
		for(String s : songIdArr ) {
			Integer id = Integer.parseInt(s);
			if(!songIdList.contains(id)) {
				songIdList.add(id);
			}
		}
		
		
		// 判断播放集合里面是否存在该用户
		boolean flag = false;
		
		for (PlayList playList : playListList) {
			if (user.getUsersId() == playList.getUser().getUsersId()) {
			    // 播放列表集合存在用户信息，获取用户的播放列表
				List<Song> songList = playList.getSongList();
				// 遍历传入的歌曲id数组
				for (Integer id : songIdList) {
					// 遍历播放列表中的数据
					boolean flag1 = false;
					for (int j = 0; j < songList.size() ;  j++) {// 遍历原有的播放列表
						System.out.println(songList.get(j));
						if (songList.get(j).getSongId().equals(id)) {
						    // 当前歌曲和和播放列表相同的歌曲
							flag1 = true;
						}
					}
					if (!flag1) {// 即flag = false
						Song song = songDao.getOneSong(id);
						songList.add(song);
						//歌曲的播放次数+1
						songDao.updateSong(song);
					}
				}
				flag = true;
			}
		}
		
		// 播放列表集合不存在用户(创建该用户的播放列表)
		if (!flag) {
			System.out.println("用户在播放列表集合中不存在，正在创建用户的播放列表，并将当前歌曲列表加入到该用户的播放列表");
			PlayList playList = new PlayList();
			//创建新的播放列表
			List<Song> songList = new ArrayList<Song>();
			for (Integer id : songIdList) {
				Song song = songDao.getOneSong(id);
				//System.out.println(song);
				//歌曲添加到播放列表
				songList.add(song);
				//歌曲的播放次数+1
				songDao.updateSong(song);
			}
			playList.setSongList(songList);
			playList.setUser(user);
			playListList.add(playList);
		}
	}

	/**
	 * 根据用户获取播放列表
	 * @param user
	 * @return
	 */
	public List<Song> getPlayList(Users user) {
		for (PlayList playList : playListList) {
			if (user.getUsersId().equals(playList.getUser().getUsersId())) {
			    // 存在当前用户的播放列表
				if (playList.getSongList().size() == 0) {
				    // 数据为空
					return null;
				}
				return playList.getSongList();
			}
		}
		return null;
	}
	/**
	 * 根据用户和歌曲编号移除播放列表中的歌曲
	 * @param user
	 * @param songId
	 */
	public void removeSongToPlayList(Users user, String songId) {
		//获取用户的播放列表
		for(PlayList playList : playListList) {
			//查询到用户的播放列表
			if(playList.getUser().getUsersId() == user.getUsersId()) {
				List <Song> songList = playList.getSongList();
				for(Song song : songList) {
					if(song.getSongId() == Integer.parseInt(songId)) {//查询到指定的歌曲
						//播放列表移除歌曲
						playList.getSongList().remove(song);
						//System.out.println("歌曲已经移除，");
						return ;
					}
				}
			}
		}
	}
	/**
	 * 获取字符串在播放列表中的索引
	 * 贺南彬 2018年11月29日 16:29:28
	 * @param songIdStrings
	 * @return
	 */
	public int getIndex(Users user, String songIdStrings) {
		String songIds2 ;
		if((songIdStrings.charAt(songIdStrings.length()-1)) == '/') {
			//System.out.println("最后一个字符为‘/’");
			songIds2 = songIdStrings.substring(0, songIdStrings.length() - 1);
		}else {
			songIds2 = songIdStrings;
		}
		String[] songIdArr = songIds2.split("/");
		Integer id = Integer.parseInt(songIdArr[0]);
		for(PlayList playList : playListList) {
			if(user.getUsersId() == playList.getUser().getUsersId()) {
				//获取播放列表
				List<Song> songList = playList.getSongList();
				//遍历播放列表
				for(int i = 0 ; i < songList.size() ; i++) {
					if(songList.get(i).getSongId().equals(id)) {
						return i;
					}
				}
			}
		}
		return -1;
	}

}
