<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
[@seo type = "productSearch"]
	<title>[#if seo.title??][@seo.title?interpret /][/#if]</title>
	
	
	[#if seo.keywords??]
		<meta name="keywords" content="[@seo.keywords?interpret /]" />
	[/#if]
	[#if seo.description??]
		<meta name="description" content="[@seo.description?interpret /]" />
	[/#if]
[/@seo]
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/goods.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">

$().ready(function() {

	var $headerCart = $("#headerCart");
	var $compareBar = $("#compareBar");
	var $compareForm = $("#compareBar form");
	var $compareSubmit = $("#compareBar a.submit");
	var $clearCompare = $("#compareBar a.clear");
	var $goodsForm = $("#goodsForm");
	var $orderType = $("#orderType");
	var $pageNumber = $("#pageNumber");
	var $pageSize = $("#pageSize");
	var $gridType = $("#gridType");
	var $listType = $("#listType");
	var $size = $("#layout a.size");
	var $previousPage = $("#previousPage");
	var $nextPage = $("#nextPage");
	var $sort = $("#sort a, #sort li");
	var $orderMenu = $("#orderMenu");
	var $startPrice = $("#startPrice");
	var $endPrice = $("#endPrice");
	var $result = $("#result");
	var $productImage = $("#result img");
	var $addCart = $("#result a.addCart");
	var $exchange = $("#result a.exchange");
	var $addFavorite = $("#result a.addFavorite");
	var $addCompare = $("#result a.addCompare");
	
	var layoutType = getCookie("layoutType");
	if (layoutType == "listType") {
		$listType.addClass("currentList");
		$result.removeClass("grid").addClass("list");
	} else {
		$gridType.addClass("currentGrid");
		$result.removeClass("list").addClass("grid");
	}
	
	$gridType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentGrid")) {
			$this.addClass("currentGrid");
			$listType.removeClass("currentList");
			$result.removeClass("list").addClass("grid");
			addCookie("layoutType", "gridType");
		}
		return false;
	});
	
	$listType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentList")) {
			$this.addClass("currentList");
			$gridType.removeClass("currentGrid");
			$result.removeClass("grid").addClass("list");
			addCookie("layoutType", "listType");
		}
		return false;
	});
	
	$size.click(function() {
		var $this = $(this);
		$pageNumber.val(1);
		$pageSize.val($this.attr("pageSize"));
		$goodsForm.submit();
		return false;
	});
	
	$previousPage.click(function() {
		$pageNumber.val(0);
		$goodsForm.submit();
		return false;
	});
	
	$nextPage.click(function() {
		$pageNumber.val(2);
		$goodsForm.submit();
		return false;
	});
	
	$orderMenu.hover(
		function() {
			$(this).children("ul").show();
		}, function() {
			$(this).children("ul").hide();
		}
	);
	
	$sort.click(function() {
		var $this = $(this);
		if ($this.hasClass("current")) {
			$orderType.val("");
		} else {
			$orderType.val($this.attr("orderType"));
		}
		$pageNumber.val(1);
		$goodsForm.submit();
		return false;
	});
	
	$startPrice.add($endPrice).focus(function() {
		$(this).siblings("button").show();
	});
	
	$startPrice.add($endPrice).keypress(function(event) {
		return (event.which >= 48 && event.which <= 57) || (event.which == 46 && $(this).val().indexOf(".") < 0) || event.which == 8 || event.which == 13;
	});
	
	$goodsForm.submit(function() {
		if ($orderType.val() == "" || $orderType.val() == "topDesc") {
			$orderType.prop("disabled", true);
		}
		if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
			$pageNumber.prop("disabled", true);
		}
		if ($pageSize.val() == "" || $pageSize.val() == "20") {
			$pageSize.prop("disabled", true);
		}
		if ($startPrice.val() == "" || !/^\d+(\.\d+)?$/.test($startPrice.val())) {
			$startPrice.prop("disabled", true);
		}
		if ($endPrice.val() == "" || !/^\d+(\.\d+)?$/.test($endPrice.val())) {
			$endPrice.prop("disabled", true);
		}
		if ($goodsForm.serializeArray().length < 1) {
			location.href = location.pathname;
			return false;
		}
	});
	
	$productImage.lazyload({
		threshold: 100,
		effect: "fadeIn"
	});
	
	// 加入购物车
	$addCart.click(function() {
		var $this = $(this);
		var productId = $this.attr("productId");
		$.ajax({
			url: "/cart/add.jhtml",
			type: "POST",
			data: {productId: productId, quantity: 1},
			dataType: "json",
			cache: false,
			success: function(message) {
				if (message.type == "success" && $headerCart.size() > 0 && window.XMLHttpRequest) {
					var $image = $this.closest("li").find("img");
					var cartOffset = $headerCart.offset();
					var imageOffset = $image.offset();
					$image.clone().css({
						width: 170,
						height: 170,
						position: "absolute",
						"z-index": 20,
						top: imageOffset.top,
						left: imageOffset.left,
						opacity: 0.8,
						border: "1px solid #dddddd",
						"background-color": "#eeeeee"
					}).appendTo("body").animate({
						width: 30,
						height: 30,
						top: cartOffset.top,
						left: cartOffset.left,
						opacity: 0.2
					}, 1000, function() {
						$(this).remove();
					});
				}
				$.message(message);
			}
		});
		return false;
	});
	
	// 积分兑换
	$exchange.click(function() {
		var productId = $(this).attr("productId");
		$.ajax({
			url: "/order/check_exchange.jhtml",
			type: "GET",
			data: {productId: productId, quantity: 1},
			dataType: "json",
			cache: false,
			success: function(message) {
				if (message.type == "success") {
					location.href = "/order/checkout.jhtml?type=exchange&productId=" + productId + "&quantity=1";
				} else {
					$.message(message);
				}
			}
		});
		return false;
	});
	
	// 添加商品收藏
	$addFavorite.click(function() {
		var goodsId = $(this).attr("goodsId");
		$.ajax({
			url: "/member/favorite/add.jhtml",
			type: "POST",
			data: {goodsId: goodsId},
			dataType: "json",
			cache: false,
			success: function(message) {
				$.message(message);
			}
		});
		return false;
	});
	
	// 对比栏
	var compareGoods = getCookie("compareGoods");
	var compareGoodsIds = compareGoods != null ? compareGoods.split(",") : [];
	if (compareGoodsIds.length > 0) {
		$.ajax({
			url: "/goods/compare_bar.jhtml",
			type: "GET",
			data: {goodsIds: compareGoodsIds},
			dataType: "json",
			cache: true,
			success: function(data) {
				$.each(data, function (i, item) {
					var thumbnail = item.thumbnail != null ? item.thumbnail : "/upload/image/default_thumbnail.jpg";
					$compareBar.find("dt").after(
'<dd> <input type="hidden" name="goodsIds" value="' + item.id + '" \/> <a href="' + escapeHtml(item.url) + '" target="_blank"> <img src="' + escapeHtml(thumbnail) + '" \/> <span title="' + escapeHtml(item.name) + '">' + escapeHtml(abbreviate(item.name, 50)) + '<\/span> <\/a> <strong>' + currency(item.price, true) + '<del>' + currency(item.marketPrice, true) + '<\/del><\/strong> <a href="javascript:;" class="remove" goodsId="' + item.id + '">[删除]<\/a> <\/dd>'					);
				});
				$compareBar.fadeIn();
			}
		});
		
		$.each(compareGoodsIds, function(i, goodsId) { 
			$addCompare.filter("[goodsId='" + goodsId + "']").addClass("selected");
		});
	}
	
	// 移除对比
	$compareBar.on("click", "a.remove", function() {
		var $this = $(this);
		var goodsId = $this.attr("goodsId");
		$this.closest("dd").remove();
		for (var i = 0; i < compareGoodsIds.length; i ++) {
			if (compareGoodsIds[i] == goodsId) {
				compareGoodsIds.splice(i, 1);
				break;
			}
		}
		$addCompare.filter("[goodsId='" + goodsId + "']").removeClass("selected");
		if (compareGoodsIds.length == 0) {
			$compareBar.fadeOut();
			removeCookie("compareGoods");
		} else {
			addCookie("compareGoods", compareGoodsIds.join(","));
		}
		return false;
	});
	
	$compareSubmit.click(function() {
		if (compareGoodsIds.length < 2) {
			$.message("warn", "至少需要两个对比商品");
			return false;
		}
		
		$compareForm.submit();
		return false;
	});
	
	// 清除对比
	$clearCompare.click(function() {
		$addCompare.removeClass("selected");
		$compareBar.fadeOut().find("dd:not(.action)").remove();
		compareGoodsIds = [];
		removeCookie("compareGoods");
		return false;
	});
	
	// 添加对比
	$addCompare.click(function() {
		var $this = $(this);
		var goodsId = $this.attr("goodsId");
		if ($.inArray(goodsId, compareGoodsIds) >= 0) {
			return false;
		}
		if (compareGoodsIds.length >= 4) {
			$.message("warn", "最多只允许添加4个对比商品");
			return false;
		}
		$.ajax({
			url: "/goods/add_compare.jhtml",
			type: "GET",
			data: {goodsId: goodsId},
			dataType: "json",
			cache: false,
			success: function(data) {
				if (data.message.type == "success") {
					$this.addClass("selected");
					var thumbnail = data.thumbnail != null ? data.thumbnail : "/upload/image/default_thumbnail.jpg";
					$compareBar.show().find("dd.action").before(
'<dd> <input type="hidden" name="goodsIds" value="' + data.id + '" \/> <a href="' + escapeHtml(data.url) + '" target="_blank"> <img src="' + escapeHtml(thumbnail) + '" \/> <span title="' + escapeHtml(data.name) + '">' + escapeHtml(abbreviate(data.name, 50)) + '<\/span> <\/a> <strong>' + currency(data.price, true) + '<del>' + currency(data.marketPrice, true) + '<\/del><\/strong> <a href="javascript:;" class="remove" goodsId="' + data.id + '">[删除]<\/a> <\/dd>'					);
					compareGoodsIds.unshift(goodsId);
					addCookie("compareGoods", compareGoodsIds.join(","));
				} else {
					$.message(data.message);
				}
			}
		});
		return false;
	});
	
	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$goodsForm.submit();
		return false;
	}

});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container goodsList">
		<div class="row">
			<div class="span2">
				<div class="hotProductCategory">
				[@product_category_root_list]
					[#list productCategories as category]
					<dl [#if category_index%2!=0] class="even clearfix"[/#if]>
						<dt>
							<a href="${base}${category.path}">${category.name}</a>
						</dt>
						[@product_category_children_list productCategoryId = category.id count = 4]
							[#list productCategories as productCategory]
							<dd>
								<a href="${base}${productCategory.path}">${productCategory.name}</a>
							</dd>
							[/#list]
						[/@product_category_children_list]
					</dl>
					[/#list]
				[/@product_category_root_list]
				</div>
				<div class="hotGoods">
					<dl>
						<dt>${message("shop.product.hotProduct")}</dt>
							[#if productCategory??]
							[@product_list productCategoryId = productCategory.id count = 5 orderBy="monthSales desc"]
								[#list products as product]
								<dd>
									<a href="${base}${product.path}" title="${product.name}">
										<img src="${base}${product.image}" alt="${product.name}">
										<span title="${product.name}">${abbreviate(product.name, 30)}</span>
									</a>
									<strong>
										${currency(product.price, true, true)}
											<del>${product.monthSales}</del>
									</strong>
								</dd>
								[/#list]
								[/@product_list]
								[#else]
								[@product_list count = 5 orderBy="monthSales desc"]
								[#if product.scoreCount > 0]
									<dd>
										<a href="${base}${product.path}" title="${product.name}">
											<img src="${base}${product.image}" alt="${product.name}">
											<span title="${product.name}">${abbreviate(product.name, 30)}</span>
										</a>
										<strong>
											${currency(product.price, true, true)}
												<del>${product.monthSales}</del>
										</strong>
									</dd>
								[/#if]
						 		[/@product_list]
								[/#if]
					</dl>
				</div>
			</div>
			<div class="span10">
				<div class="breadcrumb">
					<ul>
						<li>
							<a href="${base}/">${message("shop.path.home")}</a>
						</li>
						<li class="last">${message("shop.product.path", productKeyword)}</li>
					</ul>
				</div>
				<form id="productForm" action="${base}/product/search.jhtml" method="get">
					<input type="hidden" id="keyword" name="keyword" value="${productKeyword}" />
					<input type="hidden" id="orderType" name="orderType" value="${orderType}" />
					<input type="hidden" id="pageNumber" name="pageNumber" value="${page.pageNumber}" />
					<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize}" />
					<div class="bar">
						<div id="layout" class="layout">
							<label>${message("shop.product.layout")}:</label>
							<a href="javascript:;" id="tableType" class="tableType">
								<span>&nbsp;</span>
							</a>
							<a href="javascript:;" id="listType" class="listType">
								<span>&nbsp;</span>
							</a>
							<label>${message("shop.product.pageSize")}:</label>
							<a href="javascript:;" class="size[#if page.pageSize == 20] current[/#if]" pageSize="20">
								<span>20</span>
							</a>
							<a href="javascript:;" class="size[#if page.pageSize == 40] current[/#if]" pageSize="40">
								<span>40</span>
							</a>
							<a href="javascript:;" class="size[#if page.pageSize == 80] current[/#if]" pageSize="80">
								<span>80</span>
							</a>
							<span class="page">
								<label>${message("shop.product.totalCount", page.total)} ${page.pageNumber}/[#if page.totalPages > 0]${page.totalPages}[#else]1[/#if]</label>
								[#if page.totalPages > 0]
									[#if page.pageNumber != 1]
										<a href="javascript:;" id="previousPage" class="previousPage">
											<span>${message("shop.product.previousPage")}</span>
										</a>
									[/#if]
									[#if page.pageNumber != page.totalPages]
										<a href="javascript:;" id="nextPage" class="nextPage">
											<span>${message("shop.product.nextPage")}</span>
										</a>
									[/#if]
								[/#if]
							</span>
						</div>
						<div id="sort" class="sort">
							<a href="javascript:;"[#if orderType == "priceAsc"] class="currentAsc current" title="${message("shop.product.cancel")}"[#else] class="asc"[/#if] orderType="priceAsc">${message("shop.product.priceAsc")}</a>
							<a href="javascript:;"[#if orderType == "salesDesc"] class="currentDesc current" title="${message("shop.product.cancel")}"[#else] class="desc"[/#if] orderType="salesDesc">${message("shop.product.salesDesc")}</a>
							<a href="javascript:;"[#if orderType == "scoreDesc"] class="currentDesc current" title="${message("shop.product.cancel")}"[#else] class="desc"[/#if] orderType="scoreDesc">${message("shop.product.scoreDesc")}</a>
							<input type="text" id="startPrice" name="startPrice" class="startPrice" value="${startPrice}" maxlength="16" title="${message("shop.product.startPrice")}" onpaste="return false" />
						    <label>-</label>
							<input type="text" id="endPrice" name="endPrice" class="endPrice" value="${endPrice}" maxlength="16" title="${message("shop.product.endPrice")}" onpaste="return false" />
						 	<button type="submit">${message("shop.product.submit")}</button>
						</div>
					</div>
					<div id="result" class="result table clearfix">
						[#if page.content?has_content]
							<ul>
								[#list page.content?chunk(4) as row]
									[#list row as product]
										<li[#if !row_has_next] class="last"[/#if]>
											<a href="${base}${product.path}">
												<img src="${base}/upload/image/blank.gif" width="170" height="170" data-original="[#if product.thumbnail??]${product.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" />
												<span class="price">
													${currency(product.price, true)}
													[#if setting.isShowMarketPrice]
														<del>${currency(product.marketPrice, true)}</del>
													[/#if]
												</span>
												<span title="${product.name}">${abbreviate(product.name, 60)}</span>
											</a>
										</li>
									[/#list]
								[/#list]
							</ul>
						[#else]
							${message("shop.product.noSearchResult", productKeyword)}
						[/#if]
					</div>
					[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "javascript: $.pageSkip({pageNumber});"]
						[#include "/shop/include/pagination.ftl"]
					[/@pagination]
				</form>
			</div>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>