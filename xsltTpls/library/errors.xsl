<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "ulang://i18n/constants.dtd:file">

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:umi="http://www.umi-cms.ru/TR/umi">

	<!--Вывод ошибок-->
	<xsl:template match="udata[@module = 'system' and @method = 'listErrorMessages']" />

	<xsl:template match="udata[@module = 'system' and @method = 'listErrorMessages'][count(items/item) &gt; 0]">
		<div class="text system_errors">
			<h3><xsl:text>&errors;:</xsl:text></h3>
			<ul><xsl:apply-templates select="items/item" /></ul>
		</div>
	</xsl:template>

	<xsl:template match="udata[@module = 'system' and @method = 'listErrorMessages']/items/item">
		<li><xsl:value-of select="." /></li>
	</xsl:template>

	<xsl:template match="error">
		<div class="text system_errors">
			<h3><xsl:text>&errors;:</xsl:text></h3>
			<ul><li><xsl:value-of select="." /></li></ul>
		</div>
	</xsl:template>

</xsl:stylesheet>
