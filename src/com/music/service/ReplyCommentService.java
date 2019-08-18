package com.music.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.bean.ReplyComment;
import com.music.dao.ReplyCommentDao;

@Service
public class ReplyCommentService {
	@Resource
	private ReplyCommentDao replyCommentDao;
	/**
	 * 根据传入的回复评论信息，插入数据
	 * 贺南彬 2018年11月30日 09:32:29
	 */
	public int insertReplyComment(ReplyComment replyComment) {
		replyCommentDao.insertReplyComment(replyComment);
		return 0;
	}
}
