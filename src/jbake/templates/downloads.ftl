<!DOCTYPE html>
<html lang="en">
<#include "head.ftl">
<body>
<#assign active = "downloads">
<#include "navigation.ftl">
<#include "banner.ftl">
<main role="main">
    <div>
        <h1>Downloads</h1>

        <p>You can use Renjin as a standalone application, either in a simple
        GUI or from the command line, or as a package in a Java application.
        Select on of the download options and read about the prerequisites and
        the installation instructions below.</p>

        <h2>Java Library</h2>
        <h4 class="sec">Available for all platforms</h4>
        <p>Add Renjin to any Java, Scala, or other JVM project and run R code
          with the standard Java Scripting API. You can find details on adding
          Renjin to your Gradle, SBT, and other types of projects in our
          <a href="https://docs.renjin.org/en/latest/library/project-setup.html">
            Project Setup Guide
          </a>
          .
        </p>

        <h2>Renjin Studio GUI</h2>
        <h4 class="sec">Available for all platforms</h4>
        <p>The Renjin Studio GUI is no longer maintained. If you'd like to use
          Renjin in a GUI we recommend that you try out
          <a href="https://github.com/perNyfelt/ride">
            Ride
          </a>
          .
        </p>

        <h2>Command Line Tools</h2>
        <h4 class="sec">*nix and macOS platforms</h4>
        <p>Prefer working in a terminal? Download a ZIP archive with the latest
        build and look in the <code>bin</code> folder for the
        <code>renjin</code> executable.</p>

        <div class="btn-group">
          <a href="https://www.renjin.org/repo/dist/${config.renjin_current}.zip"
            class="btn btn-large btn-warning"
            type="button"
            onclick="ga('send', 'event', 'Download', 'Click', 'Download Renjin ZIP archive');">
            Download .zip
          </a>
        </div>

        <h2>Requirements</h2>
        <p>Renjin will run on any platform with a JVM installed. Therefore, if
          you want to run Renjin, you need to have installed at least version 8
          (or greater) of the Java SE Runtime Environment (JRE). If you
          haven't, then download and install it from
          <a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">
            http://www.oracle.com/technetwork/java/javase/downloads/index.html
          </a>
          .
        </p>

    </div>
    <#include "cta-block.ftl">

</main>
<#include "footer.ftl">
<#include "tracking.ftl">
</body>
</html>
