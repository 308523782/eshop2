<script type="text/javascript">
$().ready(function() {

	var $headerName = $("#headerName");
	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerLogout = $("#headerLogout");
	var $goodsSearchForm = $("#goodsSearchForm");
	var $keyword = $("#goodsSearchForm input");
	var defaultKeyword = "${message("shop.header.keyword")}";
	
	var username = getCookie("username");
	var nickname = getCookie("nickname");
	if ($.trim(nickname) != "") {
		$headerName.text(nickname).show();
		$headerLogout.show();
		$headerLogin.hide();
		$headerRegister.hide();
	} else if ($.trim(username) != "") {
		$headerName.text(username).show();
		$headerLogout.show();
		$headerLogin.hide();
		$headerRegister.hide();
	} else {
		$headerLogin.show();
		$headerRegister.show();
	}
	
	$keyword.focus(function() {
		if ($.trim($keyword.val()) == defaultKeyword) {
			$keyword.val("");
		}
	});
	
	$keyword.blur(function() {
		if ($.trim($keyword.val()) == "") {
			$keyword.val(defaultKeyword);
		}
	});
	
	$goodsSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});

});
	
</script>

<div class="header">
	<div class="top">
		<div class="topNav">
			<ul class="left">
				<li>
					<span>${message("shop.header.hello",setting.siteName)}</span>
					<span id="headerName" class="headerName">&nbsp;</span>
				</li>
				<li id="headerLogin" class="headerLogin" style="display: list-item;">
					<a href="/login.jhtml">${message("shop.header.login")}</a>
				</li>
				<li id="headerRegister" class="headerRegister" style="display: list-item;">
					<a href="/register.jhtml">${message("shop.header.register")}</a>
				</li>
				<li id="headerLogout" class="headerLogout">
					<a href="/logout.jhtml">[${message("shop.header.logout")}]</a>
				</li>
			</ul>
			<ul class="right">
				[@navigation_list position = "top"]
					[#list navigations as navigation]
						<li>
							<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							[#if navigation_has_next]|[/#if]
						</li>
					[/#list]
				[/@navigation_list]
				<li id="headerCart" class="headerCart">
					<a href="/cart/list.jhtml">${message("shop.header.cart")}</a>
					(<em>1</em>)
				</li>
			</ul>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span3">
				<a href="${base}/">
					<img src="${setting.logo}" alt="${setting.siteName}" />
				</a>
			</div>
			<div class="span6">
				<div class="search">
					<form id="productSearchForm" action="${base}/product/search.jhtml" method="get">
						<input name="keyword" class="keyword" value="${productKeyword!message("shop.header.keyword")}"/>
						<button type="submit"></button>
					</form>
				</div>
				<div class="hotSearch">
					[#if setting.hotSearches?has_content]
						[#list setting.hotSearches as hotSearch]
							<a href="${base}/product/search.jhtml?keyword=${hotSearch?url}">${hotSearch}</a>
						[/#list]
					[/#if]
				</div>
			</div>
			<div class="span3">
				[#if setting.phone??]
					<div class="phone">
						<em>${message("shop.header.phone")}</em>
						${setting.phone}
					</div>
				[/#if]
			</div>
		</div>
	</div>
	<div class="row">
		<div class="span12">
			<dl class="mainNav">
				<dt>
					<a href="">${message("shop.index.allProductCategory")}</a>
				</dt>
				<dd>
					<a href="${base}/">${message("shop.path.home")}</a>
				</dd>
				[@tag_list type="product" count = 4]
					[#list tags as tag]
						<dd>
							<a href="${base}/product/list.jhtml?tagIds=${tag.id}">${tag.name}</a>
						</dd>
					[/#list]
				[/@tag_list]
				[@navigation_list position = "middle"]
					<ddd>
					[#list navigations as navigation]
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
					[/#list]
					</ddd>
				[/@navigation_list]	
			</dl>
		</div>
	</div>
</div>
