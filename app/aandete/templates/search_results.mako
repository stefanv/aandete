<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<h2>Search Results</h2>

% if len(c.results) > 0:

% for r in c.results:
  <a href="${url(controller='recipe', action='view', id=r.key().id())}">
  ${r.title}</a><br/>

% if r.text:
    <blockquote><em>${r.text[:200]}...</em></blockquote><br/>
% endif

% endfor

% endif
