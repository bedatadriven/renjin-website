<head>
  <meta charset="utf-8" />
  <title>Renjin | Integrating R and Java | ${content.title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta property="og:title" content="Renjin | ${content.title}" />
  <meta property="og:utl" content="${config.site_host}/${content.uri}" />
  <meta property="og:image" content="${config.site_host}/assets/img/renjin-logo-thumbnail.png" />
  <#if content.description?? >
  <meta name="description" property="og:description" content="${content.description}">
  <#elseif content.excerpt?? >
  <meta name="description" property="og:description" content="${content.excerpt}">
  </#if>
  <link href="/css/style.css" rel="stylesheet" media="all">
</head>
