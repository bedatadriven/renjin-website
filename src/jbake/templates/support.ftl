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

      <p>Start by browsing the relevant <a
          href="http://docs.renjin.org">documentation</a> to see if you can find an
      answer to your question.</p>

      <p>You can review questions and answers on the
        <a href="http://stackoverflow.com/questions/tagged/renjin">Renjin tag on StackOverflow.com</a>.</p>

      <p>For general questions, updates, and discussing, join our
        mailing list on <a href="https://groups.google.com/g/renjin-dev">Google Groups</a>.</p>

      <p>If Renjin does not produce an expected result, you can open an issue on our
        <a href="https://github.com/bedatadriven/renjin/issues">GitHub project</a>.
      </p>

      <p>We are trying to do monthly working sessions on Renjin to which everyone is welcome:</p>

      <iframe src="https://calendar.google.com/calendar/embed?src=c_n44sk33oegv2l6dovtq4k0u5jo%40group.calendar.google.com&ctz=Europe%2FAmsterdam" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>

    </div>
  </div>
</main>
    <#include "footer.ftl">
    <#include "tracking.ftl">
  </body>
</html>

