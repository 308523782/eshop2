<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
[@seo type = "index"]
	<title>[#if seo.title??][@seo.title?interpret /][#else]${message("shop.index.title")}[/#if]</title>
	
	
	[#if seo.keywords??]
		<meta name="keywords" content="[@seo.keywords?interpret /]" />
	[/#if]
	[#if seo.description??]
		<meta name="description" content="[@seo.description?interpret /]" />
	[/#if]
[/@seo]
<link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />
<link href="${base}/resources/shop/slider/slider.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/slider/slider.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<style type="text/css">
.header {
	margin-bottom: 0px;
}
</style>

<script type="text/javascript">
$().ready(function() {

	var $productCategoryMenuItem = $("#productCategoryMenu li");
	var $slider = $("#slider");
	var $newArticleTab = $("#newArticle ul.tab");
	var $hotGoodsImage = $("div.hotGoods img");
	
	$productCategoryMenuItem.hover(
		function() {
			$(this).children("div.menu").show();
		}, function() {
			$(this).children("div.menu").hide();
		}
	);
	
	$slider.nivoSlider({
		effect: "random",
		animSpeed: 1000,
		pauseTime: 6000,
		controlNav: true,
		keyboardNav: false,
		captionOpacity: 0.4
	});
	
	$newArticleTab.tabs("ul.tabContent", {
		tabs: "li",
		event: "mouseover"
	});
	
	$hotGoodsImage.lazyload({
		threshold: 100,
		effect: "fadeIn",
		skip_invisible: false
	});

});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container index">
	<div class="row">
		<div class="span2">
			<div id="productCategoryMenu" class="productCategoryMenu">
				<ul>
				[@product_category_root_list]
					[#list productCategories as category]
					<li>
						<div class="item">
							<div>
								<a href="${base}${category.path}">
								<strong>${category.name}</strong>
								</a>
							</div>
						</div>
						[@product_category_children_list productCategoryId = category.id count = 7]
							<div class="menu" style="display: none;">
								[#list productCategories as productCategory]
									[#if productCategory.grade ==1]
									<dl class="clearfix">
										<dt>
											<a href="${base}${productCategory.path}">${base}${productCategory.name}</a>
										</dt>
										[@product_category_children_list productCategoryId = productCategory.id count = 4]
										[#list productCategories as productChildrenCategory]
											<dd>
												<a href="${productChildrenCategory.path}">${productChildrenCategory.name}</a>|
											</dd>
										[/#list]	
										[/@product_category_children_list]
									</dl>
									[/#if]
								[/#list]	
							</div>
						[/@product_category_children_list]
					</li>
					[/#list]
				[/@product_category_root_list]
				</ul>
			</div>
		</div>
			<div class="span10">
				<!-- 首页轮播广告 -->
				[@ad_position id = 3/]
			</div>
			</div>
		<div class="row">
			<div class="span9">
				<div class="hotAd">
				[@ad_position id = 6/]
				</div>			
			</div>
			<div class="span3">
				<div id="newArticle" class="newArticle">
						[@article_category_root_list count = 2]
					<ul class="tab">
						[#list articleCategories as articleCategory]
							<li>
								<a href="${base}${articleCategory.path}" target="_blank">${articleCategory.name}</a>
							</li>
						[/#list]
					</ul>
						[#list articleCategories as articleCategory]
							[@article_list articleCategoryId = articleCategory.id count = 5]
								<ul class="tabContent">
									[#list articles as article]
										<li>
											<a href="${base}${article.path}" title="${article.title}" target="_blank">${abbreviate(article.title, 30)}</a>
										</li>
									[/#list]
								</ul>
							[/@article_list]
						[/#list]
					[/@article_category_root_list]
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="span12">
				<div class="middleAd">
					[@ad_position id = 5/]
				</div>			
			</div>
		</div>
		
		[@product_category_root_list]
			[#list productCategories as category]
			<div class="row">
				<div class="span12">
					<div class="hotGoods">
						<dl class="title${category_index+1}">
							<dt>
								<a href="${base}${category.path}">${category.name}</a>
							</dt>
							[@product_category_children_list productCategoryId = category.id count = 5]
								[#list productCategories as productCategory]
									[#if productCategory.grade ==1]
									<dd>
										<a href="${base}${productCategory.path}">${productCategory.name}</a>
									</dd>
									[/#if]
								[/#list]
							[/@product_category_children_list]	
						</dl>
						<div>
							[@ad_position code = "${category_index+1}F"/]
						</div>
						<ul>
							[@product_list productCategoryId = category.id count = 5 orderBy="monthSales desc"]
							[#list products as product]
							<li>
								<a href="${base}${product.path}" title="${product.name}" target="_blank">
									<img src="${base}/upload/image/blank.gif" data-original="[#if product.image??]${product.image}[#else]${setting.defaultThumbnailProductImage}[/#if]"  height="170" width="170" />
									<div>
											<span title="${product.name}">${abbreviate(product.name, 30)}</span>
											<em title="${product.name}">${product.memo}</em>
									</div>
									<strong>${currency(product.price, true, true)}</strong>
								</a>
							</li>
							[/#list]
							[/@product_list]
							[@product_list productCategoryId = category.id count = 5 orderBy="monthSales asc"]
							[#list products as product]
							<li class="low">
								<a href="${base}${product.path}" title="${product.name}" target="_blank">
									<img href="${base}/upload/image/blank.gif" data-original="[#if product.image??]${product.image}[#else]${setting.defaultThumbnailProductImage}[/#if]" style="display: block;">
									<span title="${product.name}">${abbreviate(product.name, 30)}</span>
									<strong>${currency(product.price, true, true)}</strong>
								</a>
							</li>
							[/#list]
							[/@product_list]
						</ul>
					</div>
				</div>
			</div>
			[/#list]
		[/@product_category_root_list]
		<div class="row">
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
	<div class="goTop" style="display: none;"><a href="javascript:;">&nbsp;</a><a href="javascript:;">&nbsp;</a></div>
</body>
</html>