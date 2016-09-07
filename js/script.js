---
layout: null
---
// target='_blank' on url that are not par of the current domain
// see http://stackoverflow.com/questions/4425198/markdown-target-blank
(function() {
    let links = document.links
    for (let i = 0, linksLength = links.length; i < linksLength; i++) {
       if (links[i].hostname != window.location.hostname) {
           links[i].target = '_blank'
           links[i].className += ' externalLink'
       }
    }
})();

// cookie agreement
$(function() {
  if ( $.cookie('cookiesAgreement') == undefined ){
    $('.cookiesAgreement').show('slow');
    $('.agreeCockies').click(
      function(){
        $.cookie('cookiesAgreement', 'http://www.youtube.com/watch?v=MMb3fd7fwec', { expires: 365, path: '/' });
        $('.cookiesAgreement').hide('slow');
      }
    );
  }
});


{% if site.google_analytics_tracking_id and site.google_analytics_tracking_id != "" %}
  // GOOGLE ANALYTICS CODE
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', '{{ site.google_analytics_tracking_id }}', 'auto');
  ga('send', 'pageview');
{% endif %}
