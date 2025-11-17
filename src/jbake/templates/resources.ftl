<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body>
<#assign active = "resources">
<#include "navigation.ftl">
<#include "banner.ftl">
<main role="main">
    <div>
        <h1>Resources</h1>

        <h2 id="downloads">Downloads</h2>
        <p>You can use Renjin as a standalone application, or integrated into any Java application.
        Take a look at the <a href="/downloads.html">download page</a> for more information.</p>

        <h2>Documentation</h2>

        <p>You can find comprehensive <a href="https://docs.renjin.org">documentation</a> on Renjin, including: </p>

        <ul>
            <li><a href="https://docs.renjin.org/en/latest/library/index.html">Using Renjin as a Java Library</a></li>
            <li><a href="https://docs.renjin.org/en/latest/interactive/index.html">Using Renjin from the Command Line</a></li>
        </ul>

        <h2 id="case-studies">Case Studies</h2>

        <p>Renjin has evolved from a research project into a stable solution used by companies and researchers
            to improve their development workflows.</p>

        <ul>
            <li><a href="/casestudy/opsfactor.html">OpsFactor: Deploying a hybrid Java and R solution with
                    Amazon Beanstalk.</a></li>
            <li><a href="/casestudy/iccube.html">icCube: Building an R-language plugin with Renjin for a
                    Java-based business intelligence software package</a></li>
            <li><a href="/blog/2017-08-10-processing-r.html">Processing.R enables users to write Processing sketches in R.</a></li>
        </ul>

        <h2 id="related-projects">Related Projects</h2>
        <p>There are several other open source projects that are built for or on Renjin.
        This list does not include Renjin specific packages (they are, if contributed (see Packages section below), available on
        <a href="https://packages.renjin.org">packages.renjin.org</a>)</p>

        <ul>
            <li><a href="https://github.com/perNyfelt/ride" target="_blank">Ride</a>:
                A nice R development environment, somewhat similar to R Studio, for the Renjin JVM implementation of R</li>
            <li><a href="https://github.com/perNyfelt/munin" target="_blank">Munin</a>:
                A reporting server for reports created in R based on Renjin and Spring Boot.
            </li>
            <li><a href="https://github.com/perNyfelt/renjin-spring-boot-starter" target="_blank">Renjin Spring Boot Starter</a>:
                A Spring Boot Starter to easily and quickly run Renjin R code in a Spring Boot application</li>
            <li><a href="https://github.com/rbotafogo/scicom" target="_blank">SciCom</a>:
                (Scientific Computing) for Ruby brings the power of R (through Renjin) to the
                <a href="https://rubygems.org/gems/scicom/versions/0.4.1-java" target="_blank">Ruby community</a>.
            </li>
            <li><a href="https://github.com/scicloj/clojisr" target="_blank">ClojisR</a>:
                Clojure speaks statistics - a bridge between Clojure to R</li>
        </ul>

        <h2>Packages</h2>
        <p>Packages is the way that R is extended with additional functionality.<br>
        Builds of CRAN and BioConductor packages for Renjin are available from our repository:</p>
        <ul>
            <li><a href="http://packages.renjin.org/packages">Browse packages A-Z</a></li>
        </ul>
        <p>
            Packages created specifically for Renjin (and hence not on CRAN or BioConductor) can also be found in the above link.
            If you are a package creator/maintainer that have a Renjin package published to Maven Central you can fill in
            <a href="https://packages.renjin.org/packages/contribute">this form</a> to add it to our list of packages.
        </p>
    </div>
</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
