<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<xsl:include href="purchase/required.xsl" />
	<xsl:include href="purchase/delivery.xsl" />
	<xsl:include href="purchase/payment.xsl" />

	<xsl:template match="result[@method = 'purchase']">
        <xsl:apply-templates select="document('udata://emarket/purchase')/udata" />
    </xsl:template>

	<xsl:template match="purchasing[@stage = 'result']">
        <div id="order_failed_text_{$infoPageId}_{generate-id()}" class="text" umi:element-id="{$infoPageId}" umi:empty="&empty;" umi:field-name="order_failed_text" umi:field-type="string">
            <xsl:apply-templates select="$infoPage/property[@name = 'order_failed_text']" />
        </div>
    </xsl:template>

    <xsl:template match="purchasing[@stage = 'result' and @step = 'successful']">
        <div id="order_success_text_{$infoPageId}_{generate-id()}" class="text" umi:element-id="{$infoPageId}" umi:empty="&empty;" umi:field-name="order_success_text" umi:field-type="string">
            <xsl:apply-templates select="$infoPage/property[@name = 'order_success_text']" />
        </div>
    </xsl:template>

</xsl:stylesheet>
