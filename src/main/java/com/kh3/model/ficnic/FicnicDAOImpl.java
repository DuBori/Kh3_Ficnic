package com.kh3.model.ficnic;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh3.model.coupon.CouponDTO;

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
	public int modifyFicnic(CouponDTO dto) {
		return this.sqlSession.update("adminFicnicModify", dto);
	}






}