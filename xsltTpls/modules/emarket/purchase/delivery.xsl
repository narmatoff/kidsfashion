<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file">

<xsl:stylesheet	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/TR/xlink">

	<!-- Выбор адреса доставки -->

	<xsl:template match="purchasing[@stage = 'delivery'][@step = 'address']">
		<div class="basket_page">
			<div class="purchase_controls" id="system_basket">
				<div class="basket_table_wrapper">
					<div class="basket_table_title">
						<a class="all_system_buttons system_basket_go_back" href="/emarket/cart/">&basket-back-to-cart;</a>
						<div class="middle">
							<span class="basket_table_title_icon middle">&nbsp;</span>
							<span class="basket_table_title_text middle">&choose-delivery-address;</span>
						</div>
						<div class="cleaner" />
					</div>
					<form class="site_form purchase_fields" id="delivery_address" method="post" action="{$lang-prefix}/emarket/purchase/delivery/address/do/">
						<fieldset class="system_basket_fields">
							<xsl:apply-templates select="items" mode="delivery-address" />
							<div class="field submit system_basket_submit">
								<input class="basket_submit_button" type="submit" value="&continue;" />
							</div>
							<div class="cleaner"/>
						</fieldset>
					</form>
					<script>
						jQuery('#delivery_address').submit(function(){
							var input = jQuery('input:radio:checked', this);
							if (typeof input.val() == 'undefined' || input.val() == 'new') {
								if (typeof input.val() == 'undefined') {
									jQuery('input:radio[value=new]', this).attr('checked','checked');
								}
								return site.forms.data.check(this);
							}
						});
					</script>
				</div>
				<div class="cleaner"/>
			</div>
		</div>
		<div id="system_empty_basket_text">
			<xsl:call-template name="empty_basket"/>
	    </div>
	</xsl:template>

	<xsl:template match="items" mode="delivery-address">
		<input type="hidden" name="delivery-address" value="new" />
		<xsl:apply-templates select="//delivery/items" mode="delivery-self" />
		<xsl:apply-templates select="document(../@xlink:href)/udata" />
	</xsl:template>

	<xsl:template match="items[count(item) &gt; 0]" mode="delivery-address">
		<xsl:apply-templates select="item" mode="delivery-address" />
		<xsl:if test="count(//delivery/items) &gt; 0">
			<h4>
				<xsl:text>&choose-self-delivery;:</xsl:text>
			</h4>
			<xsl:apply-templates select="//delivery/items" mode="delivery-self" />
			<h4>
				<xsl:text>&or-new-delivery-address;:</xsl:text>
			</h4>
		</xsl:if>

		<div>
			<label>
				<input type="radio" name="delivery-address" value="new" />
				<xsl:text>&new-delivery-address;</xsl:text>
			</label>
		</div>

		<div id="new-address">
			<xsl:apply-templates select="document(../@xlink:href)/udata"  />
		</div>
	</xsl:template>

	<xsl:template match="item" mode="delivery-address">
		<div class="form_element">
			<label>
				<input type="radio" name="delivery-address" value="{@id}">
					<xsl:if test="position() = 1 or @active = 'active'">
						<xsl:attribute name="checked">
							<xsl:text>checked</xsl:text>
						</xsl:attribute>
					</xsl:if>
				</input>
				<xsl:apply-templates select="document(concat('uobject://', @id))//property" mode="delivery-address" />
			</label>
		</div>
	</xsl:template>

	<xsl:template match="item[@id='self']" mode="delivery-address">
		<div class="form_element">
			<label>
				<input type="radio" name="delivery-address" value="{@id}" />
				<xsl:text></xsl:text>
			</label>
		</div>
	</xsl:template>

	<xsl:template match="property" mode="delivery-address">
		<xsl:value-of select="value" />
		<xsl:text>, </xsl:text>
	</xsl:template>

	<xsl:template match="property[@type = 'relation']" mode="delivery-address">
		<xsl:value-of select="value/item/@name" />
		<xsl:text>, </xsl:text>
	</xsl:template>

	<xsl:template match="property[position() = last()]" mode="delivery-address">
		<xsl:value-of select="value" />
	</xsl:template>


	<!-- Выбор способа доставки -->

	<xsl:template match="purchasing[@stage = 'delivery'][@step = 'choose']">
		<div class="basket_page">
			<div class="purchase_controls" id="system_basket">
				<div class="basket_table_wrapper">
					<div class="basket_table_title">
						<a class="all_system_buttons system_basket_go_back" href="/emarket/cart/">&basket-back-to-cart;</a>
						<div class="middle">
							<span class="basket_table_title_icon middle">&nbsp;</span>
							<span class="basket_table_title_text middle">&delivery-agent;</span>
						</div>
						<div class="cleaner" />
					</div>
					<form class="site_form purchase_fields" method="post" action="{$lang-prefix}/emarket/purchase/delivery/choose/do/">
						<fieldset class="system_basket_fields">
							<xsl:apply-templates select="items" mode="delivery-choose" />
							<div class="field submit system_basket_submit">
								<input class="basket_submit_button" type="submit" value="&continue;" />
							</div>
							<div class="cleaner"/>
						</fieldset>
					</form>
				</div>
				<div class="cleaner"/>
			</div>
		</div>
		<div id="system_empty_basket_text">
			<xsl:call-template name="empty_basket"/>
	    </div>
	</xsl:template>

	<xsl:template match="item" mode="delivery-choose">
		<xsl:variable name="delivery-price" select="@price"/>

		<div>
			<label>
				<input type="radio" name="delivery-id" value="{@id}">
					<xsl:apply-templates select="." mode="delivery-choose-first" />
				</input>
				<xsl:value-of select="@name" />

				<xsl:call-template  name="delivery-price" >
					<xsl:with-param name="price" select="$delivery-price"/>
				</xsl:call-template >
			</label>
		</div>
	</xsl:template>

	<xsl:template match="item" mode="delivery-self">
		<xsl:variable name="delivery-price" select="@price"/>
		<div>
			<label>
				<input type="radio" name="delivery-address" value="delivery_{@id}">
					<xsl:if test="@active = 'active'">
						<xsl:attribute name="checked" select="'checked'" />
					</xsl:if>
				</input>
				<xsl:value-of select="@name" />

				<xsl:call-template  name="delivery-price" >
					<xsl:with-param name="price" select="$delivery-price"/>
				</xsl:call-template >
			</label>
		</div>
	</xsl:template>

	<xsl:template match="item" mode="delivery-choose-first">
			<xsl:if test="@active = 'active'">
				<xsl:attribute name="checked" select="'checked'" />
			</xsl:if>
	</xsl:template>

	<xsl:template match="item[1]" mode="delivery-choose-first">
		<xsl:attribute name="checked" select="'checked'" />
	</xsl:template>

	<xsl:template name="delivery-price">
		<xsl:param name="price" select="0"/>

		<xsl:variable name="formatted-price" select="document(concat('udata://emarket/applyPriceCurrency/', $price))/udata" />

		<xsl:text> - </xsl:text>
		<xsl:choose>
			<xsl:when test="$formatted-price/price">
				<xsl:apply-templates select="$formatted-price" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$price" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
