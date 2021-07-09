<footer>
  <div>
    <div>
      <h3>Downloads</h3>
      <p>Take a look at our <a href="/downloads.html">download page</a>.</p>
    </div>
    <div>
      <h3>Resources</h3>
      <ul>
        <li><a href="http://docs.renjin.org/">Documentation</a></li>
        <li><a href="/resources.html#case-studies">Case studies</a></li>
      </ul>
    </div>
    <div>
      <h3>Contribute</h3>
      <p>Renjin is an open-source project. Go to the <a href="https://github.com/bedatadriven/renjin/">source code on GitHub</a>.</p>
    </div>
    <div>
      <h3>Packages</h3>
      <p>Take a look at our <a href="http://packages.renjin.org">package
          repository browser</a> for the state of compatibility of CRAN
      packages in Renjin. </p>
    </div>
    <div>
      <h3>News</h3>
     <#assign count = 0>
     <#list published_posts>
      <ul>
        <#items as post>
          <#if count == 3><#break></#if>
          <li><a href="/${post.uri}">${post.title} (${post.date?string('yyyy-MM-dd')})</a></li>
          <#assign count++>
        </#items>
      </ul>
     </#list>
    </div>
    <div>
      <h3>Support</h3>
      <ul>
        <li><a href="https://groups.google.com/g/renjin-dev">Mailing list</a></li>
        <li><a href="http://stackoverflow.com/questions/tagged/renjin">StackOverflow</a></li>
      </ul>
    </div>
  </div>
</footer>
