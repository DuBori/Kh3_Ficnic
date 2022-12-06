package com.kh3.model.ficnic;

import java.util.List;

public interface FicnicDAO {

	List<FicnicDTO> getFicnicList();

	FicnicDTO getFicnicCont(int ficnic_no);

}
