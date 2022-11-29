<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="time" value="<%=System.currentTimeMillis()%>" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html class="noscroll">
<head>
    <meta charset="UTF-8">
    <title>관리자</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no, user-scalable=no">

    <meta name="robots" content="noindex">

    <link rel="shortcut icon" href="${path}/resources/admin/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="${path}/resources/admin/images/favicon.ico" type="image/x-icon" />
 
    <link rel="shortcut icon" type="image/x-icon" href="${path}/resources/admin/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="${path}/resources/admin/images/favicon_57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${path}/resources/admin/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${path}/resources/admin/images/favicon_114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${path}/resources/admin/images/favicon_144x144.png" />


    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-reboot.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-utilities.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/bootstrap-grid.min.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/font_awesome.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/simple-line-icons.css" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/css_common.css?${time}" />
    <link type="text/css" rel="stylesheet" href="${path}/resources/admin/css/css_layout.css?${time}" />


    <script language="javascript" src="${path}/resources/admin/js/jquery-3.5.1.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/jquery-ui.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/bootstrap.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/bootstrap.bundle.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/Sortable.min.js"></script>
    <script language="javascript" src="${path}/resources/admin/js/js_common.js?${time}"></script>
</head>
<body>
    <!-- #preloader //START -->
    <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- #preloader //END -->


    <!-- 로그아웃 Modal // START -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body text-center py-5">
                    <p>로그아웃 하시겠습니까?</p>
                    <p>&nbsp;</p>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">창닫기</button>
                    <button type="button" class="btn btn-primary ml-2" onclick="location.href='#';">로그아웃</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 로그아웃 Modal // END -->



    <!-- #header // START -->
    <header id="header">
        <div class="navbar-header w1280">
            <div class="d-flex">
                <h1 class="h-logo"><a href="${path}/admin/main.do"><img src="${path}/resources/admin/images/admin_logo.png" alt="Ficnic" /> 관리자 모드</a></h1>
                <button type="button" class="btn btn-lg px-3 font-size-16 d-lg-none header-item waves-effect waves-light" data-toggle="collapse" data-target="#topnav-menu-content"><i class="fa fa-fw fa-bars"></i></button>
            </div>

            <ul class="d-flex">
                <!-- 발주 알림창//START -->
                <li>
                    <button type="button" id="alarm-btn-order" class="h-ico" title="발주 알림창"><span class="badge bg-primary">2</span><i class="fa fa-clipboard"></i></button>
                    <div class="new-pop order">
                        <div class="np-title">신규 발주목록 <button type="button"><i class="fa fa-times"></i></button></div>
                        <ul class="np-list">
                            <li>
                                <a href="#">
                                    <div class="npl-kind">
                                        <i class="fa fa-lightbulb-o"></i>
                                        <p>일반결제</p>
                                    </div>
                                    <div class="npl-info">
                                        <p class="subject">예쁜언니 KF94 대형 화이트 마스크 50매 외 2개의 상품</p>
                                        <p class="writer">법인며엉1</p>
                                        <p class="date">2022.04.17 22:57:17</p>
                                    </div>
                                </a>
                            </li>
                            <li class="nodata">확인하지 않은 발주 목록이 없습니다.</li>
                        </ul>
                    </div>
                </li>
                <!-- 발주 알림창//END -->


                <!-- CS 알림창//START -->
                <li>
                    <button type="button" id="alarm-btn-cs" class="h-ico" title="CS 알림창"><span class="badge bg-danger">0</span><i class="fa fa-comments-o"></i></button>
                    <div class="new-pop cs">
                        <div class="np-title">신규 CS목록 <button type="button"><i class="fa fa-times"></i></button></div>
                        <ul class="np-list">
                            <li>
                                <a href="#">
                                    <div class="npl-kind"><?=$cs_list["alarm_cate"]?></div>
                                    <div class="npl-info">
                                        <p class="subject"><?=$cs_list["alarm_subject"]?></p>
                                        <p class="writer"><?=$cs_list["alarm_writer"]?></p>
                                        <p class="date"><?=$cs_list["alarm_date"]?></p>
                                    </div>
                                </a>
                            </li>
                            <li class="nodata">확인하지 않은 CS 목록이 없습니다.</li>
                        </ul>
                    </div>
                </li>
                <!-- CS 알림창//END -->


                <!-- 미승인회원 알림창//START -->
                <li>
                    <button type="button" id="alarm-btn-member" class="h-ico" title="미승인회원 알림창"><span class="badge bg-success">0</span><i class="fa fa-user"></i></button>
                    <div class="new-pop member">
                        <div class="np-title">회원 알림 <button type="button"><i class="fa fa-times"></i></button></div>
                        <ul class="np-list">
                            <li>
                                <a href="#">
                                    <div class="npl-kind"><?=$member_list["alarm_cate"]?></div>
                                    <div class="npl-info">
                                        <p class="subject"><?=$member_list["alarm_writer"]?></p>
                                        <p class="date"><?=$member_list["alarm_date"]?></p>
                                    </div>
                                </a>
                            </li>
                            <li class="nodata">확인하지 않은 회원 알림 목록이 없습니다.</li>
                        </ul>
                    </div>
                </li>
                <!-- 미승인회원 알림창//END -->

                <li>
                    <button type="button" class="h-ico" title="로그아웃" data-toggle="modal" data-target="#logoutModal"><i class="fa fa-power-off"></i></button>
                </li>
            </ul>
        </div>



        <nav class="navbar navbar-expand-lg w1280">
            <div id="topnav-menu-content" class="navbar-collapse collapse">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link" id="order_menu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-laptop"></i> 발주관리<div class="arrow-down"></div></a>
                        <div class="dropdown-menu" aria-labelledby="order_menu">
                            <a href="#" class="dropdown-item"><div class="arrow-right"></div> 발주 목록</a>
                        </div>
                    </li>

                </ul>
            </div>
        </nav>
    </header>
    <!-- #header // END -->



    <!-- #container // START -->
    <main id="container">
        <div class="w1280">
