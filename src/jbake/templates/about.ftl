<!DOCTYPE html>
<html lang="en">
  <#include "head.ftl">
  <body>
    <#assign active = "about">
    <#include "navigation.ftl">
    <#include "banner.ftl">
<main role="main">
  <div class="grid">
    <div class="medium-12 grid-item">
      <h1>Why Renjin</h1>
      <p>The Renjin project is a direct result of our own need for
      a more performant interpreter for the R programming language and the
      ability to integrate the interpreter in scalable web applications. Read
      more about some of the benefits that Renjin provides over GNU R and get
      started!</p>
    </div>
  </div>
  <div class="usp usp-followup">
    <div class="grid">
      <div class="medium-12 grid-item">
        <div class="grid">
          <div class="medium-4 grid-item icon-database">
            <h3>Bigger data</h3>
            <p>Renjin will allow R scripts to transparently interact with data
            wherever it’s stored, whether that’s on disk, in a remote database,
            or in the cloud.</p>
          </div>
          <div class="medium-8 grid-item">
            <p>R has been traditionally limited by the need to fit data sets
            into memory, and working with even modest sets of data can quickly
            exhaust memory due to historical limitations in GNU R interpreter’s
            implementation.</p>
            <p>While there have been attempts to bring big data to the original
            interpreter, these have generally provided a parallel set of data
            structures and algorithms, threatening a fragmentation of the
            language and platform. Renjin, in contrast, will allow existing R
            code to run on larger datasets with no modification, using R’s
            familiar and standard data structures and algorithms.</p>
          </div>
        </div>
      </div>

      <div class="medium-12 grid-item">
        <div class="grid">
          <div class="medium-4 grid-item icon-fire">
            <h3>Better performance</h3>
            <p>Renjin offers performance improvements in executing R code on
            several fronts: Vector operations, Matrix operations, Scalar
            operations.</p>
          </div>
          <div class="medium-8 grid-item">
            <ul><li><strong>Vector operations:</strong> Renjin’s deferred
                computation engine automatically parallelizes and optimizes
                vector operation to run an order of magnitude faster, without
                the memory demands of computing intermediate structures,</li>
                <li><strong>Matrix operations:</strong> Renjin allows the user
                to plugin best-of-class implementations of BLAS, LAPACK, and
                FFT,</li>
                <li><strong>Scalar operations:</strong> Renjin will compile
                    frequently used portions of R code to JVM byte code on the
                    fly, dramatically increasing performance of R’s notorious
                    performance on for loops and other predominantly scalar
                    code.</li>
                </ul>
                <p>These improvements make it possible to perform real-time
                analyses using complex models.</p>
          </div>
        </div>
      </div>

      <div class="medium-12 grid-item">
        <div class="grid">
          <div class="medium-4 grid-item icon-cloud">
            <h3>Cloud-ready</h3>
            <p>Renjin enables R developers to deploy their code to
            Platform-as-a-Service providers like Google Appengine, Amazon
            Beanstalk or Heroku.</p>
          </div>
          <div class="medium-8 grid-item">
            <p>Renjin enables R developers to deploy their code to
            Platform-as-a-Service providers like Google Appengine, Amazon
            Beanstalk or Heroku without worrying about scale or infrastructure.
            Renjin is pure Java - it can run anywhere.</p>
          </div>
        </div>
      </div>

      <div class="medium-12 grid-item">
        <div class="grid">
          <div class="medium-4 grid-item icon-attach">
          <h3>Seamless integration</h3>
          <p>Renjin will allow existing R code to run on larger datasets with
          no modification, using R’s familiar and standard data structures and
          algorithms.</p>
        </div>
        <div class="medium-8 grid-item">
            <p>Built on the JVM, Renjin allows R code to interact directly with
            JVM libraries and data structures, without the need for expensive
            data transfer or brittle inter-process communication.</p>
            <p>Java and Scala developers can expose their data directly to R
            scripts by implementing a simple interface. To the R developer, the
            data looks no different than a normal R data structure.</p>
            <p>Renjin runs safely in multithreaded application servers,
            allowing embedders to create as many independent “apartments” to
            run existing single-threaded R code, or to allow multi- threaded
            access if the user’s R code is written in a pure, functional
            manner. Renjin allows developers to choose the right language for
            the different components of an enterprise system, without worrying
            how they’ll interact.</p>
          </div>
        </div>
      </div>

      <div class="medium-12 grid-item">
        <div class="grid">
          <div class="medium-4 grid-item icon-truck">
          <h3>More productive cycle</h3>
          <p>With Renjin, analysts can move directly from prototype to production.</p>
        </div>
        <div class="medium-8 grid-item">
            <p>Many enterprises will prototype analyses and models in R because
            of it’s ease of use, but then port the results to Java/C++ for
            production use, either because of performance limitations or due to
            poor interoperability between the original R VM and other
            enterprise systems.</p>
            <p>With Renjin, analysts can move directly from prototype to
            production. R scripts can be packaged as JARs and called directly
            from JVM-based environments and referenced directly by other JVM
            languages like Java, Scala, JRuby, or Clojure.</p>
          </div>
        </div>
      </div>

      <div class="medium-12 grid-item">
        <div class="grid">
          <div class="medium-4 grid-item icon-diamond">
          <h3>Open source and cutting edge</h3>
          <p>Like R itself, the Renjin source code is available under an
          open-source license.</p>
        </div>
        <div class="medium-8 grid-item">
          <p>Like R itself, the Renjin source code is available under an
          open-source license. That means you get to stand on the shoulders of
          giants at little or no cost.</p>
          <p>What's more, compatibility with existing CRAN packages is a top
          priority for the project therefore you have access to a huge number
          of extension packages, many of which are the result of cutting edge
          statistical research.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
</main>
    <#include "footer.ftl">
    <#include "tracking.ftl">
  </body>
</html>
