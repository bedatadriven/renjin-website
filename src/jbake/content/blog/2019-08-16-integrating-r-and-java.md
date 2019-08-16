title=Integrating R and Java
date=2019-08-16
type=post
status=published
author=Alexander Bertram
lang=en
excerpt=Renjin makes it easy to integrate R and Java in two steps.
~~~~~~

Renjin makes it very easy to integrate R and Java in three quick steps:

First, add Renjin as a dependency to your Maven project:

```.xml
    <dependencies>
      <dependency>
        <groupId>org.renjin</groupId>
        <artifactId>renjin-script-engine</artifactId>
        <version>3.5-beta65</version>
      </dependency>
    </dependencies>
```

For this to work you will also need to add BeDataDriven’s public repository to your pom.xml:

```.xml
    <repositories>
      <repository>
        <id>bedatadriven</id>
        <name>bedatadriven public repo</name>
        <url>https://nexus.bedatadriven.com/content/groups/public/</url>
      </repository>
    </repositories>
```


If you're not using Maven, you can find comparable instructions for
all major JVM-based build tools in our [Project Setup Guide](http://docs.renjin.org/en/latest/library/project-setup.html)

Once you have the dependency added, you can create a new RenjinScriptEngine:

```.java
    import javax.script.*;
    import org.renjin.script.*;

    // ... add additional imports here ...

    public class TryRenjin {
      public static void main(String[] args) throws Exception {
        // create a script engine manager:
        RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();

        // create a Renjin engine:
        ScriptEngine engine = factory.getScriptEngine();

        engine.eval("df <- data.frame(x=1:10, y=(1:10)+rnorm(n=10))");
        engine.eval("print(df)");
        engine.eval("print(lm(y ~ x, df))");
      }
    }
```

That's it! You're now calling R from Java.

Visit our [documentation](http://docs.renjin.org/en/latest/library/index.html) for
more details and advanced use cases.