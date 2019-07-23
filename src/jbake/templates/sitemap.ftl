<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
<#list published_content as content>
    <#-- workaround for a bug in jbake: the content/feed.md file uses the feed_json template with the .json extension defined in the properties, but jbake doesn't seem to catch this -->
    <#if content.uri == "feed.html">
        <#continue>
    </#if>
    <url>
        <loc>${config.site_host}/${content.uri}</loc>
        <lastmod>${content.date?string("yyyy-MM-dd")}</lastmod>
    </url>
</#list>
</urlset>
