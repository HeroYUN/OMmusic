package com.music.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.bean.Song;
import com.music.bean.Users;
import com.music.service.PlayListService;

@Controller
public class PlayListController {
    @Resource
    private PlayListService playListService;

    /**
     * 获取前端界面传入的歌曲列表,添加到用户的播放列表
     * 
     * @param songIdStrings
     * @param reqeust
     * @return
     */
    @RequestMapping("/addListAndPlay")
    @ResponseBody
    public String playList(String songIdStrings, HttpServletRequest reqeust) {

        System.out.println("添加到播放列表并播放");
        System.out.println("songIdStrings=" + songIdStrings);
        Users user = (Users)reqeust.getSession().getAttribute("user");
        System.out.println("user======================" + user);
        
        if(user == null) {
            System.out.println("------>用户为空，创建默认用户！");
            user = new Users();
            user.setUsersId(1);
        }
        
        // 获取之前播放列表的长度
        int originalLength = playListService.getOriginalLength(user);

        // 根据前端界面的歌曲id字符串添加歌曲到用户的播放列表
        playListService.addList(user, songIdStrings);

        
        int newLength = playListService.getOriginalLength(user);
        // System.out.println("原先播放列表的长度为： " + newLength);
        if (originalLength == newLength) {
            // 获取新的播放列表在播放列表的索引
            System.out.println("user======================" + user);
            int length = playListService.getIndex(user, songIdStrings);
            if (length != -1) {
                return length + "";
            }
        }
        // 重新加载play.jsp界面
        return originalLength + "";

    }

    /**
     * 加载用户的播放列表
     * 
     * @param content
     * @param reqeust
     * @return
     */
    @RequestMapping(value = "/loadPlay", method = RequestMethod.POST)
    @ResponseBody
    public List<Song> loadPlay(HttpServletRequest reqeust) {
        Users user = (Users)reqeust.getSession().getAttribute("user");
        if(user == null) {
            System.out.println("------>用户为空，创建默认用户！");
            user = new Users();
            user.setUsersId(1);
        }
        
        // 根据用户获取播放列表信息
        List<Song> songList = playListService.getPlayList(user);
        if (songList == null || songList.size() == 0) {
            return null;
        }
        return songList;
    }

    /**
     * 将歌曲从用户播放列表移除
     * 
     * @param songId
     * @param request
     * @return
     */
    @RequestMapping(value = "/removeSongToPlayList", method = RequestMethod.POST)
    @ResponseBody
    public String removeSongToPlayList(String songId, HttpServletRequest request) {
        // System.out.println("songId=" + songId);
        Users user = (Users)request.getSession().getAttribute("user");
        if(user == null) {
            System.out.println("------>用户为空，创建默认用户！");
            user = new Users();
            user.setUsersId(1);
        }
        // 根据用户和编号移除
        playListService.removeSongToPlayList(user, songId);
        return songId;
    }

}
