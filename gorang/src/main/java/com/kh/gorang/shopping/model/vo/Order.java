package com.kh.gorang.shopping.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Order {
	private int orderNo;
	private int productNo;
	private int memberNo;
	private String buyerName;
	private String buyerEmail;
	private String buyerPhone;
	private String recipientName;
	private String recipientAddress;
	private String recipientPhone;
	private String requirements;
	private String totalPrice;
	private String paymentType;
	private Date orderDate;
	private Date arrivalDate;
	private String status;
}