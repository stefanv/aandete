<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<h2>Search Results</h2>

<div id="search_results">

% for r in c.results:
  <p><a href="${url(controller='recipe', action='view', id=r.key().id())}">
  ${r.title}</a> by
  <a href="${url(controller='recipe', action='search', user=r.owner.email())}">
   ${r.owner.nickname()}</a><br/>

% if r.text:
    ${r.text[:200]}...</em>
% endif

  </p>

% endfor

</div>