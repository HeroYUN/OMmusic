package com.music.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.bean.Comments;
import com.music.bean.ReplyComment;
import com.music.dao.CommentsDao;

@Service
public class CommentsService {
	@Resource
	private CommentsDao commentsDao;
	
	
	public int insertComments(Comments comments) {
		return commentsDao.insertComments(comments);
	}
	
	/**
	 * 根据歌曲id获取该歌曲的所有评论
	 * 2018年11月26日21:39:39 蓝道良
	 * @return
	 */
	public  List<Comments> getCommentsBySong(Integer songId){
		return commentsDao.getCommentsBySong(songId);
	}
	
	/**
	 * 点赞
	 * 2018年11月27日20:35:10 蓝道良
	 */
	public Integer doThumbs(Integer commentId) {
		return commentsDao.doThumbs(commentId);
	}
	
	/**
	 *回复评论
	 */
	public Integer repComment(ReplyComment rc) {
		return commentsDao.repComment(rc);
	}
	
}	
