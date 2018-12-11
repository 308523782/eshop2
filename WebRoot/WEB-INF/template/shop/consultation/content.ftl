<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${product.name} ${message("shop.consultation.title")}</title>


<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/goods.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/consultation.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $addConsultation = $("#addConsultation");
	
	[#if setting.consultationAuthority != "anyone"]
		$addConsultation.click(function() {
			if ($.checkLogin()) {
				return true;
			} else {
				$.redirectLogin("${base}/consultation/add/${product.id}.jhtml", "${message("shop.consultation.accessDenied")}");
				return false;
			}
		});
	[/#if]
	
});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container consultation">
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
					<li>${message("shop.consultation.title")}</li>
				</ul>
			</div>
			<table class="info">
				<tbody>
					<tr>
						<th rowspan="3">
							<img src="[#if product.thumbnail??]${product.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" alt="${product.name}" />
						</th>
						<td>
							<a href="${base}${product.path}">${abbreviate(product.name, 60, "...")}</a>
						</td>
						<td class="handle" rowspan="3">
							<a href="${base}/consultation/add/${product.id}.jhtml" id="addConsultation">[${message("shop.consultation.add")}]</a>
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
				</tbody>
			</table>
			<div class="content">
				[#if page.content?has_content]
					<ul>
						[#list page.content as consultation]
							<li[#if !consultation_has_next] class="last"[/#if]>
								${consultation.content}
								<span>
									[#if consultation.member??]
										${consultation.member.username}
									[#else]
										${message("shop.consultation.anonymous")}
									[/#if]
									<span title="${consultation.createDate?string("yyyy-MM-dd HH:mm:ss")}">${consultation.createDate}</span>
								</span>
								[#if consultation.replyConsultations?has_content]
									<div class="arrow"></div>
									<ul>
										[#list consultation.replyConsultations as replyConsultation]
											<li>
												${replyConsultation.content}
												<span title="${replyConsultation.createDate?string("yyyy-MM-dd HH:mm:ss")}">${replyConsultation.createDate}</span>
											</li>
										[/#list]
									</ul>
								[/#if]
							</li>
						[/#list]
					</ul>
				[#else]
					<p>${message("shop.consultation.noResult")}</p>
				[/#if]
			</div>
			[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "?pageNumber={pageNumber}"]
				[#include "/shop/include/pagination.ftl"]
			[/@pagination]
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>