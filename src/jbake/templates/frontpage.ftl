<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body class="home">
<#assign active = "home">
<#include "navigation.ftl">
<#include "frontpage_banner.ftl">
<main>
  <div class="row">
    <div class="grid">
      <div class="medium-12 grid-item">
        <h1>Quick start</h1>

        <div class="quickstart">
          <div class="quickstart__block">
<#--            <h2>// Add Renjin to your Maven, Gradle, Scala, or Clojure project in minutes</h2>-->
            <div>RenjinScriptEngine engine = new RenjinScriptEngine();</div>
          </div>
          <div class="quickstart__block">
            <h2>// Evaluate R inline</h2>
            <div>engine.eval("<span class="r">df <- data.frame(x = 1:10, y = rnorm(n = 10))</span>");</div>
            <div>engine.eval("<span class="r">print(lm(y ~ x, df))</span>");</div>
          </div>
          <div class="quickstart__block">
            <h2>// Use CRAN and BioConductor packages</h2>
            <div>engine.eval("<span class="r">ggplot2::qplot(x, y, data = df)</span>")</div>
          </div>
          <div class="quickstart__block">
            <h2>// Evaluate external R script</h2>
            <div>engine.eval(new java.io.FileReader("script.R"));</div>
          </div>

          <a href="http://docs.renjin.org/en/latest/library/project-setup.html" class="readmore">Read the complete guide ⟶</a>
        </div>
      </div>
      <#--      <div class="medium-4 grid-item">-->
      <#--        <p class="quickstart__docs">Read more about adding Renjin to your <a href="http://docs.renjin.org/en/latest/library/project-setup.html#maven">Maven</a>,-->
      <#--          <a href="http://docs.renjin.org/en/latest/library/project-setup.html#gradle">Gradle</a>,-->
      <#--          <a href="http://docs.renjin.org/en/latest/library/project-setup.html#scala-build-tool-sbt">Scala</a>, or-->
      <#--          <a href="http://docs.renjin.org/en/latest/library/project-setup.html#spark">Spark</a> project,-->
      <#--          <a href="http://docs.renjin.org/en/latest/interactive/index.html#using-packages">using packages from CRAN or BioConductor</a>,-->
      <#--          <a href="http://docs.renjin.org/en/latest/library/moving-data-between-java-and-r-code.html">sharing data between R and Java</a>,-->
      <#--          <a href="http://docs.renjin.org/en/latest/library/thread-safety.html">multi-threaded execution</a>.</p>-->
      <#--      </div>-->

    </div>
  </div>

  <div class="row casestudy">
    <div class="grid">

      <div class="medium-8 grid-item">

        <h1>Deploy R code faster and hassle-free</h1>

        <p>Learn how OpsFactor uses Renjin to deploy their supply-chain optimization system to Amazon Beanstalk, combining
          an R-language model built on the <span class="package">forecast</span> package with a Java web application.</p>

        <#--        <p>Renjin transforms CRAN and BioConductor packages — even those with Fortran, C, and C++ code — to-->
        <#--        platform-independent, pure Java libraries that can be deployed with your existing JVM-based tooling. </p>-->

        <a href="/casestudy/opsfactor.html" class="readmore">Read the case study ⟶</a>

      </div>
      <div class="medium-4 grid-item">
        <img src="assets/img/opsfactor.png" alt="OpsFactor Logo">
      </div>
    </div>
  </div>

  <div class="row certified">
    <div class="grid">
      <div class="medium-12 grid-item">

        <h1>Certified Releases</h1>

        <p>For mission-critical applications, purchase an annual support subscription that includes:</p>

        <ul>
          <li>Long-term support for Renjin Certified Build</li>
          <li>48-hour SLA for critical defects</li>
          <li>Early-access to bug fixes</li>
        </ul>
        <a href="/casestudy/opsfactor.html" class="readmore">Details &amp; Pricing ⟶</a>
      </div>
    </div>
  </div>

  <div class="row casestudy">
    <div class="grid">
      <div class="medium-4 grid-item">
        <img src="assets/img/iccube.png" alt="Workstation running icCube">
      </div>
      <div class="medium-8 grid-item">

        <h1>Extend your Java application with the power of R</h1>

        <p>Business intelligence vendor icCube relies on Renjin empower their customers
          with the rich capabilities of the R language for statistical analysis.</p>

        <p>Renjin is licensed under the GPL v2, but can be used to build plugins for commercial
          software applications.</p>

        <a href="/casestudy/iccube.html" class="readmore">Read the case study ⟶</a>
      </div>
    </div>
  </div>

  <div class="row-dark news">
    <div class="grid">
      <h2 class="accent">Latest news</h2>
      <div class="medium-6 grid-item">
        <#assign count = 0>
        <#list published_posts>
          <#items as post>
            <#if count == 3><#break></#if>
            <a href="/${post.uri}" class="newsitem blocklink">
              <h4>${post.title}</h4>
              <p>${post.excerpt}</p>
              <div class="meta">Published on ${post.date?string('yyyy-MM-dd')}</div>
              <div class="readmore">Read more</div>
            </a>
            <#assign count++>
          </#items>
          </ul>
        </#list>
      </div>

      <div class="medium-6 grid-item">
        <a href="http://packages.renjin.org" class="block blocklink">
          <h3>Packages</h3>
          <p>CRAN packages are automatically built and tested against Renjin.
            Many of them can be loaded directly into Renjin without the need to
            install them first.</p>
          <div class="readmore">Go to the package repository</div>
        </a>

        <a href="/support.html" class="block blocklink">
          <h3>Commercial support</h3>
          <p>Renjin is a project initiated by BeDataDriven, a company
            providing consulting in analytics and decision support systems. We
            also provide commercial support for Renjin.</p>
          <div class="readmore">Check your support options</div>
        </a>
      </div>
    </div>
  </div>
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
