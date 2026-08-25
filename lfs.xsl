<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet     version="1.0"
                    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

<xsl:template match="/">
<html>
<head>
<title><xsl:value-of select="translate(book/@type, $smallcase, $uppercase)"/>
       Advisories</title>
<link rel="stylesheet" type="text/css" href="lfs.css"/>
<link rel="icon" href="favicon.svg" type="image/svg+xml">
</head>
<body>
  <h1><xsl:value-of select="translate(book/@type, $smallcase, $uppercase)"/> Advisories</h1>
  <h2>Introduction</h2>
  <p>
    This page covers advisories, notably in relation with security and changes
    that may have broke or changed how things are done in earlier versions of
    the book.
  </p>
  <p>
    Sometimes, not every security vulnerability for an advisory will be
    available. Sometimes, upstream does not issue an ID with security
    authority, like a CVE. Sometimes, they don't wish to talk about the
    vulnerability in detail. What's listed is all that can be gathered from
    upstream and GitHub/Mitre/NVD.
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
  <p>
    This page was generated from an XML file with XSLT processing. You can
    easily track updates and view the XML by viewing the <a
    href="https://github.com/glfs-book/advisories">
    advisories GitHub repository</a>.
  </p>
  <p><em>
    This page is ordered like the Changelog of the book, with newest items
    first.
  </em></p>
  <xsl:for-each select="book/bookver">
    <h2><xsl:value-of select="@ver"/></h2>
    <xsl:if test="adv[@type='brk']">
      <h3>Breaking Changes</h3>
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
      <xsl:if test="update">
        <p>
          <b>Updated on <xsl:apply-templates select="update"/>. </b>
          <xsl:if test="reason">
            <b>Reason: <xsl:apply-templates select="reason"/>.</b>
          </xsl:if>
        </p>
      </xsl:if>
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
          <xsl:choose>
            <xsl:when test="@type='ghsa'">
              <a href="https://github.com/{@prefix}advisories/GHSA-{.}">
                GHSA-<xsl:value-of select="."/></a><xsl:choose>
                <xsl:when
                test="last() - position() = 1"><xsl:choose><xsl:when
                test="last() = 2"></xsl:when><xsl:otherwise>,</xsl:otherwise></xsl:choose>
                and </xsl:when><xsl:when
                test="last() - position() = 0"></xsl:when>
                <xsl:otherwise>, </xsl:otherwise></xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <a href="https://nvd.nist.gov/vuln/detail/CVE-{.}">
                CVE-<xsl:value-of select="."/></a><xsl:choose>
                <xsl:when
                test="last() - position() = 1"><xsl:choose><xsl:when
                test="last() = 2"></xsl:when><xsl:otherwise>,</xsl:otherwise></xsl:choose>
                and </xsl:when><xsl:when
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
      <xsl:if test="update">
        <p><em>
          Updated on <xsl:value-of select="normalize-space(update)"/>.
          <xsl:if test="reason">
            Reason: (<xsl:value-of select="normalize-space(reason)"/>).
          </xsl:if>
        </em></p>
      </xsl:if>
    </xsl:for-each>
    <br/>
  </xsl:for-each>
</body>
</html>
</xsl:template>

<xsl:template match="bold">
  <b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="italic">
  <em><xsl:apply-templates/></em>
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
