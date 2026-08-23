<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet     version="1.0"
                    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

<xsl:template match="/">
<html>
<title><xsl:value-of select="translate(book/@type, $smallcase, $uppercase)"/>
       Advisories</title>
<body>
  <h1><xsl:value-of select="translate(book/@type, $smallcase, $uppercase)"/> Advisories</h1>
  <h2>Introduction</h2>
  <p>
    This page covers advisories, notably in relation with security and changes
    that may have broken earlier versions of the book.
  </p>
  <xsl:if test="/book/@type='glfs'">
  <p>
    For security, most of the packages in GLFS are in BLFS, and GLFS for the
    most part gets the same updates as BLFS gets. Thus, you should check the
    <a href="https://linuxfromscratch.org/advisories">BLFS Advisories</a>.
    This page covers GLFS-specific issues, or when the BLFS issues hit GLFS the
    hardest.
  </p>
  </xsl:if>
  <p><em>
    This page is ordered like the Changelog of the book, with newest items
    first.
  </em></p>
  <xsl:for-each select="book/bookver">
    <h2><xsl:value-of select="@ver"/></h2>
    <xsl:if test="adv[@type='brk']">
      <h3>Broken Changes</h3>
    </xsl:if>
    <xsl:for-each select="adv[@type='brk']">
      <h4 id="{/book/@type}-{@type}-{../@ver}-{format-number(last() - position() + 1, '000')}"><xsl:value-of
           select="/book/@type"/>-<xsl:value-of
           select="@type"/>-<xsl:value-of
           select="../@ver"/>-<xsl:value-of
           select="format-number(last() - position() + 1, '000')"/>: <xsl:value-of
           select="topic"/><xsl:if
           test="ver">-<xsl:value-of
           select="ver"/></xsl:if>
           (Date: <xsl:value-of
           select="date"/>)</h4>
      <xsl:for-each select="des">
        <p><xsl:apply-templates select="."/></p>
      </xsl:for-each>
      <xsl:for-each select="action">
        <p><xsl:apply-templates select="."/></p>
      </xsl:for-each>
    </xsl:for-each>
    <xsl:if test="adv[@type='sec']">
      <h3>Security Advisories</h3>
    </xsl:if>
    <xsl:for-each select="adv[@type='sec']">
      <h4 id="{/book/@type}-{@type}-{../@ver}-{format-number(last() - position() + 1, '000')}"><xsl:value-of
           select="/book/@type"/>-<xsl:value-of
           select="@type"/>-<xsl:value-of
           select="../@ver"/>-<xsl:value-of
           select="format-number(last() - position() + 1, '000')"/>: <xsl:value-of
           select="topic"/><xsl:if
           test="ver">-<xsl:value-of
           select="ver"/></xsl:if>
           - Rating: <xsl:value-of
           select="rate"/>
           (Date: <xsl:value-of
           select="date"/>)</h4>
      <xsl:for-each select="des">
        <p><xsl:apply-templates select="."/></p>
      </xsl:for-each>
      <xsl:choose>
      <xsl:when test="id">
        <p>Assigned vulnerabilities:
        <xsl:for-each select="id">
          <xsl:sort select="id"/>
          <xsl:choose>
            <xsl:when test="@type='gh'">
              <a href="https://github.com/{@prefix}advisories/GHSA-{.}">
                GHSA-<xsl:value-of select="."/></a><xsl:choose>
                <xsl:when
                test="last() - position() = 1">, and </xsl:when>
                <xsl:when
                test="last() - position() = 0"></xsl:when>
                <xsl:otherwise>, </xsl:otherwise></xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <a href="https://nvd.nist.gov/vuln/detail/CVE-{.}">
                CVE-<xsl:value-of select="."/></a><xsl:choose>
                <xsl:when
                test="last() - position() = 1">, and </xsl:when>
                <xsl:when
                test="last() - position() = 0"></xsl:when>
                <xsl:otherwise>, </xsl:otherwise></xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>.
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p>There are no IDs with security authority.</p>
      </xsl:otherwise>
      </xsl:choose>
      <xsl:for-each select="action">
        <p><xsl:apply-templates select="."/></p>
      </xsl:for-each>
    </xsl:for-each>
    <br/>
  </xsl:for-each>
</body>
</html>
</xsl:template>

<xsl:template match="ulink">
  <a href="{@url}">
    <xsl:apply-templates/>
  </a>
</xsl:template>

<xsl:template match="command">
  <kbd>
    <xsl:apply-templates/>
  </kbd>
</xsl:template>

<xsl:template match="filename">
  <kbd>
    <xsl:apply-templates/>
  </kbd>
</xsl:template>

<xsl:template match="option">
  <kbd>
    <xsl:apply-templates/>
  </kbd>
</xsl:template>

<xsl:template match="parameter">
  <em><kbd>
    <xsl:apply-templates/>
  </kbd></em>
</xsl:template>

</xsl:stylesheet>
