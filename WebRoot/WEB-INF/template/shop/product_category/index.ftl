<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.productCategory.title")}</title>


<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/goods.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/product_category.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container productCategory">
	<div class = "row">
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
						<li class="last">${message("shop.productCategory.title")}</li>
					</ul>
				</div>
				<div class="list">
					<table>
						[#list rootProductCategories as rootProductCategory]
							<tr[#if !rootProductCategory_has_next] class="last"[/#if]>
								<th>
									<a href="${base}${rootProductCategory.path}">${rootProductCategory.name}</a>
								</th>
								<td>
									[#list rootProductCategory.children as productCategory]
										<a href="${base}${productCategory.path}">${productCategory.name}</a>
									[/#list]
								</td>
							</tr>
						[/#list]
					</table>
				</div>
			</div>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>