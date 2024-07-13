package com.kh.gorang.board.model.dto;

import lombok.Data;

@Data
public class CommentListDTO {
	private int commentNo;
	private int writerNo;
	private String commentWriter;
	private String commentWriterImg;
	private String commentContent;
	private String commentDate;
	private int refCommentNo;
}
