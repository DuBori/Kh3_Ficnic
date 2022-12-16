package com.kh3.model.member;

import java.util.List;
import java.util.Map;

public interface WishDAO {

	List<WishDTO> getMemberWishList(String attribute);

	int wishCancel(Map<String, Object> map);

	
}
