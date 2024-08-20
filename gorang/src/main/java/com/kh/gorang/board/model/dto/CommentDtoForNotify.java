package com.kh.gorang.board.model.dto;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommentDtoForNotify {
	private int commentNo;
	private String content;
	private int boardNo;
	private Date commentDate;
}
