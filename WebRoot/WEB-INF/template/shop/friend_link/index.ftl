<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.friendLink.title")}</title>


<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/article.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/friend_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $articleSearchForm = $("#articleSearchForm");
	var $keyword = $("#articleSearchForm input");
	var $logo = $("#result img");
	var defaultKeyword = $keyword.val();
	
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
	<div class="container friendLink">
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
								[#break/]
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
			</div>
		<div class="span10">
			<div class="breadcrumb">
				<ul>
					<li>
						<a href="${base}/">${message("shop.path.home")}</a>
					</li>
					<li class="last">${message("shop.friendLink.title")}</li>
				</ul>
			</div>
			[#if imageFriendLinks?has_content]
				<div class="list clearfix">
					<ul>
						[#list imageFriendLinks as friendLink]
							<li>
								<a href="${friendLink.url}" target="_blank">
									<img src="${friendLink.logo}" alt="${friendLink.name}" title="${friendLink.name}" />
								</a>
							</li>
						[/#list]
					</ul>
				</div>
			[/#if]
			[#if textFriendLinks?has_content]
				<div class="list clearfix">
					<ul>
						[#list textFriendLinks as friendLink]
							<li>
								<a href="${friendLink.url}" target="_blank">${friendLink.name}</a>
							</li>
						[/#list]
					</ul>
				</div>
			[/#if]
		</div>
	</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>