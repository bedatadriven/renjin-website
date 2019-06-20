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
            <p class="byline">
                Published by <span itemprop="author" itemscope itemtype="http://schema.org/Person">${content.author!"Maarten-Jan Kallen"}</span>
                on <time pubdate datetime="${content.date?string('yyyy-MM-dd')}" itemProp="datePublished">${content.date?string('yyyy-MM-dd')}</time>.
            </p>
            ${content.body}
            <hr />
            <p>Read more at <a href="/blog/">Renjin's blog</a> or subscribe to the blog's <a href="/feed.xml">RSS feed</a>.
        </article>
    </div>
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
