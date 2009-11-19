<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<ul>
<li><a href="${url(controller='recipe', action='all')}">
       Browse my recipes</a></li>
<li><a href="${url(controller='recipe', action='add')}">
       Add a recipe</a></li>
</ul>
