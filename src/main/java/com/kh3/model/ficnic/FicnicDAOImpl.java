package com.kh3.model.ficnic;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class FicnicDAOImpl implements FicnicDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

	/* 피크닉 상품 리스트 출력 */
	@Override
	public List<FicnicDTO> getFicnicList() {
		return this.sqlSession.selectList("adminFicnicList");
	}
	/* 피크닉 상품 등록 */
	@Override
	public int writeFicnic(FicnicDTO dto,List<String> ficnic_imagesrc) {
		/* 이미지가 저장된 만큼 dto 설정*/
		int size = ficnic_imagesrc.size();
		for(int i=1; i<=size;i++) {
			
			switch (i) {			
			case 1:
				dto.setFicnic_photo1(ficnic_imagesrc.get(0));
				break;
			case 2:
				dto.setFicnic_photo2(ficnic_imagesrc.get(1));
				break;
			case 3:
				dto.setFicnic_photo3(ficnic_imagesrc.get(2));
				break;
			case 4:
				dto.setFicnic_photo4(ficnic_imagesrc.get(3));
				break;
			case 5:
				dto.setFicnic_photo5(ficnic_imagesrc.get(4));
				break;
			default:
				break;
			}
		}
		
		return this.sqlSession.insert("adminFicnicWrite", dto);
	}
	/* 피크닉 상품 정보 */
	@Override
	public FicnicDTO getFicnicCont(int no) {
		return this.sqlSession.selectOne("adminFicnicCont", no);
	}
	/* 피크닉 상품 수정 */
	@Override
	public int modifyFicnic(FicnicDTO dto,List<String> upload_list) {
		
		/* 이미지가 저장된 만큼 dto 설정*/
		int size = upload_list.size();
		for(int i=1; i<=size;i++) {
			switch (i) {			
				case 1:
					dto.setFicnic_photo1(upload_list.get(0));
					break;
				case 2:
					dto.setFicnic_photo2(upload_list.get(1));
					break;
				case 3:
					dto.setFicnic_photo3(upload_list.get(2));
					break;
				case 4:
					dto.setFicnic_photo4(upload_list.get(3));
					break;
				case 5:
					dto.setFicnic_photo5(upload_list.get(4));
					break;
				default:
					break;
			}
		}
		
		
		return this.sqlSession.update("adminFicnicModify", dto);
	}
	
	/* 피크닉 상품 삭제 */
	@Override
	public int deleteFicnic(int no) {
		return this.sqlSession.delete("adminFicnicDelete", no);
	}
	/* 피크닉 상품 삭제 후 번호 정렬*/
	@Override
	public void updateSeq(int no) {
		this.sqlSession.update("adminFicnicDeleteUpdate",no);	
	}
	
	/* 피크닉 상품 검색 개수*/
	@Override
	public int getListCount(Map<String, Object> map) {
		return this.sqlSession.selectOne("adminFicnicSearchCount", map);
	}
	
	/* 피크닉 검색 리스트*/
	@Override
	public List<FicnicDTO> getFicnicList(int startNo, int endNo, Map<String, Object> map) {
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		return this.sqlSession.selectList("adminFicnicSearchList",map);
	}
	/* 피크닉 데이터 존재 위치 리스트 */	
	@Override
	public List<String> getFicnicLocationList() {
		return this.sqlSession.selectList("adminFicnicLocationList");}
	/* 쿠폰 상세 내역에서 상품 정보 찾기 */
	@Override
	public String checkFicnic(String coupon_use_value) {
		return this.sqlSession.selectOne("admincheckFicnic", coupon_use_value);

	}



}