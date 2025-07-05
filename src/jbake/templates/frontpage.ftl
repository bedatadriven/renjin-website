<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body>
<#assign active = "">
<#include "navigation.ftl">
<#include "banner.ftl">

<main class="landing">

  <div>
    <div>
      <h1>Renjin is a JVM-based interpreter for the R language</h1>

      <p>Renjin was developed between 2010 and 2021 but is no longer actively maintained.<p>

      <p>Read more about the project here or browse the source code on <a href="https://github.com/bedatadriven/renjin">GitHub</a>.</p>

    <h2>Blog archive</h2>
   <#list published_posts>
        <ul>
          <#items as post>
            <li>
              <p><a href="/${post.uri}">${post.title} (${post.date?string('yyyy-MM-dd')})</a></p>
              <p>${post.excerpt}</p>
            </li>
          </#items>
        </ul>
        </#list>
    </div>
  </div>

</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
