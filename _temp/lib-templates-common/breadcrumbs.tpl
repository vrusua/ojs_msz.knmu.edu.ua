{**
 * breadcrumbs.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Breadcrumbs
 *
 *}
<span>
<nav class="breadcrumbs">

	<a href="{url context=$homeContext page="index"}">{translate key="navigation.home"}</a>
	{foreach from=$pageHierarchy item=hierarchyLink}
		<a href="{$hierarchyLink[0]|escape}" class="hierarchyLink">{if not $hierarchyLink[2]}{translate key=$hierarchyLink[1]}{else}{$hierarchyLink[1]|escape}{/if}</a>
	{/foreach}
	{* Disable linking to the current page if the request is a post (form) request. Otherwise following the link will lead to a form submission error. *}
	{if $requiresFormRequest}<span class="current">{else}<a href="{$currentUrl|escape}" class="current">{/if}{$pageCrumbTitleTranslated}{if $requiresFormRequest}</span>{else}</a>{/if}
</nav>
<div style="margin-top: -22px; padding-right: 5px; color: white; text-align: right !important"> ISSN 2409-9988</div>
</span>
