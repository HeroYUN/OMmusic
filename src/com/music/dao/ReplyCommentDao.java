package com.music.dao;

import com.music.bean.ReplyComment;
import java.math.BigDecimal;
import java.util.List;

public interface ReplyCommentDao {

	// 删除回复评论
	int deleteReplyComment(Integer id);

	// 插入回复评论
	int insertReplyComment(ReplyComment replyComment);

	// 查询指定评论的回复评论信息
	List<ReplyComment> getReplyCommentByComment(Integer commentsId);
}