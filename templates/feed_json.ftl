<#-- This template generates a JSON-formatted feed of the blog posts. This feed
is used by the BeDataDriven corporate site to include a list of (recent) posts
there as well. -->

{
  "posts": [ 
  <#list published_posts>
  <#items as post>
    {
      "title": "${post.title}",
      "date": "${post.date?string('yyyy-MM-dd')}",
      "url": "${config.site_host}/${post.uri}",
      "excerpt": "${post.excerpt}"
    }<#sep>,
  </#items>
  </#list>
  ]
}
