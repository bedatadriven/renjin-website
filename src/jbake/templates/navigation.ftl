<nav id="nav" role="navigation">
  <a href="#nav" title="Show navigation">Show navigation</a>
  <a href="#" title="Hide navigation">Hide navigation</a>
  <ul>
    <#if active == "home">
    <li class="active"><a href="/index.html">Home</a></li>
    <#else>
    <li><a href="/index.html">Home</a></li>
    </#if>
    <#if active == "downloads">
    <li class="active"><a href="/downloads.html">Downloads</a></li>
    <#else>
    <li><a href="/downloads.html">Downloads</a></li>
    </#if>
    <#if active == "packages">
    <li class="active"><a href="http://packages.renjin.org">Packages</a></li>
    <#else>
    <li><a href="http://packages.renjin.org">Packages</a></li>
    </#if>
    <#if active == "documentation">
    <li class="active"><a href="http://docs.renjin.org">Documentation</a></li>
    <#else>
    <li><a href="http://docs.renjin.org">Documentation</a></li>
    </#if>
    <#if active == "support">
    <li class="active"><a href="/support.html">Support</a></li>
    <#else>
    <li><a href="/support.html">Support</a></li>
    </#if>
    <#if active == "about">
    <li class="active"><a href="/about.html">About</a></li>
    <#else>
    <li><a href="/about.html">About</a></li>
    </#if>
    <#if active == "blog">
    <li class="active"><a href="/blog">Blog</a></li>
    <#else>
    <li><a href="/blog">Blog</a></li>
    </#if>
    </ul>
</nav>
