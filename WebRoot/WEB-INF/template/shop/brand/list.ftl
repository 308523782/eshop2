<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
[@seo type = "brandList"]
	<title>[#if seo.title??][@seo.title?interpret /][#else]${message("shop.brand.title")}[/#if]</title>
	
	
	[#if seo.keywords??]
		<meta name="keywords" content="[@seo.keywords?interpret /]" />
	[/#if]
	[#if seo.description??]
		<meta name="description" content="[@seo.description?interpret /]" />
	[/#if]
[/@seo]
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/goods.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/brand.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $logo = $("#list img");

	$logo.lazyload({
		threshold: 100,
		effect: "fadeIn"
	});
	
});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container brandList">
		<div class="row">
			<div class="span2">
				<div class="hotProductCategory">
					[@product_category_root_list]
						[#list productCategories as category]
							<dl[#if !category_has_next] class="last"[/#if]>
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
				<div class="hotArticle">
					<dl>
					<dt>${message("shop.article.hotArticle")}</dt>
					[@article_list articleCategoryId = articleCategory.id count = 10 orderBy="hits desc"]
						[#list articles as article]
						<dd>
							<a href="${base}${article.path}" title="${article.title}">${abbreviate(article.title, 30)}</a>
						</dd>
						[/#list]
					[/@article_list]	
					</dl>
				</div>
				<div class="articleSearch">
					<div class="title">${message("shop.article.search")}</div>
						<div class="content">
							<div>
								<form id="articleSearchForm" action="${base}/article/search.jhtml" method="get">
									<input type="text" name="keyword" value="${message("shop.article.keyword")}" maxlength="30">
									<button type="submit">${message("shop.article.searchSubmit")}</button>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="span10">
					<div class="breadcrumb">
					<ul>
						<li>
							<a href="${base}/">${message("shop.path.home")}</a>
						</li>
						<li class="last">${message("shop.brand.title")}</li>
					</ul>
				</div>
				<div id="list" class="list clearfix">
					[#if page.content?has_content]
						<ul>
							[#list page.content?sort_by("type")?chunk(4) as row]
								[#list row as brand]
									<li[#if !row_has_next] class="last"[/#if]>
										<a href="${base}${brand.path}">
											<img src="${base}/upload/image/blank.gif"[#if brand.logo??] data-original="${brand.logo}"[/#if] />
											<span title="${brand.name}">${brand.name}</span>
										</a>
									</li>
								[/#list]
							[/#list]
						</ul>
					[#else]
						${message("shop.brand.noResult")}
					[/#if]
				</div>
				[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "{pageNumber}.jhtml"]
					[#include "/shop/include/pagination.ftl"]
				[/@pagination]
			</div>
	</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>