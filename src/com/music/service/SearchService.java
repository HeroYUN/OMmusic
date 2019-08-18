package com.music.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.music.bean.Search;
import com.music.bean.Singer;
import com.music.bean.Song;
import com.music.dao.SearchDao;
import com.music.dao.SingerDao;
import com.music.dao.SongDao;

@Service
public class SearchService {
	@Resource
	private SearchDao searchDao;
	@Resource
	private SingerDao singerDao;
	@Resource
	private SongDao songDao;


	public List<Song> getSongListByLike(String searchmsg){
		
		String name="%"+searchmsg+"%";
		Singer singer=new Singer();
		singer.setSingerName(name);
		Song song=new Song();
		
		List<Singer> singList= singerDao.searchSingerId(singer);
		List<Integer> ids= new ArrayList<Integer>();
		List<Song> songList=new ArrayList<Song>();
		
		
		for(Singer _s:singList) {
			ids.add(_s.getSingerId());
		}
		for(Integer _i:ids) {
			songList.addAll(songDao.searchSongById(_i));
			
		}
		song.setSongName(name);
		songList.addAll(songDao.searchSongByName(song));
		
		for(Song _s1:songList) {
			
		_s1.setSinger(singerDao.getOneSinger(_s1.getSingerid()));
			
		}
		
		modSearchBeacuseQuery(searchmsg);
		return songList;
	}
	
	public Song getOneSong(int id) {
		
		return songDao.getOneSong(id);
	}
	
	public HashMap<String,String> pathMap(int id) throws UnsupportedEncodingException{
		Song song= songDao.getOneSong(id);
//		String lyricPath="D:/eclipseWorkSpace/OMmusic/WebContent/front/"+song.getLyric();
		String strurl=Thread.currentThread().getContextClassLoader().getResource("").toString();
		String addurl=strurl.substring(6, 88);
		String addutl1=addurl.replace("%20", " ");
		String lyricPath=addutl1+"front/"+song.getLyric();
		String[] strs=song.getLyric().split("/");
		String lyricName=new String(strs[3].getBytes("UTF-8"),"iso-8859-1");
		
		String mp3Path=addutl1+"front/"+song.getMp3();
		String[] mp3Str=song.getMp3().split("/");;
		String mp3Name=new String(mp3Str[3].getBytes("UTF-8"),"iso-8859-1");
		
		System.out.println();
		
		
		Map<String ,String> pathMap=new HashMap<String,String>();
		pathMap.put(lyricName, lyricPath);
		pathMap.put(mp3Name, mp3Path);
		
		
		return (HashMap<String, String>) pathMap;
	}
	
	public void modSearchBeacuseQuery(String searchmsg) {
		
			String name=searchmsg;
			Search search = new Search();
			Search search3 = new Search();
			search.setSearchContent(name);
			
			//查询出来的就得对象
			Search search1=searchDao.getOneSearchByLike(search);
			Search search2=new Search();
			if(search1 ==null) {
				//如果查询结果为空怎新增数据
				search3.setSearchContent(searchmsg);
				search3.setSearchId(null);
				search3.setSearchCount(1);
				searchDao.addNewSearch(search3);
			}else {
				//不为空则修改
				search2.setSearchId(search1.getSearchId());
				search2.setSearchContent(search1.getSearchContent());
				search2.setSearchCount(search1.getSearchCount()+1);
				search2.setRemark(search1.getRemark());
				searchDao.updateSearchOfCount(search2);
			}
			
		
	}
	public List<Search> getHotSearch(){
		List<Search> hotList=searchDao.getHotSearch();
		return hotList;
		
	}
	
	
	
	
}
