<nav id="nav" role="navigation">
  <a href="#nav" title="Show navigation">Show navigation</a>
  <a href="#" title="Hide navigation">Hide navigation</a>
  <ul>
    <#if active == "home">
    <li class="active"><a href="/index.html">Home</a></li>
    <#else>
    <li><a href="/index.html">Home</a></li>
    </#if>

    <#if active == "solutions">
    <li class="active"><a href="/solutions.html">Solutions</a></li>
    <#else>
    <li><a href="/downloads.html">Solutions</a></li>
    </#if>

    <#if active == "resources">
    <li class="active"><a href="#">Resources</a></li>
    <#else>
    <li><a href="#">Resources</a></li>
    </#if>
    <#if active == "blog">
    <li class="active"><a href="/blog">Blog</a></li>
    <#else>
    <li><a href="/blog">Blog</a></li>
    </#if>
    </ul>
</nav>
