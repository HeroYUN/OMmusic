package com.music.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.bean.Song;
import com.music.bean.View_AllMessage;
import com.music.service.SongService;

@Controller
public class SongController {
	@Resource
	private SongService songService;
	
	
	
	
	/**
	 *获取当前歌曲对应歌手的最火的六首歌
	 * 2018年11月26日13:12:16 蓝道良
	 * @return
	 */
	@RequestMapping("/sixSongBySongId")
	@ResponseBody
	public List<View_AllMessage> sixSongBySongId(Integer songId,HttpSession session) {
		//根据songId 查询出该歌曲的歌手最热的6首歌,以及歌曲的id
		//根据该歌曲，获取到相应歌手的信息
		List<View_AllMessage> sixSongsBySongId = songService.getSixSongsBySongId(songId);

		return sixSongsBySongId;
	}
	
	/**
	 *获取全系统最热的六首歌
	 * 2018年11月26日13:12:16 蓝道良
	 * @return
	 */
	@RequestMapping("/sixSong")
	@ResponseBody
	public List<View_AllMessage> sixSong(Integer songId,HttpSession session) {
		List<View_AllMessage> sixSong = songService.getSixSong();

		return sixSong;
	}
	
	/**
	 * 查询该首歌曲的基本信息
	 * 2018年11月26日21:01:52 蓝道良
	 */
	@RequestMapping("/basicMessage")
	@ResponseBody
	public Song getOneSongBySongId(Integer songId) {
		Song song = songService.getOneSong(songId);
		System.out.println("------>song = "+ song);
		return song;
	}
	
	
	
	
	
	/**
	 * 根据不同的参数获取不同的歌曲集合
	 * 2018年11月25日 20:37:27 贺南彬
	 */
	@RequestMapping("/getNewSongListBySongType")
	@ResponseBody
	public List<Song> getNewSongList(String songTypeString){
		//传入的类型编号
		List<Song> songList = songService.getNewSongList(songTypeString);
		return songList;
	}

	/**
	 * 根据歌曲类型获得歌曲信息集合
	 * @return
	 */
	@RequestMapping("/getSongByType")
	@ResponseBody
	public List<View_AllMessage> getSongByType(String songTypeString){
		//传入的类型编号
		List<View_AllMessage> songList = songService.getSongByType(songTypeString);
		return songList;
		
	
	}
	
	/**
	 * 查询单个歌手的歌曲数
	 * @return
	 */
	@RequestMapping("/selectAllSong")
	@ResponseBody
	public List<Integer> selectCount(){

		List<Integer> countList = songService.selectAllSong();

		return countList;
	}
	
	@RequestMapping("/selectAllHits")
	@ResponseBody
	public List<Integer> selectAllHits(){
		List<Integer>  hitsList = songService.selectAllHits();
		return hitsList;
	}
	
	
	/**
	 * 歌词文件的读取
	 */
	@RequestMapping("/lyric")
	@ResponseBody
	public List<String> getLyric(Integer songId,HttpServletRequest request) throws FileNotFoundException{
		//根据歌曲id查询出歌词文件
		List<String> lyricList = new ArrayList<String>();
		Song song = songService.getOneSong(songId);
		System.out.println(song.getLyric());
		String file = song.getLyric();
		//FileReader fr = null;
		InputStreamReader isStream=null;
		FileInputStream fis=null;
		BufferedReader br = null;
		
		try {
			String url = request.getSession().getServletContext().getRealPath("");
			System.out.println(url);
			fis = new FileInputStream(new File(url+"front/"+file));
			isStream = new InputStreamReader(fis,"utf-8");
			// fr = new FileReader(url+"front/"+file);
			 br = new BufferedReader(isStream);
			 String line;
			 while((line = br.readLine())!= null) {
				
					 String s1 = line.substring(10);
					 lyricList.add(s1);
					// System.out.println(s1);
				
			 }
		} catch (IOException e) {
			e.printStackTrace();
		}
		return lyricList;
	}
	
}
