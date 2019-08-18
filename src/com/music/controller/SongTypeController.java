package com.music.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.bean.SongType;
import com.music.service.SongTypeService;

@Controller
public class SongTypeController {
	@Resource
	private SongTypeService songTypeService;
	
	@RequestMapping("/allSongType")
	@ResponseBody
	public List<SongType> selectAllSongType(){
		List<SongType> songTypeList = songTypeService.selectAllSongType();
		return songTypeList;
	}
}
