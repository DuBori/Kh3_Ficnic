<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="time" value="<%=System.currentTimeMillis()%>" />
<!DOCTYPE html>
<html class="noscroll">
<head>
    <meta charset="UTF-8">
    <title>파이널 프로젝트</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no, user-scalable=no">

    <meta name="robots" content="noindex">

    <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/site/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="<%=request.getContextPath()%>/resources/site/images/favicon.ico" type="image/x-icon" />
 
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/site/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="<%=request.getContextPath()%>/resources/site/images/favicon_57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/resources/site/images/favicon_72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/resources/site/images/favicon_114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/resources/site/images/favicon_144x144.png" />

    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/bootstrap-reboot.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/bootstrap-utilities.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/bootstrap-grid.min.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/font_awesome.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/simple-line-icons.css" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/css_common.css?${time}" />
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/site/css/css_layout.css?${time}" />

    <script language="javascript" src="<%=request.getContextPath()%>/resources/site/js/jquery-3.5.1.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/resources/site/js/jquery-ui.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/resources/site/js/bootstrap.min.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/resources/site/js/bootstrap.bundle.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/resources/site/js/js_common.js?${time}"></script>
</head>
<body>
    <!-- #preloader //START -->
    <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- #preloader //END -->


    <div align="center">
        <h2>메인페이지</h2>
    </div>
</body>
</html>