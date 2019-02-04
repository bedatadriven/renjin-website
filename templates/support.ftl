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
      <h2>Community support</h2>

      <p>Start by browsing the relevant <a
          href="http://docs.renjin.org">documentation</a> to see if you can find an
      answer to your question.</p>

      <p>There is a <a href="http://stackoverflow.com/questions/tagged/renjin">Renjin tag on StackOverflow.com</a>.</p>

      <p>If you still need help, then <a
          href="mailto:renjin-dev@googlegroups.com">send a message</a> to the
      renjin-dev mailing list. You can find past messages and answers at <a
          href="http://groups.google.com/group/renjin-dev">http://groups.google.com/group/renjin-dev</a>
      which is embedded below.</p>

      <p>
      <iframe id="forum_embed"
       src="javascript:void(0)"
       scrolling="no"
       frameborder="0"
       width="100%"
       height="700">
      </iframe>
      </p>
    </div>
    <div class="medium-6 grid-item">
      <h2>Commercial support</h2>

      <p><a href="http://www.bedatadriven.com">BeDataDriven</a> provides 
      commercial support for Renjin. For example:
      <ul><li>R and Renjin training (remote or in-house);</li>
          <li>Custom development on Renjin to improve performance of a specific use case;</li>
          <li>Ensuring that Renjin will run a specific CRAN/Bioconductor package;</li>
          <li>Custom development of solutions or integrations built using Renjin;</li>
          <li>R(enjin)-as-a-Service: deploy and scale R applications in the cloud;</li>
      </ul>
      </p>
      
      <p>If interested, please contact us by email at 
      <script type="text/javascript">
      //<![CDATA[
      <!--
      var x="function f(x,y){var i,o=\"\",l=x.length;for(i=0;i<l;i++){y%=127;o+=St" +
      "ring.fromCharCode(x.charCodeAt(i)^(y++));}return o;}f(\"O_EOYG@^\\021T\\033" +
      "L\\034MAYK\\032R\\020R\\003\\035bm-/y=h+-'-?$a\\\"r?=i$<<:2p!t84<,\\034\\01" +
      "7\\005\\007\\\"\\020M\\nHYZCJQUVF\\013\\005\\000\\n\\017\\r]J\\000B\\026PA\\"+
      "021E}bcwgm.b!rwvjb|'y,~>%.\\177)%)!r107dO\\n\\037[\\nFNFZh^\\003E\\004\\025" +
      "RBTFFF[\\026X\\026JOYOIL\\027pm-/m~;!`kc|~a\\022m + 21-r<onk\\007\\000xmpQS" +
      "R?8521=6!\\0234=52\\002-.CFE*+\\025=&' !5X\\\\L[pYZ[TUV^EXZYA \\\"#HIDg`$ji" +
      "gic(XU\\026TXQE\\010IP\\006KEMJk\\024h\\013UZ@_Ydege\\033\\t\\014\\017\\034" +
      "\\035rqt\\031\\032uzy\\026\\027}~~\\023\\014b`c\\010\\tq\\003iij\\007\\000h" +
      "mo<=UQT9:7[ZZ70X]_,-BBD)*FKI&'NNN\\\\]524YZ4;9VWD><?LM&!$IJyDE.),AB,\\022\\" +
      "021~\\177\\023\\027\\026{t\\033\\030\\033pqn\\034\\017\\005\\r\\032\\013\\0" +
      "01\\003\\017\\rQ\\032\\013\\013\\006\\014\\005}3iza\\\"`idbkz~}~\\023\\014\\"+
      "177t\\002\\003bfg\\004\\005\\t\\024\\n\\r\\007\\005TSR?8\\014\\022;4<=(4Z__" +
      ",-=BFE*+NHJ' NN0]^GAHUH_ZxWP[AJbzl`#\\\"'KDE83z`%p\\000OPVP@TZ\\023\\000\\0" +
      "03\\000\\007T\\006q\\031X\\032GuPRX{K[S_\\023F\\027%%-\\0006$.\\004%&8-b* &" +
      "\\\"%\\001n\\177:m`jhg~%&wtK\\010Y\\017X\\014]WU\\000B\\031\\003\\013U\\007" +
      "\\004\\026\\034\\026\\030[\\016J\\024U&Y _Co-k#vdp|!p&s$k.a\\177xfpz`p51\"," +
      "41)"                                                                         ;
      while(x=eval(x));
      //-->
      //]]>
      </script>.</p>
    </div>
  </div>
</main>
    <#include "footer.ftl">
    <#include "tracking.ftl">
    <script type="text/javascript">
    document.getElementById("forum_embed").src =
      "https://groups.google.com/forum/embed/?place=forum/renjin-dev" +
      "&showsearch=true&showpopout=true&parenturl=" +
      encodeURIComponent(window.location.href);
    </script>
  </body>
</html>

