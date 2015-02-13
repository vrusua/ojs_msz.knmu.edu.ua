{**
 * templates/common/navbar.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Navigation Bar
 *
 *}

<nav class="top-bar show-for-small" style="">
  <ul class="title-area">
    <!-- Title Area -->
    <li class="name">
      <h1><a href="{$baseUrl}">inter.knmu.edu.ua</a></h1>
    </li>
    <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
    <li class="toggle-topbar menu-icon"><a href="#"><span></span></a></li>
  </ul>
  <section class="top-bar-section">
    <ul class="left">
      		<li><a href="{url page="index"}" class="small button success">{translate key="navigation.home"}</a></li>
		<li><a href="{url page="about"}" class="small button success">{translate key="navigation.about"}</a></li>
		{if $isUserLoggedIn}
			<li><a href="{url journal="index" page="user"}" class="small button success">{translate key="navigation.userHome"}</a></li>
		{else}
			<li><a href="{url page="login"}" class="small button success">{translate key="navigation.login"}</a></li>
			{if !$hideRegisterLink}
				<li><a href="{url page="user" op="register"}" class="small button success">{translate key="navigation.register"}</a></li>
			{/if}
		{/if}{* $isUserLoggedIn *}

		{if $siteCategoriesEnabled}
			<li><a href="{url journal="index" page="search" op="categories"}" class="small button success">{translate key="navigation.categories"}</a></li>
		{/if}{* $categoriesEnabled *}

		{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			<li><a href="{url page="search"}" class="small button success">{translate key="navigation.search"}</a></li>
		{/if}

		{if $currentJournal && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			<li><a href="{url page="issue" op="current"}" class="small button success">{translate key="navigation.current"}</a></li>
			<li><a href="{url page="issue" op="archive"}" class="small button success">{translate key="navigation.archives"}</a></li>
		{/if}

		{if $enableAnnouncements}
			<li><a href="{url page="announcement"}" class="small button success">{translate key="announcement.announcements"}</a></li>
		{/if}{* enableAnnouncements *}

		{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

		{foreach from=$navMenuItems item=navItem key=navItemKey}
			{if $navItem.url != '' && $navItem.name != ''}
				<li class="navItem" id="navItem-{$navItemKey|escape}"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$baseUrl}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
			{/if}
		{/foreach}
    </ul>
  </section>

</nav>

<div class="center-group hide-for-small">
	<nav class="button-group round">
		<li><a href="{url page="index"}" class="small button success">{translate key="navigation.home"}</a></li>
		<li><a href="{url page="about"}" class="small button success">{translate key="navigation.about"}</a></li>
		{if $isUserLoggedIn}
			<li><a href="{url journal="index" page="user"}" class="small button success">{translate key="navigation.userHome"}</a></li>
		{else}
			<li><a href="{url page="login"}" class="small button success">{translate key="navigation.login"}</a></li>
			{if !$hideRegisterLink}
				<li><a href="{url page="user" op="register"}" class="small button success">{translate key="navigation.register"}</a></li>
			{/if}
		{/if}{* $isUserLoggedIn *}

		{if $siteCategoriesEnabled}
			<li><a href="{url journal="index" page="search" op="categories"}" class="small button success">{translate key="navigation.categories"}</a></li>
		{/if}{* $categoriesEnabled *}

		{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			<li><a href="{url page="search"}" class="small button success">{translate key="navigation.search"}</a></li>
		{/if}

		{if $currentJournal && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
			<li><a href="{url page="issue" op="current"}" class="small button success">{translate key="navigation.current"}</a></li>
			<li><a href="{url page="issue" op="archive"}" class="small button success">{translate key="navigation.archives"}</a></li>
		{/if}

		{if $enableAnnouncements}
			<li><a href="{url page="announcement"}" class="small button success">{translate key="announcement.announcements"}</a></li>
		{/if}{* enableAnnouncements *}

		{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

		{foreach from=$navMenuItems item=navItem key=navItemKey}
			{if $navItem.url != '' && $navItem.name != ''}
				<li class="navItem" id="navItem-{$navItemKey|escape}"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$baseUrl}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
			{/if}
		{/foreach}
	</nav>
</div>

