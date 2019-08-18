package com.music.bean;

import java.util.List;

public class PlayList {
	private Users user;
	private List<Song> songList;
	
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public List<Song> getSongList() {
		return songList;
	}
	public void setSongList(List<Song> songList) {
		this.songList = songList;
	}
	@Override
	public String toString() {
		return "PlayList [user=" + user + ", songList=" + songList + "]";
	}
	
	
}
