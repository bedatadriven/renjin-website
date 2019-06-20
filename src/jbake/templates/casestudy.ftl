<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body>
<#assign active = "blog">
<#include "navigation.ftl">
<#include "banner.ftl">
<main role="main">
  <div>
    <article itemscope itemtype="http://schema.org/BlogPosting">
      <h1 itemprop="name headline">${content.title}</h1>
      ${content.body}
    </article>
  </div>
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
