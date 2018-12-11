<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
[@seo type = "articleSearch"]
	<title>[#if seo.title??][@seo.title?interpret /][/#if]</title>
	
	
	[#if seo.keywords??]
		<meta name="keywords" content="[@seo.keywords?interpret /]" />
	[/#if]
	[#if seo.description??]
		<meta name="description" content="[@seo.description?interpret /]" />
	[/#if]
[/@seo]
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $articleSearchForm = $("#articleSearchForm");
	var $keyword = $("#articleSearchForm input");
	var defaultKeyword = "${message("shop.article.keyword")}";
	
	$keyword.focus(function() {
		if ($keyword.val() == defaultKeyword) {
			$keyword.val("");
		}
	});
	
	$keyword.blur(function() {
		if ($keyword.val() == "") {
			$keyword.val(defaultKeyword);
		}
	});

	$articleSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});

});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container articleList">
		<div class="row">
			<div class="span2">
				<div class="hotArticleCategory">
					<dl>
						<dt>${message("shop.article.articleCategory")}</dt>
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
						<li class="last">${message("shop.article.path", articleKeyword)}</li>
					</ul>
				</div>
				<div class="result">
					[#if page.content?has_content]
						<ul>
							[#list page.content as article]
								<li[#if !article_has_next] class="last"[/#if]>
									<a href="${base}${article.path}" title="${article.title}">${abbreviate(article.title, 80, "...")}</a>
									${article.author}
									<span title="${article.createDate?string("yyyy-MM-dd HH:mm:ss")}">${article.createDate}</span>
									<p>${abbreviate(article.text, 220, "...")}</p>
								</li>
							[/#list]
						</ul>
					[#else]
						${message("shop.article.noSearchResult", articleKeyword)}
					[/#if]
				</div>
			[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "search.jhtml?keyword=${articleKeyword}&pageNumber={pageNumber}"]
				[#include "/shop/include/pagination.ftl"]
			[/@pagination]
			</div>
		</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>