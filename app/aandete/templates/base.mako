<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    ${h.stylesheet_link('/style.css')}
    ${h.stylesheet_link('/print.css', media='print')}
    ${h.javascript_link('/jquery-1.3.2.min.js')}
    ${h.javascript_link('/jquery.simplemodal-1.3.3.min.js')}
    ${self.head_tags()}
    <title>Supper Time</title>
  </head>
  <body>

<div id="container">

  <%namespace file="search.mako" import="search_box"/>
  <div id="search">${search_box()}</div>

  <h1 id="banner">
    <a href="${url('/')}" style="text-decoration: none; color: #404047;">
      It's Supper Time!</a></h1>

% if getattr(c, 'message', ''):
<div class="message">${c.message}</div>
% endif

% if getattr(c, 'warning', ''):
<div class="warning">${c.warning}</div>
% endif

    ${self.body()}

  <div id="footer">

<p>
% if not url.current() == '/':
  Back to <a href="${url('/')}">main page</a>.
% else:
  <em>"Laughter is brightest where food is best."</em> &#151; Irish Proverb
% endif

    <span style="float: right;">

% if app_globals.users.get_current_user() is None:
  Please proceed to <a href="${app_globals.users.create_login_url('/')}">log in</a>.
% else:
  Logged in as ${app_globals.users.get_current_user()}.
  <a href="${app_globals.users.create_logout_url('/')}">Log out.</a>
% endif

    </span>

<br/><br/>
<span style="font-size: 9pt;">
Contact the <a href="http://mentat.za.net">developer</a> or
view the <a href="http://github.com/stefanv/aandete">source code</a>.
Front page image credits: Salad and tomatoes by <a
href="http://www.flickr.com/people/floodkoff/">Michael
Fludkov</a>. Black bean recipe by <a
href="http://www.flickr.com/photos/29278394@N00/2832173460/">Anne
Norman</a>.
</span>

    </p>
  </div>

  <div id="print_footer">
    <% from paste.request import construct_url %>
    Thanks for using Supper Time&mdash;enjoy your meal!<br/>
    Find this recipe at <tt>${construct_url(request.environ)}</tt>
  </div>

  </div> <!-- end container -->
  </body>
</html>
