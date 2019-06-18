<!DOCTYPE html>
<html lang="en">
  <#include "head.ftl">
  <body>
    <#assign active = "blog">
    <#include "navigation.ftl">
    <#include "banner.ftl">
    <main role="main">
      <div class="grid">
	      <div class="medium-12 grid-item">
          ${content.body}

          <h2>Articles</h2>
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
