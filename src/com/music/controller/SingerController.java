package com.music.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.bean.PageShow;
import com.music.bean.Singer;
import com.music.bean.Song;
import com.music.service.SingerService;
/**
 * 歌手 控制器
 * @author user
 * @date 2019/03/31
 */
@Controller
public class SingerController {
	@Resource
	private SingerService singerService;
	
	/**
	 * 
	 * @param model
	 * @param singerId
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/singerInfo", method=RequestMethod.GET)
	public String showSingerInfo(Model model,Integer singerId,HttpServletResponse response){
		System.out.println("singerId = "+singerId);
		Singer singer=singerService.getOneSinger(singerId);
		model.addAttribute("singer", singer);
		
		return "front/singerInfo";
	}
	/**
	 * 
	 */
	@RequestMapping(value="/songBySinger", method=RequestMethod.GET)
	@ResponseBody
	public List<Song> showSongBySinger(Integer singerId) {
		
		List<Song> songList=singerService.getSongBySinger(singerId);
		return songList;
	}
	/**
	 * 分页显示歌手的所有歌曲
	 * @param singerId
	 * @param currPage
	 * @return
	 */
	@RequestMapping(value="/pageSongBySinger", method=RequestMethod.GET)
	@ResponseBody
	public PageShow<Song> showPageSongBySinger(Integer singerId,Integer currPage) {
		PageShow<Song> page=singerService.getPageSongBySinger(singerId, currPage);
		return page;
	}
	/**
	 * 
	 * @param currPage
	 * @return
	 */
	@RequestMapping(value="/pageSingerByCount", method=RequestMethod.GET)
	@ResponseBody
	public PageShow<Singer> getAllSingerByCount(String currPage){
	    
		int currPage2=Integer.parseInt(currPage);
		PageShow<Singer> page=singerService.getAllSingerByCountPage(currPage2);

		
		return page;
		
	}
	/**
	 * 显示全部歌手根据热度   分页
	 * @return
	 */
	@RequestMapping(value="/allSingerByCount", method=RequestMethod.POST)
	@ResponseBody
	public List<Singer> getAllSingerByCount(){
		List<Singer> singerList=singerService.getAllSingerByCount();
		return singerList;
		
	}
	
	/**
	 * 根据歌手显示音乐热度前五
	 * @param singerId
	 * @return
	 */
	@RequestMapping(value="/songBySingerByCount", method=RequestMethod.GET)
	@ResponseBody
	public List<Song> getSongBySingerByCount(String singerId) {
		List<Song> songList=singerService.getSongBySingerByCount(Integer.parseInt(singerId));
		
		return songList;
	}
	/**
	 * 根据首字母查找歌手
	 * @param firstName
	 * @return
	 */
	@RequestMapping(value="/singerByFirstName",method=RequestMethod.GET)
	@ResponseBody
	public List<Singer> getSingerByFirstName(String firstName){
		List<Singer> singerList=singerService.getSingerByFirst(firstName);
		
		return singerList;
		
	}
	
	/**
	 * 
	 * @param type
	 * @return
	 */
	@RequestMapping("/singerByKind")
	@ResponseBody
	public List<Singer> getSingerByKind(String type){
		return singerService.getSingerByKind(type);
	}
	
}




