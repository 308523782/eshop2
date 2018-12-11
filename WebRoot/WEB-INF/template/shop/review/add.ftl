<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${product.name} ${message("shop.review.title")}</title>


<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/goods.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/review.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.rating.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $reviewForm = $("#reviewForm");
	var $score = $("input.score");
	var $tips = $("#tips");
	var $content = $("#content");
	var $captcha = $("#captcha");
	var $captchaImage = $("#captchaImage");
	var $submit = $("input:submit");
	
	
	// 评分
	$score.rating({
		callback: function(value, link) {
			$tips.text(message("{0}分", value));
		}
	});
	
	// 更换验证码
	$captchaImage.click(function() {
		$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + (new Date()).valueOf());
	});
	
	// 表单验证
	$reviewForm.validate({
		rules: {
			content: {
				required: true,
				maxlength: 200
			},
			captcha: "required"
		},
		submitHandler: function(form) {
			$.ajax({
				url: $reviewForm.attr("action"),
				type: "POST",
				data: $reviewForm.serialize(),
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function(message) {
					$.message(message);
					if (message.type == "success") {
						setTimeout(function() {
							$submit.prop("disabled", false);
							location.href = "../content/${product.id}.jhtml";
						}, 3000);
					} else {
						$submit.prop("disabled", false);
						[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
							$captcha.val("");
							$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + (new Date()).valueOf());
						[/#if]
					}
				}
			});
		}
	});

});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container review">
		<div class="row">
			<div class="span2">
				<div class="hotProductCategory">
					[@product_category_root_list]
						[#list productCategories as category]
							<dl [#if category_index%2!=0] class="even clearfix"[/#if] >
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
						[@product_list count = 6 orderBy="monthSales desc"]
							[#list products as product]
							<dd>
								<a href="${base}${product.path}" >
									<img src="${product.image}" alt="${product.name}">
									<span title="${product.name}">${product.name}</span>
								</a>
								<strong>
									${currency(product.price, true, true)}
									<del>${product.monthSales}</del>
								</strong>
							</dd>
							[/#list]
						[/@product_list]
					</dl>
				</div>
			</div>
			<div class="span10">
				<div class="breadcrumb">
					<ul>
						<li>
							<a href="${base}/">${message("shop.path.home")}</a>
						</li>
						<li>
							<a href="${base}${product.path}">${abbreviate(product.name, 30)}</a>
						</li>
						<li>${message("shop.review.title")}</li>
					</ul>
				</div>

				<table class="info">
					<tbody><tr>
						<th rowspan="3">
							<img src="[#if product.thumbnail??]${product.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" alt="${product.name}" />
						</th>
						<td>
							<a href="${base}${product.path}">${abbreviate(product.name, 60, "...")}</a>
						</td>
					</tr>
					<tr>
						<td>
							${message("Product.price")}: <strong>${currency(product.price, true, true)}</strong>
						</td>
					</tr>
					<tr>
						<td>
							[#if product.scoreCount > 0]
								<div>${message("Product.score")}: </div>
								<div class="score${(product.score * 2)?string("0")}"></div>
								<div>${product.score?string("0.0")}</div>
							[#else]
								[#if setting.isShowMarketPrice]
									${message("Product.marketPrice")}:
									<del>${currency(product.marketPrice, true, true)}</del>
								[/#if]
							[/#if]
						</td>
					</tr>
				</tbody></table>
				<form id="reviewForm" action="${base}/review/save.jhtml" method="post" novalidate="novalidate">
					<input type="hidden" name="goodsId"  value="${product.id}" />
					[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
						<input type="hidden" name="captchaId" value="${captchaId}" />
					[/#if]
					<div class="add">
						<table>
							<tbody><tr>
								<th>
									${message("Review.score")}:
								</th>
								<td>
									<span class="star-rating-control">
									<div class="rating-cancel">
										<a title="Cancel Rating"></a>
									</div>
									<div role="text" aria-label="${message("shop.review.score1")}" class="star-rating rater-0 score star-rating-applied star-rating-live star-rating-on">
										<a title="${message("shop.review.score1")}">1</a>
									</div>
									<div role="text" aria-label="${message("shop.review.score2")}" class="star-rating rater-0 score star-rating-applied star-rating-live star-rating-on">
										<a title="${message("shop.review.score2")}">2</a>
									</div>
									<div role="text" aria-label="${message("shop.review.score3")}" class="star-rating rater-0 score star-rating-applied star-rating-live star-rating-on">
										<a title="${message("shop.review.score3")}">3</a>
									</div>
									<div role="text" aria-label="${message("shop.review.score4")}" class="star-rating rater-0 score star-rating-applied star-rating-live star-rating-on">
										<a title="${message("shop.review.score4")}">4</a>
									</div>
									<div role="text" aria-label="${message("shop.review.score5")}" class="star-rating rater-0 score star-rating-applied star-rating-live star-rating-on">
										<a title="${message("shop.review.score5")}">5</a>
									</div>
									</span>
									
									<input type="radio" name="score" class="score star-rating-applied" value="1" title="${message("shop.review.score1")}" style="display: none;"/>
									<input type="radio" name="score" class="score star-rating-applied" value="2" title="${message("shop.review.score2")}" style="display: none;"/>
									<input type="radio" name="score" class="score star-rating-applied" value="3" title="${message("shop.review.score3")}" style="display: none;"/>
									<input type="radio" name="score" class="score star-rating-applied" value="4" title="${message("shop.review.score4")}" style="display: none;"/>
									<input type="radio" name="score" class="score star-rating-applied" value="5" title="${message("shop.review.score5")}" checked="checked" style="display: none;"/>
									<strong id="tips" class="tips">${message("shop.review.tips", 5)}</strong>
								</td>
							</tr>
							<tr>
								<th>
									${message("Review.content")}:
								</th>
								<td>
									<textarea id="content" name="content" class="text"></textarea>
								</td>
							</tr>
							[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
								<tr>
									<th>
										${message("shop.captcha.name")}:
									</th>
									<td>
										<span class="fieldSet">
											<input type="text" id="captcha" name="captcha" class="text captcha" maxlength="4" autocomplete="off" /><img id="captchaImage" class="captchaImage" src="${base}/common/captcha.jhtml?captchaId=${captchaId}" title="${message("shop.captcha.imageTitle")}" />
										</span>
									</td>
								</tr>
							[/#if]
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="button" value="${message("shop.review.submit")}" />
								</td>
							</tr>
						</tbody></table>
					</div>
				</form>
			</div>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>