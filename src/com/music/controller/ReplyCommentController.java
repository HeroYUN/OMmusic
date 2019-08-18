package com.music.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.music.service.ReplyCommentService;

@Controller
public class ReplyCommentController {
	@Resource
	private ReplyCommentService replyCommentService;
}
