<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
[@seo type = "articleContent"]
	<title>[#if article.seoTitle??]${article.seoTitle}[#elseif seo.title??][@seo.title?interpret /][/#if]</title>

	[#if article.seoKeywords??]
		<meta name="keywords" content="${article.seoKeywords}" />
	[#elseif seo.keywords??]
		<meta name="keywords" content="[@seo.keywords?interpret /]" />
	[/#if]
	[#if article.seoDescription??]
		<meta name="description" content="${article.seoDescription}" />
	[#elseif seo.description??]
		<meta name="description" content="[@seo.description?interpret /]" />
	[/#if]
[/@seo]
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $hits = $("#hits");

	// 查看点击数
	$.ajax({
		url: "${base}/article/hits/${article.id}.jhtml",
		type: "GET",
		success: function(data) {
			$hits.text(data);
		}
	});

});
</script>
</head>
<body>
	[#assign articleCategory = article.articleCategory /]
	[#include "/shop/include/header.ftl" /]
	<div class="container articleContent">
		<div class="row">
			<div class="span2">
				<div class="hotArticleCategory">
					<dl>
						<dt >${message("shop.article.articleCategory")}</dt>
						[@article_category_root_list count = 10]
							[#list articleCategories as category]
							<dd>
								<a href="${base}${category.path}">${category.name}</a>
							</dd>
							[#list category.children as articleCategory]
								[#if articleCategory_index == 6]
									[#break /]
								[/#if]
								<dd>
									<a href="${base}${articleCategory.path}">${articleCategory.name}</a>
								</dd>
							[/#list]
					</dl>
					[/#list]
				 [/@article_category_root_list]
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
						[@article_category_parent_list articleCategoryId = articleCategory.id]
						[#list articleCategories as articleCategory]
							<li>
								<a href="${base}${articleCategory.path}">${articleCategory.name}</a>
							</li>
						[/#list]
					[/@article_category_parent_list]
					</ul>
				</div>
				<div class="main">
					<h1 class="title">${article.title}</h1>
					<div class="info">
						${message("shop.article.createDate")}: ${article.createDate?string("yyyy-MM-dd HH:mm:ss")}
						${message("shop.article.author")}: ${article.author}
						${message("shop.article.hits")}: <span id="hits">&nbsp;</span>
					</div>
					<div class="content">${article.content}</div>
					</div>	
					[@pagination pageNumber = article.pageNumber totalPages = article.totalPages pattern = "{pageNumber}.html"]
					[#include "/shop/include/pagination.ftl"]
					[/@pagination]
			</div>
		</div>
	[#include "/shop/include/footer.ftl" /]
	<div class="goTop" style="display: none;"><a href="javascript:;">&nbsp;</a><a href="javascript:;">&nbsp;</a></div></body></html>
</body>
</html>