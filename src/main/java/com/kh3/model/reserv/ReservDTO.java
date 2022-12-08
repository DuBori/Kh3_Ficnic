package com.kh3.model.reserv;

import lombok.Data;

@Data
public class ReservDTO {
	
	private int reserv_no;
	private String reserv_sess;
	private int ficnic_no;
	private String reserv_ficnic_name;
	private int reserv_ficnic_sale_price;
	private String reserv_ficnic_option_title;
	private int reserv_ficnic_option_price;
	private String reserv_ficnic_select_title;
	private int reserv_ficnic_select_price;
	private String reserv_ficnic_photo;
	private String reserv_ficnic_date;
	private int reserv_use_coupon;
	private int reserv_coupon_price;
	private int reserv_use_point;
	private String reserv_payment;
	private int reserv_total_price;
	private String reserv_with;
	private String member_id;
	private String reserv_name;
	private String reserv_date;
	
}
