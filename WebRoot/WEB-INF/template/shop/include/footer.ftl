<div class="footer">
	<div class="service clearfix">
		[@article_category_root_list count = 4]
			[#list articleCategories as articleCategory]
			<dl>
			  <dt class="icon1">${articleCategory.name}</dt>
				[@article_list articleCategoryId = articleCategory.id count = 5]
					[#list articles as article]
					<dd>
						<a href="${base}${article.path}" title="${article.title}" target="_blank">${abbreviate(article.title, 30)}</a>
					</dd>
					[/#list]
				[/@article_list]
			</dl>
			[/#list]
		[/@article_category_root_list]
		
		<div class="qrCode">
			<img src="./newShop_files/qr_code.gif" alt="官方微信">
			官方微信
		</div>
	</div>
	<div class="bottom">
		<div class="bottomNav">
			<ul>
			[@navigation_list position = "bottom"]
				[#list navigations as navigation]
					<li>
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
						[#if navigation_has_next]|[/#if]
					</li>
				[/#list]
			[/@navigation_list]
			</ul>
		</div>
		<div class="info">
			<p>湘ICP备10000000号</p>
			<p>${message("shop.footer.copyright", setting.siteName)}</p>
		</div>
	</div>
</div>
