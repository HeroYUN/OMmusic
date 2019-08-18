package com.music.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.bean.Comments;
import com.music.bean.ReplyComment;
import com.music.bean.Users;
import com.music.service.CommentsService;
import com.music.service.ReplyCommentService;

@Controller
public class CommentsController {
	@Resource
	private CommentsService commentsService;
	@Resource
	private ReplyCommentService replyCommentService;
	
	
	/**
	 * 新增评论
	 * @param content
	 * @param session
	 */
	@RequestMapping(value="/addComments",method=RequestMethod.POST)
	@ResponseBody
	public Integer addComments(@RequestBody String content,Integer songId,HttpSession session) {
		Comments comment = new Comments();
		//获取系统日期
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		String date = sdf.format(d);
		
		//用户id
		Users user = (Users) (session.getAttribute("user"));
		//System.out.println("content="+content+",songId="+songId);
		comment.setCommentsContent(content.substring(1));
		comment.setCommentsTime(date);
		comment.setSongid(songId);
		comment.setUserid(user.getUsersId());
		//插入评论信息
		int num = commentsService.insertComments(comment);
		//return songId;
		return num;
	}

	
	/**
	 * 查询全部评论
	 */
	@RequestMapping("/showAllComment")
	@ResponseBody
	public List<Comments> showAllComment(Integer songId) {
		
		List<Comments> commentsList = commentsService.getCommentsBySong(songId);
		for(Comments c:commentsList) {
			System.out.println("------> c = "+c);
		}
		
		return commentsList;
	}
	
	/**
	 * 点赞
	 * 2018年11月27日20:33:09 蓝道良
	 * @return
	 */
	@RequestMapping("/thumbs")
	@ResponseBody
	public Integer doThumbs(Integer commentId) {
		
		commentsService.doThumbs(commentId);
		
		return 1;
	}
	
	/**
	 * 回复评论
	 */
	@RequestMapping("/repComment")
	@ResponseBody
	public Integer repComment(Integer commentId,String repComment,HttpSession session) {
		ReplyComment rc = new ReplyComment();
		
		//获取当前用户的id
		/*Users user = (Users) session.getAttribute("user");*/
		Users user = new Users();
		user.setUsersId(1);
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		rc.setrTime(sdf.format(new Date()));
		rc.setCommentsid(commentId);
		rc.setUsersid(user.getUsersId());
		rc.setrContent(repComment);
		
		return commentsService.repComment(rc);
	}
	
	
}
