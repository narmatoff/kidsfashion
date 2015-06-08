<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:umi="http://www.umi-cms.ru/TR/umi">


	<xsl:template match="udata[@module = 'catalog'][@method = 'getObjectsList' or @method = 'getObjectsListFull']" mode="getObject_s1"/>
	<xsl:template match="udata[@module = 'catalog'][@method = 'getObjectsList' or @method = 'getObjectsListFull'][total]" mode="getObject_s1">
		<xsl:apply-templates select="lines/item" mode="getObject_s1"/>
	</xsl:template>

	<!--Списки товаров для интернет магазина-->
	<xsl:template match="udata[@method = 'getObjectsList' or @method = 'getObjectsListFull']/lines/item" mode="getObject_s1">
		<xsl:apply-templates select="." mode="simple_shop_catalog_s1"/>
	</xsl:template>


	<xsl:template match="item|page" mode="simple_shop_catalog_s1">
		<xsl:variable name="page" select="document(concat('upage://',@id))/udata/page"/>

		<li umi:region="row" umi:element-id="{@id}" umi:delete="delete" umi:delete-text="&delete-text-catalog-object;">
			<xsl:attribute name="class">span3
				<xsl:if test="@is-active">objectlist cat-item-active</xsl:if>
				<xsl:if test="not(@is-active)">objectlist cat-item-inactive</xsl:if>
			</xsl:attribute>

			<div class="thumbnail">
				<xsl:if test="$isAdmin = 1">
					<div class="catalog-objects-amount">
						<xsl:text>&in-stock;:</xsl:text>
						<span umi:field-name="common_quantity" umi:field-type="int" umi:empty="&empty;">
							<xsl:apply-templates select="$page//property[@name = 'common_quantity']"/>
						</span>
					</div>
				</xsl:if>


				<xsl:if test="$сatalogTitle">
					<div class="object_title">
						<a href="{@link}" umi:field-name="name" umi:field-type="string" umi:empty="&empty-name;">
							<xsl:value-of select="$page/name" disable-output-escaping="yes"/>
						</a>
					</div>
					<div class="prefix" umi:field-name="prefix" umi:field-type="string" umi:empty="&empty-prefix;">
						<xsl:value-of select="$page//property[@name = 'prefix']/value"/>
					</div>
				</xsl:if>

				<div class="imagin">
					<a href="{@link}" class="object_item img" umi:url-attribute="href">
						<xsl:call-template name="makeThumbnailSqueeze">
							<xsl:with-param name="element_id" select="@id"/>
							<xsl:with-param name="field_name" select="'photo'"/>
							<xsl:with-param name="width" select="$photoCatalogW"/>
							<xsl:with-param name="height" select="$photoCatalogH"/>
							<xsl:with-param name="no-empty-image" select="0"/>
						</xsl:call-template>
					</a>
				</div>

				<div class="caption">
					<xsl:if test="not($сatalogTitle)">
						<h5>
							<a href="{@link}" umi:field-name="name" umi:field-type="string" umi:empty="&empty-name;">
								<xsl:value-of select="$page/name" disable-output-escaping="yes"/>
							</a>
						</h5>
						<div class="opis" umi:field-name="prefix" umi:field-type="string" umi:empty="&empty-prefix;">
							<xsl:apply-templates select="document(concat('upage://',@id,'.prefix'))/udata/property[value]"/>
						</div>
					</xsl:if>

					<xsl:variable name="old_price" select="$page//property[@name = 'old_price']/value"/>
					<xsl:variable name="price" select="$page//property[@name = 'price']/value"/>
					<xsl:if test="$is_auth = 'auth'">
					<div class="price">
						<span class="price_value" umi:field-name="price" umi:field-type="price" umi:empty="&empty-price;">
							<xsl:apply-templates select="$price"/>
						</span>
						<xsl:text>&nbsp;</xsl:text>
						<span class="price_currency" umi:element-id="{$infoPageId}" umi:empty="&empty-currency;" umi:field-name="currency" umi:field-type="string">
							<xsl:apply-templates select="$infoPage/property[@name = 'currency']"/>
						</span>
					</div>
					</xsl:if>
					<!--Старая цена -->
					<xsl:if test="($isAdmin = 1) or ($price &lt; $old_price)">
						<div>
							<xsl:attribute name="class">
								<xsl:text>price old_price</xsl:text>
								<xsl:if test="$price &gt;= $old_price">
									<xsl:text> hidden</xsl:text>
								</xsl:if>
							</xsl:attribute>
							<span class="wrapper_for_old_price">
								<hr class="strike"/>
								<span class="price_value" umi:field-name="old_price" umi:field-type="price" umi:empty="&empty-price;">
									<xsl:apply-templates select="$old_price"/>
								</span>
								<xsl:text>&nbsp;</xsl:text>
								<span class="price_currency" umi:element-id="{$infoPageId}" umi:empty="&empty-currency;" umi:field-name="currency" umi:field-type="string">
									<xsl:apply-templates select="$infoPage/property[@name = 'currency']"/>
								</span>
							</span>
						</div>
					</xsl:if>
					<!--Кнопка-->
					<xsl:apply-templates select="$page" mode="buy_button">
						<xsl:with-param name="class" select="''"/>
					</xsl:apply-templates>
				</div>

			</div>
		</li>
	</xsl:template>


</xsl:stylesheet>
