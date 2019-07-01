<footer>
  <div>
    <div>
      <h3>Downloads</h3>
      <p>Take a look at our <a href="/downloads.html">download page</a>, or choose one of our downloads directly. </p>
      <ul>
        <li><a href="http://nexus.bedatadriven.com/service/local/artifact/maven/redirect?r=renjin-release&g=org.renjin&a=renjin-debian-package&v=${config.renjin_current}&e=deb" onclick="ga('send', 'event', 'Download', 'Click', 'Download Debian package');">Renjin CLI for Debian/Ubuntu [.deb]</a></li>
        <li><a href="http://nexus.bedatadriven.com/service/local/artifact/maven/redirect?r=renjin-release&g=org.renjin&a=renjin-studio&v=${config.renjin_current}&e=jar" onclick="ga('send', 'event', 'Download', 'Click', 'Download Renjin Studio');">Renjin Studio (GUI) for all platforms [.jar]</a></li>
        <li><a href="http://nexus.bedatadriven.com/service/local/artifact/maven/redirect?r=renjin-release&g=org.renjin&a=renjin-script-engine&c=jar-with-dependencies&v=${config.renjin_current}&e=jar" onclick="ga('send', 'event', 'Download', 'Click', 'Download Renjin script-engine');">Renjin Script Engine for Java projects [.jar]</a></li>
      </ul>
    </div>
    <div>
      <h3>Resources</h3>
      <p>Learn how to use Renjin interactively or in Java projects:</p>
      <ul>
        <li><a href="http://docs.renjin.org/">Official documentation</a></li>
        <li><a href="http://javadoc.renjin.org">Renjin Javadoc</a></li>
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
      <p>This project is an initiative of <a
          href="http://www.bedatadriven.com" rel="nofollow">BeDataDriven</a>, a company
      providing consulting in analytics and decision support systems. Read
      about our <a href="/support.html">support options for Renjin</a>.</p>
    </div>
  </div>
</footer>
