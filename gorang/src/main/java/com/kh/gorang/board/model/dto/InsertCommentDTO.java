package com.kh.gorang.board.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class InsertCommentDTO {
	private int commentNo;       // 자동 생성될 commentNo 필드 추가
	private int memberNo;
	private int boardNo;
	private String commentContent;
	private int refCommentNo;
}
