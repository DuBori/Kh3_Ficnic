package com.kh3.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;


import com.kh3.model.member.MemberDAO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.reserv.ReservDAO;
import com.kh3.model.reserv.ReservDTO;

public class RecentList {

    @Inject
    ReservDAO rdao;

    @Inject
    static QnaDAO qdao;

    @Inject
    static MemberDAO mdao;


    public static List<Map<String, Object>> showRecent(String getType) {
        List<Map<String, Object>> list = null;

        LocalDate chkNowDate = LocalDate.now().plusDays(4L);
        String chk_date = chkNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));


        if(getType.equals("reserv")) {
//            List<ReservDTO> rlist = rdao.getRecentReservList(chk_date);
//
//            if(rlist.size() > 0) {
//                list = new ArrayList<Map<String,Object>>();
//
//                for (ReservDTO rdto : rlist) {
//                    Map<String, Object> data = new HashMap<String, Object>();
//                    data.put("no", rdto.getReserv_no());
//                    data.put("sess", rdto.getReserv_sess());
//                    data.put("title", rdto.getReserv_ficnic_name());
//                    data.put("name", rdto.getReserv_name());
//                    data.put("date", rdto.getReserv_date());
//
//                    list.add(data);
//                }
//            }

        }else if(getType.equals("qna")) {

        }else if(getType.equals("member")) {

        }


        return list;
    }
}
