package com.kh.gorang.common.event;

import com.kh.gorang.board.model.dto.CommentDtoForNotify;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class CommentCreatedEvent {
	private CommentDtoForNotify comment;
	private int boardWriterNo;
}
