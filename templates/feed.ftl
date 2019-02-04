<#ftl output_format="XML">
<?xml version="1.0"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Renjin blog</title>
    <link>${config.site_host}</link>
    <atom:link href="${config.site_host}/${config.feed_file}" rel="self" type="application/rss+xml" />
    <description>Blog for the Renjin project.</description>
    <pubDate>${published_date?string("EEE, d MMM yyyy HH:mm:ss Z")}</pubDate>

    <#list published_posts as post>
    <item>
      <title>${post.title}</title>
      <pubDate>${post.date?string("EEE, d MMM yyyy HH:mm:ss Z")}</pubDate>
      <link>${config.site_host}/${post.uri}</link>
      <guid isPermaLink="true">${config.site_host}/${post.uri}</guid>
      <description>${post.body}</description>
    </item>
    </#list>
  </channel>
</rss>
