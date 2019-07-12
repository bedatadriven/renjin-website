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
      <a href="#quickstart" class="btn">Quick start for free</a>
      <a href="/enterprise.html" class="btn">Upgrade to Renjin Enterprise Support</a>
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
    <div>
      <h1 id="professional">Renjin Enterprise Support</h1>

      <p>For mission-critical applications, purchase an annual support subscription that includes:</p>

      <ul>
        <li>Long-term support for Renjin Certified Releases</li>
        <li>48-hour SLA for critical defects</li>
        <li>Early-access to bug fixes</li>
        <li>Access to Java 6 and Java 7 compatible builds</li>
      </ul>
      <a href="/enterprise.html" class="btn">Details &amp; Pricing ⟶</a>
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


<#--  <div>-->
<#--    <div>-->
<#--      <h1>Subscribe to our newsletter</h1>-->
<#--      <form action="https://renjin.us7.list-manage.com/subscribe/post?u=d15c4a781ddc4b9bdcec62993&amp;id=57c04ae38b" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>-->
<#--        <!-- first row &ndash;&gt;-->
<#--        <div>-->
<#--          <div>Receive updates about releases, packages, and other news right in your inbox.-->
<#--            Curious? Have a look at the newsletter archive.</div>-->
<#--          <div class="mc-field-group">-->
<#--            <input type="email" placeholder="Please enter your work email" required value="" name="EMAIL" class="required email" id="mce-EMAIL">-->
<#--          </div>-->
<#--          <div>-->
<#--           <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="btn">-->
<#--          </div>-->
<#--        </div>-->

<#--        <div id="mergeRow-gdpr" class="mergeRow gdpr-mergeRow content__gdprBlock mc-field-group">-->
<#--          <div class="content__gdpr">-->
<#--            <label>Marketing Permissions</label>-->
<#--            <p>Please click the box if you would like to hear from BeDataDriven B.V. and Renjin via email:</p>-->
<#--            <fieldset class="mc_fieldset gdprRequired mc-field-group" name="interestgroup_field">-->
<#--              <label class="checkbox subfield" for="gdpr_28397"><input type="checkbox" id="gdpr_28397" name="gdpr[28397]" value="Y" class="av-checkbox "><span>I want to receive the Renjin Newsletter</span> </label><label class="checkbox subfield" for="gdpr_28577"><input type="checkbox" id="gdpr_28577" name="gdpr[28577]" value="Y" class="av-checkbox "><span>I want to receive updates about Renjin Enterprise Support</span> </label>-->
<#--            </fieldset>-->
<#--            <p>By clicking on "Subscribe" below, you agree that BeDataDriven may collect and use your personal data - provided in this form - for sharing marketing material and other updates regarding Renjin that you agree to receive, in accordance with our Privacy Policy.-->

<#--              You can unsubscribe at any time by clicking the link in the footer of our emails. We will treat your information with respect.-->

<#--              For information about our privacy practices, please visit our website.</p>-->
<#--          </div>-->
<#--          <div class="content__gdprLegal">-->
<#--            <p>We use Mailchimp as our marketing platform. By clicking below to subscribe, you acknowledge that your information will be transferred to Mailchimp for processing. <a href="https://mailchimp.com/legal/" target="_blank">Learn more about Mailchimp's privacy practices here.</a></p>-->
<#--          </div>-->
<#--        </div>-->
<#--        <div id="mce-responses" class="clear">-->
<#--          <div class="response" id="mce-error-response" style="display:none"></div>-->
<#--          <div class="response" id="mce-success-response" style="display:none"></div>-->
<#--        </div>    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups&ndash;&gt;-->
<#--        <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_d15c4a781ddc4b9bdcec62993_57c04ae38b" tabindex="-1" value=""></div>-->
<#--        <div class="clear"></div>-->
<#--      </form>-->
<#--    </div>-->
<#--  </div>-->
  <#include "cta-block.ftl">
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
