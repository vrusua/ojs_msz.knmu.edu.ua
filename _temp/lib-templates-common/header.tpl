{**
 * header.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}
{strip}
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}

<!doctype html>
<!--[if lte IE 8]><html class="lteie8"><![endif]-->
<!--[if gt IE 8]><!--><html><!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width" />
	<title>{$pageTitleTranslated}</title>
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />

	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	<link rel="stylesheet" href="{$baseUrl}/plugins/themes/ecm/screen.css" type="text/css">
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/ecm/vendor/custom.modernizr.js"></script>

	<!-- Base Jquery -->
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/ecm/vendor/jquery.js"></script>
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/ecm/vendor/jquery-ui.min.js"></script>


	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<!-- Default global locale keys for JavaScript -->
	{include file="common/jsLocaleKeys.tpl" }

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	{$additionalHeadData}

</head>

<body>

<!-- BEGIN out-->


<div class="row">
	<div class="large-12 center-group columns">
		<div class="row">
			<div class="large-3 hide-for-small columns"><a href="{$baseUrl}" class="href"><img src="{$baseUrl}/plugins/themes/ecm/img/logo.png"></a></div>
			<div class="large-6 small-12 columns"><img src="{$baseUrl}/plugins/themes/ecm/img/about.png"></div>
			<div class="large-3 hide-for-small columns"><a href="http://knmu.edu.ua/" target="_blank" class="href"><img src="{$baseUrl}/plugins/themes/ecm/img/plashka.png"></a></div>
		</div>
	</div>
</div>
<div class="row">
	<div class="large-12 columns">
		<br/>
		{include file="common/navbar.tpl"}
		{if $pageTitle == "common.openJournalSystems"}

		<div class="row">
			<div class="large-12 hide-for-small columns">
			    <img src="{$baseUrl}/plugins/themes/ecm/img/bg/bg_main_slider.png"/>
			</div>
		</div>

<!-- 
			<div class="slideshow-wrapper">
			  <div class="preloader"></div>
				<ul data-orbit>
				  <li>
				    <img src="http://placehold.it/1000x300&text=[SLIDER1]" />
				    <div class="orbit-caption">Description1...</div>
				  </li>
				  <li>
				    <img src="http://placehold.it/1000x300&text=[SLIDER2]" />
				    <div class="orbit-caption">Description2...</div>
				  </li>
				  <li>
				    <img src="http://placehold.it/1000x300&text=[SLIDER3]" />
				    <div class="orbit-caption">Description3...</div>
				  </li>
				  <li>
				    <img src="http://placehold.it/1000x300&text=[SLIDER4]" />
				    <div class="orbit-caption">Description4...</div>
				  </li>
				</ul>
			</div>
 -->
		{/if}
		{include file="common/breadcrumbs.tpl"}
		<hr />
	</div>
</div>

<div class="row">

<!-- Main Blog Content -->
<div class="large-9 columns" role="content">