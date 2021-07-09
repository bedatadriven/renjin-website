<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body class="home">
<#assign active = "">
<#include "navigation.ftl">

<header class="hero">
  <div>
    <div>
      <h1>Bring the Power of R<br>to Java</h1>
      <h2>Renjin is the JVM-based interpreter for the R language</h2>
    </div>
    <div class="btn-group">
      <a href="#quickstart" class="btn">Quick start</a>
    </div>
  </div>
</header>

<main class="landing">

  <div>
    <div>
      <h1>Seamless integration between R and Java</h1>

      <ul>
        <li>Embed Renjin directly in your Java project as a library</li>
        <li>Zero-overhead data sharing between R and Java</li>
        <li>Pure-Java versions of CRAN and BioConductor packages</li>
        <li>Multi-threaded execution</li>
      </ul>
    </div>
  </div>

  <div>
    <div>
      <h1 id="quickstart">Quick start with Java</h1>

      <div class="quickstart">

        <div class="quickstart__block">
          <h2>// Add Renjin as a dependency to pom.xml or build.gradle</h2>
        </div>
        <div class="quickstart__block">
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
      </div>

      <a href="http://docs.renjin.org/en/latest/library/project-setup.html" class="btn">Read the complete guide ⟶</a>
    </div>
  </div>

  <div>
    <div class="casestudy">

      <div class="casestudy__body">
        <h1>Deploy R code faster and hassle-free</h1>

        <p>Learn how OpsFactor uses Renjin to deploy their supply-chain optimization system to Amazon Beanstalk, combining
          an R-language model built on the <span class="package">forecast</span> package with a Java web application.</p>

        <#--        <p>Renjin transforms CRAN and BioConductor packages — even those with Fortran, C, and C++ code — to-->
        <#--        platform-independent, pure Java libraries that can be deployed with your existing JVM-based tooling. </p>-->

        <a href="/casestudy/opsfactor.html" class="btn">Read the case study ⟶</a>
      </div>

      <div class="casestudy__graphic">
        <img src="assets/img/opsfactor.png" alt="OpsFactor Logo">
      </div>
    </div>
  </div>

  <div>
    <div class="casestudy">

      <div class="casestudy__graphic casestudy--flipped">
        <img src="assets/img/iccube.png" alt="Workstation running icCube">
      </div>
      <div class="casestudy__body">

        <h1>Extend your Java application with the power of R</h1>

        <p>Business intelligence vendor icCube relies on Renjin empower their customers
          with the rich capabilities of the R language for statistical analysis.</p>

        <p>Renjin is licensed under the GPL v2, but can be used to build plugins for commercial
          software applications.</p>

        <a href="/casestudy/iccube.html" class="btn">Read the case study ⟶</a>
      </div>
    </div>
  </div>
  <#include "cta-block.ftl">
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
