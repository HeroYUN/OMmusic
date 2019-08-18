package com.music.dao;

import java.util.List;

import com.music.bean.Comments;
import com.music.bean.ReplyComment;

public interface CommentsDao {
	// 删除评论
	int deleteComments(Integer id);

	// 插入评论
	int insertComments(Comments comments);

	/***
	 * 获取对应歌曲的评论信息
	 * @param songId
	 * @return
	 */
	List<Comments> getCommentsBySong(Integer songId);

	// 获取指定用户的评论信息
	List<Comments> getCommentsByUser(Integer userId);
	
	//点赞
	Integer doThumbs(Integer commentId);
		
	//回复评论
	Integer repComment(ReplyComment rc);
}