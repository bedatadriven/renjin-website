<!DOCTYPE html>
<html lang="en">
  <#include "head.ftl">
  <body>
    <#assign active = "support">
    <#include "navigation.ftl">
    <#include "banner.ftl">
<main role="main">
  <div class="grid">
    <div class="medium-12 grid-item">
      <h1>Support</h1>
    </div>
  </div>
  <div class="grid">
    <div class="medium-6 grid-item">
      <h2>Free support</h2>

      <p>Start by browsing the relevant <a
          href="http://docs.renjin.org">documentation</a> to see if you can find an
      answer to your question.</p>

      <p>You can review questions and answers on the
        <a href="http://stackoverflow.com/questions/tagged/renjin">Renjin tag on StackOverflow.com</a>.</p>

      <p>If Renjin does not produce an expected result, you can open an issue on our
        <a href="https://github.com/bedatadriven/renjin/issues">GitHub project</a>.
      </p>

    </div>
    <div class="medium-6 grid-item">
      <h2>Renjin Enterprise Support</h2>

      <p>For fast, predictable support for any issues with Renjin, purchase an annual support contract
      for Renjin that includes:</p>

      <ul>
        <li>Long-term support for Renjin Certified Releases</li>
        <li>48-hour SLA for critical defects</li>
        <li>Early-access to bug fixes</li>
        <li>Access to Java 6 and Java 7 compatible builds</li>
      </ul>
      <a href="/enterprise.html" class="btn">Details &amp; Pricing ⟶</a>
    </div>
  </div>
</main>
    <#include "footer.ftl">
    <#include "tracking.ftl">
  </body>
</html>

