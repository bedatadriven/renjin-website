<!DOCTYPE html>
<html lang="en">
  <#include "head.ftl">
  <body class="home">
    <#assign active = "home">
    <#include "navigation.ftl">
    <#include "frontpage_banner.ftl">
<main>
  <div class="usp">
  <h1 class="accent">Why Renjin?</h1>
  <div class="grid">
    <div class="medium-4 grid-item">
      <a href="#" class="icon-database blocklink">
        <h3>Bigger data</h3>
        <p>Renjin will allow R scripts to transparently interact with data wherever it’s stored, whether that’s on disk, in a remote database, or in the cloud.</p>
      </a>
    </div>

    <div class="medium-4 grid-item">
      <a href="#" class="icon-fire blocklink">
        <h3>Better performance</h3>
        <p>Renjin offers performance improvements in executing R code using techniques such as deferred computation, implicit paralellism, and just-in-time compilation.</p>
      </a>
    </div>

    <div class="medium-4 grid-item">
      <a href="#" class="icon-cloud blocklink">
        <h3>Cloud-ready</h3>
        <p>Renjin enables R developers to deploy their code to Platform-as-a-Service providers like Google Appengine, Amazon Beanstalk or Heroku.</p>
      </a>
    </div>

    <div class="medium-4 grid-item">
      <a href="#" class="icon-attach blocklink">
        <h3>Enterprise integration</h3>
        <p>Built on the JVM, Renjin allows R code to interact directly with JVM libraries and data structures, without the need for expensive data transfer or brittle inter-process communication.</p>
      </a>
    </div>

    <div class="medium-4 grid-item">
      <a href="#" class="icon-truck blocklink">
        <h3>More productive development</h3>
        <p>With Renjin, analysts can move directly from prototype to production. There is no need to port R code to C++ or Java for production use.</p>
      </a>
    </div>

    <div class="medium-4 grid-item">
      <a href="#" class="icon-diamond blocklink">
        <h3>Open source and cutting edge</h3>
        <p>Like R itself, the Renjin source code is available under an open-source license. That means you get to stand on the shoulders of giants at little or no cost</p>
      </a>
    </div>
  </div>
  </div>
  <div class="row">
    <div class="grid newsletter">
      
      <div class="medium-6 grid-item">
        <h3>Subscribe to our newsletter</h3>
        <p>Receive updates about releases, packages, and other news right in your inbox.
        Curious? <a href="https://us7.campaign-archive.com/home/?u=d15c4a781ddc4b9bdcec62993&id=57c04ae38b">Have a look at the newsletter archive.</a></p>
      </div>
      <div class="medium-6 grid-item">
        <div id="mc_embed_signup">
          <form action="https://renjin.us7.list-manage.com/subscribe/post?u=d15c4a781ddc4b9bdcec62993&amp;id=57c04ae38b" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate="">
              <label for="mce-EMAIL" id="mc-embedded-label"><input type="email" value="" name="EMAIL" class="required email" id="mce-EMAIL" placeholder="email address"></label>
              <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" onclick="ga('send', 'event', 'Form', 'Submit', 'Newsletter sign-up');">
                  <div class="response" id="mce-error-response"></div>
                  <div class="response" id="mce-success-response"></div>
              </div>

          </form>
          </div>
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
