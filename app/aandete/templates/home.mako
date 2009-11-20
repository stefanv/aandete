<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<div class="cover">
<a href="${url(controller='recipe', action='all')}">
<img src="${url('/fludkov_supper_small.jpg')}"/>
<p>Browse my recipes</p></a>
</div>

<div class="cover">
<a href="${url(controller='recipe', action='add')}">
<img src="${url('/castro_beans.jpg')}" width="300px"/>
<p>Add a recipe</p></a>
</div>

<div id="sidebar">

<p><b>Latest Recipes</b></p>

% for r, recipe_link, user_link in c.latest:
  <p><a href="${recipe_link}">${r.title}</a> by <a href="${user_link}">${r.owner.nickname()}</a></p>
% endfor

<p>&nbsp;</p>
<p><b>Yummy Sites</b></p>
<a href="http://cookingforengineers.com/">Cooking for Engineers</a>

</div>
