<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<p>
Welcome to Supper Time!
</p>

% if not c.user:
  Please proceed to <a href="${c.login_url}">log in</a>.
% else:
  Logged in as ${c.user}.  <a href="${c.logout_url}">Log out.</a>
% endif

<ul>
<li><a href="${url(controller='recipe', action='all')}">
       View my recipes</a></li>
<li><a href="${url(controller='recipe', action='add')}">
       Add a recipe</a></li>
</ul>
