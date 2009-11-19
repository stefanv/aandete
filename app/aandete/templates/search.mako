<%def name="search_box()">

  ${h.form(url(controller='recipe', action='search'), method='get')}
     ${h.text('keywords', cols=10)}
     ${h.submit('submit', 'Search')}
  ${h.end_form()}

</%def>
