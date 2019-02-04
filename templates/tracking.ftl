<!-- Google Analytics -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-20543588-3', 'auto');
  ga('send', 'pageview');

</script>

<!-- Wistia Video -->
<script src="http://fast.wistia.net/static/embed_shepherd-v1.js"></script>
<script>
wistiaEmbeds.onFind(function(video){
  video.bind("play", function(){
    _gaq.push(['_trackEvent', 'Video', 'Play', video.name()]);
    return this.unbind;
  }).bind("end", function(){
    _gaq.push(['_trackEvent', 'Video', 'Complete', video.name()]);
    return this.unbind;
  });
});
</script>

<!-- Syntax highlighting -->
<script src="/js/highlight.pack.js"></script>
<script>
  hljs.initHighlightingOnLoad();
</script>
