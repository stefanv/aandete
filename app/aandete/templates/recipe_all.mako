<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

% if c.recipes.count() == 0:
  No recipes found.
% endif

<p>
% for i, r in enumerate(c.recipes):
<a href="${url(controller='recipe', action='view', id=r.key().id())}">
       ${r.title}</a>

% if i != c.recipes.count() - 1:
&bull;
% endif

% endfor
</p>

</ul>
