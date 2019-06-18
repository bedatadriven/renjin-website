<!DOCTYPE html>
<html lang="en">
  <#include "head.ftl">
  <body>
    <#assign active = "downloads">
    <#include "navigation.ftl">
    <#include "banner.ftl">
<main role="main">
  <div class="grid">
    <div class="medium-12 grid-item">
      <h1>Downloads</h1>

      <p>You can use Renjin as a standalone application, either in a simple GUI
      or from the command line, or as a package in a Java application. Select
      on of the download options and read about the prerequisites and the
      installation instructions below.</p>
    </div>
  </div>
  <div class="grid">
   <div class="medium-6 grid-item">
      <h2>Java Library</h2>
      <h4 class="sec">Available for all platforms</h4>
      <p>Add Renjin to any Java, Scala, or other JVM project and run R
      code with the standard Java Scripting API.</p>

      <div class="grid no-margin">
        <div class="grid-item medium-x">
            <a href="#maven" class="btn btn-large btn-warning" type="button"
            onclick="ga('send', 'event', 'Download', 'Click', 'Add to Maven Project');">Add to Maven Project</a>
        </div>
        <div class="grid-item medium-x">
		<a href="https://nexus.bedatadriven.com/service/local/artifact/maven/redirect?r=renjin-release&g=org.renjin&a=renjin-script-engine&c=jar-with-dependencies&v=${config.renjin_current}&e=jar" class="btn btn-large btn-warning" type="button" onclick="ga('send', 'event', 'Download', 'Click', 'Download Standalone Java Library');">Download Standalone .JAR</a>
        </div>

    </div>
  </div>
    <div class="medium-6 grid-item">
      <h2>Renjin Studio GUI</h2>
      <h4 class="sec">Available for all platforms</h4>
      <p>Renjin studio provides a very basic GUI to interact with the
      interpreter which works on all platforms with Java installed.</p>

      <div class="grid no-margin">
        <div class="grid-item medium-x">
		  <a href="https://nexus.bedatadriven.com/service/local/artifact/maven/redirect?r=renjin-release&g=org.renjin&a=renjin-studio&c=jar-with-dependencies&v=${config.renjin_current}" class="btn btn-large btn-warning" type="button" onclick="ga('send', 'event', 'Download', 'Click', 'Download Renjin Studio');">Download .JAR</a>
        </div>
    </div>
  </div>
  <div class="medium-6 grid-item">
    <h2>Command Line Tools</h2>
    <h4 class="sec">*nix and Mac OS X platforms</h4>
    <p>Prefer working in a terminal? Download one of the following packages.</p>
    <div class="grid no-margin">
     <div class="grid-item medium-x">
	     <a href="https://nexus.bedatadriven.com/service/local/artifact/maven/redirect?r=renjin-release&g=org.renjin&a=renjin-generic-package&v=${config.renjin_current}&e=zip" class="btn btn-large btn-warning" type="button" onclick="ga('send', 'event', 'Download', 'Click', 'Download Renjin ZIP archive');">Download .zip</a>
      </div>
      <div class="grid-item medium-x">
	      <a href="#apt" class="btn btn-large btn-warning" type="button">Install via APT</a>
    </div>
    </div>
    </div>
  </div>
  <div class="grid">
    <div class="medium-12 grid-item">
      <h2>Requirements</h2>
      <p>Renjin will run on any platform with a JVM installed. Therefore, if you want to run Renjin, you need to have installed at least version 8 (or greater) of the Java SE Runtime Environment (JRE). If you haven't, then download and install it from <a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">http://www.oracle.com/technetwork/java/javase/downloads/index.html</a></p>

      <h2>Running the GUI</h2>
      <p>The Swing-based Studio GUI is a very simple demo for the moment. Download the JAR file and double-click to execute, or start with the following command:</p>
      <pre>java -jar renjin-studio-{{ site.renjin-current }}-jar-with-dependencies.jar</pre>
      <p>where <code>{{ site.renjin-current }}</code> should be replaced with the version number.</p>

      <h2 id="apt">Debian and Ubuntu</h2>
      <p>You can add our APT repository and get regular updates automatically.</p>

      <pre>
# 1. Add the Renjin repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://packages.renjin.org:80 --recv-keys EB2514FC345926E9

# 2. Add the Renjin repository
echo deb http://packages.renjin.org/repo/apt stable main | sudo tee /etc/apt/sources.list.d/renjin.list

# 3. Update list of available packages
sudo apt-get update

# 4. Install Renjin
sudo apt-get install renjin
</pre>

      <h2 id="maven">Adding to a Maven Project</h2>

      <p>Using a a modern build tool such a Maven is definitely recommended, particularly
      if you're planning on including R packages which often have several levels of transitive dependencies.</p>

      <p>You can add Renjin to your Maven project by adding the following to your <code>pom.xml</code> file:</p>

<pre>&lt;dependencies&gt;
  &lt;dependency&gt;
    &lt;groupId&gt;org.renjin&lt;/groupId&gt;
    &lt;artifactId&gt;renjin-script-engine&lt;/artifactId&gt;
    &lt;version&gt;RELEASE&lt;/version&gt;
  &lt;/dependency&gt;
&lt;/dependencies&gt;
&lt;repositories&gt;
  &lt;repository&gt;
    &lt;id&gt;bedatadriven&lt;/id&gt;
    &lt;name&gt;bedatadriven public repo&lt;/name&gt;
    &lt;url&gt;https://nexus.bedatadriven.com/content/groups/public/&lt;/url&gt;
  &lt;/repository&gt;
&lt;/repositories&gt;
</pre>

     <p>You can find details on adding Renjin to your

	<a href="http://docs.renjin.org/en/latest/library/project-setup.html#gradle">Gradle</a>,
        <a href="http://docs.renjin.org/en/latest/library/project-setup.html#scala-build-tool-sbt">SBT</a>, and other types of projects in our
	 <a href="http://docs.renjin.org/en/latest/library/project-setup.html">Project Setup Guide</a>.
      </div>
    </div>
  </div>
</main>
    <#include "footer.ftl">
    <#include "tracking.ftl">
  </body>
</html>
