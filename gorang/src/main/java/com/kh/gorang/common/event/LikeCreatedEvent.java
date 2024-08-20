package com.kh.gorang.common.event;


import com.kh.gorang.member.model.dto.LikeDtoForNotify;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class LikeCreatedEvent {
	private LikeDtoForNotify like;
	private int boardWriterNo;
	private int recipeWriterNo;
	private int likeType;
}
