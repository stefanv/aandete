<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

% if getattr(c, 'message', ''):
<p>${c.message}
% endif

% if not 'search' in c.page_url:

<p>
<small>
% if c.page_url.endswith('mine'):
<a href="${url(controller='recipe', action='browse', user=getattr(c, 'user', ''), keywords=getattr(c, 'keywords', ''))}">View all
recipes</a>
% else:
<a href="${url(controller='recipe', action='mine', user=getattr(c, 'user', ''), keywords=getattr(c, 'keywords', ''))}">View only my
recipes</a>
% endif
</small>
<hr/>
</p>

% endif

<p>

% if len(getattr(c, 'recipes', [])) <= 0:
No recipes found.
% endif

% for r in getattr(c, 'recipes', []):
  <p><a href="${url(controller='recipe', action='view', id=r.key().id())}">
  ${r.title}</a> by
  <a href="${url(controller='recipe', action='search', user=r.owner)}">
   ${r.owner.nickname()}</a><br/>

% if getattr(c, 'text', ''):
  ${c.text[:200]}

% if len(r.text) > 200:
...
% endif
  </em>
% endif

  </p>

% endfor

</p>


% if hasattr(c, "page_url") and c.pages > 0:
<hr/>
<p>Page:

% if c.page != 1:
<a href="${c.page_url + '&page=%d' % (int(c.page) - 1)}">Previous</a> &bull;
% endif

% for p in range(1, int(c.pages) + 1):

% if p == c.page:
<span class="page_current">${p}</span>
% else:
<a class="page_other" href="${c.page_url + '&page=%s' % p}">${p}</a>
% endif

% endfor

% if c.page < c.pages:
&bull; <a href="${c.page_url + '&page=%d' % (int(c.page) + 1)}">Next</a>
% endif

</p>
%endif

</ul>
