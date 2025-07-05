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
      <h2>Resources</h2>

      <p>Renjin is unfortunately no longer actively maintained.</p>

      <p>You can browse the relevant <a
          href="http://docs.renjin.org">documentation</a> to see if you can find an
      answer to your question, or review previous questions and answers on the
        <a href="http://stackoverflow.com/questions/tagged/renjin">Renjin tag on StackOverflow.com</a>.</p>

    </div>
  </div>
</main>
    <#include "footer.ftl">
    <#include "tracking.ftl">
  </body>
</html>

