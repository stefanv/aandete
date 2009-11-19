<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

% if c.recipes.count() == 0:
  No recipes found.
% endif

<ul>

% for r in c.recipes:
<li><a href="${url(controller='recipe', action='view', id=r.key().id())}">
       ${r.title}</a></li>
% endfor

</ul>
