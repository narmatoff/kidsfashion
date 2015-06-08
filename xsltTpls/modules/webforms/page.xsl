<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:umi="http://www.umi-cms.ru/TR/umi"
	extension-element-prefixes="php"
	exclude-result-prefixes="php">

	<!--Cтраница контактов-->
    <xsl:template match="result[@module = 'webforms'][@method = 'page']">
        <xsl:apply-templates select="page/properties" mode="new_contacts_form"/>
        <div class="contacts_page_h2 h2" umi:element-id="{$infoPageId}" umi:empty="&empty;" umi:field-name="feedback_title" umi:field-type="string">
            <xsl:apply-templates select="$infoPage/property[@name = 'feedback_title']" />

        </div>
        <xsl:apply-templates select="document(concat('udata://webforms/add/', .//property[@name = 'form_id']/value))/udata" mode="feedback"/>
    </xsl:template>

    <xsl:template match="udata" mode="page_list_contact">
		<ul id="tabs">
			<xsl:apply-templates select="page" mode="page_list_contact_li"/>
		</ul>

		<div id="contenter">
			<xsl:apply-templates select="page" mode="page_list_contact_div"/>
		</div>
    </xsl:template>

    <xsl:template match="page" mode="page_list_contact_li">
    	<li><a href="#" title="tab{position()}"><xsl:value-of select="name"/></a></li>
    </xsl:template>

	<xsl:template match="page" mode="page_list_contact_div">
    	<div id="tab{position()}">
    		<xsl:value-of select="document(concat('upage://', @id))//property[@name='content']/value" disable-output-escaping="yes"/>
		</div>
	</xsl:template>
	 <xsl:template match="result[@module = 'webforms' and @method = 'page']/page/properties" mode="new_contacts_form">
        <div umi:element-id="{$pageId}">



			<xsl:if test="not($userType = 'guest')">
				<div class="hidden">
					<xsl:if test="not(//property[@name ='yandexmap']/value)">
						<div class="text">
							<p>
								<a target="blank" href="http://api.yandex.ru/maps/tools/constructor/">&no-yamap;</a>
							</p>
						</div>
					</xsl:if>
					<div umi:element-id="{$pageId}" umi:field-name="yandexmap" umi:field-type="text" umi:empty="&empty-yamap;">
						<xsl:value-of select="//property[@name ='yandexmap']/value" disable-output-escaping="yes" />
					</div>
				</div>
			</xsl:if>
			<xsl:apply-templates select="//property[@name ='yandexmap']" mode="yandex_map" />
			<div id="text_{$pageId}_{generate-id()}" umi:element-id="{$pageId}" class="text" umi:field-name="text" umi:field-type="wysiwyg" umi:empty="&empty-page-content;">
				<xsl:apply-templates select="//property[@name ='text']" />
			</div>
			<xsl:apply-templates select="document(concat('usel://getContent//content//', $pageId))/udata" mode="page_list_contact"/>

        </div>
    </xsl:template>

	<xsl:template match="property" mode="yandex_map" >
		<div class="code_pre yandex_map">
			<xsl:value-of select="php:function('htmlspecialchars_decode', string(value))" disable-output-escaping="yes" />
		</div>
	</xsl:template>

</xsl:stylesheet>
