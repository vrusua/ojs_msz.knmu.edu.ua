{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}

    </div>
    <!-- End Main Content -->

    <!-- Sidebar -->
    {call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
    {call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
    {if ($leftSidebarCode || $rightSidebarCode) && ($pageTitle != "user.login")}
      <aside class="large-3 columns">
        <div id="sidebar">
        {if $leftSidebarCode}
          {$leftSidebarCode}
        {/if}
        {if $rightSidebarCode}
          {$rightSidebarCode}
        {/if}
        </div>
      </aside>
    {/if}
    <!-- End Sidebar -->

  </div>

  <!-- End Main Content and Sidebar -->
  
  <!-- Footer -->

  <footer class="row">
    <div class="large-12 columns">
      <hr />
      <div class="row">
        <div class="large-6 columns">
          <p>&copy Inter Collegas</p>
        </div>
        <div class="large-6 columns">
          <ul class="inline-list right">
            <li>Web development <a target="_blank" href="http://owlookit.com">OWLOOKIT™</a></li>
          </ul>
        </div>
      </div>
    </div>
  </footer>


{if $displayCreativeCommons}
	{translate key="common.ccLicense"}
{/if}
{if $pageFooter}
	<br /><br />
	{$pageFooter}
{/if}

{call_hook name="Templates::Common::Footer::PageFooter"}

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}




	<script type="text/javascript" src="{$baseUrl}/plugins/themes/ecm/app.min.js"></script>

	<script>$(document).foundation();</script>   

	<!-- Add javascript required for font sizer -->
	<script type="text/javascript">{literal}
		<!--
		$(function(){
			fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
		});
		// -->
	{/literal}</script>

	<!-- Form validation -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/validate/jquery.validate.js"></script>
	<script type="text/javascript">
		<!--
		// initialise plugins
		{literal}
		$(function(){
			jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
			{/literal}{if $validateId}{literal}
				$("form[name={/literal}{$validateId}{literal}]").validate({
					errorClass: "error",
					highlight: function(element, errorClass) {
						$(element).parent().parent().addClass(errorClass);
					},
					unhighlight: function(element, errorClass) {
						$(element).parent().parent().removeClass(errorClass);
					}
				});
			{/literal}{/if}{literal}
			$(".tagit").on('click', function() {
				$(this).find('input').focus();
			});
		});
		// -->
		{/literal}
	</script>

	{if $hasSystemNotifications}
		{url|assign:fetchNotificationUrl page='notification' op='fetchNotification' escape=false}
		<script type="text/javascript">
			$(function(){ldelim}
				$.get('{$fetchNotificationUrl}', null,
					function(data){ldelim}
						var notifications = data.content;
						var i, l;
						if (notifications && notifications.general) {ldelim}
							$.each(notifications.general, function(notificationLevel, notificationList) {ldelim}
								$.each(notificationList, function(notificationId, notification) {ldelim}
									console.log(notification);
									$.pnotify(notification);
								{rdelim});
							{rdelim});
						{rdelim}
				{rdelim}, 'json');
			{rdelim});
		</script>
	{/if}{* hasSystemNotifications *}

{literal}
<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter27796713 = new Ya.Metrika({id:27796713,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/27796713" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

<!-- begin GA  -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-58134078-1', 'auto');
  ga('send', 'pageview');
</script>
<!-- end GA -->
{/literal}
</body>
</html>
