<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    ${h.stylesheet_link('/style.css')}
    ${h.javascript_link('/jquery-1.3.2.min.js', 'jquery.debug.js')}
    ${h.javascript_link('/jquery.simplemodal-1.3.3.min.js')}
    ${self.head_tags()}
  </head>
  <body>

<div id="container">

  <h1><a href="${url('/')}" style="text-decoration: none; color: #404047;">
      It's Supper Time!</a></h1>

% if c.message:
<div class="message">${c.message}</div>
% endif

% if c.warning:
<div class="warning">${c.message}</div>
% endif

    ${self.body()}

  <div class="footer">

<p>
% if not url.current() == '/':
  Back to <a href="${url('/')}">main page</a>.
% else:
  <em>"Laughter is brightest where food is best."</em> &#151; Irish Proverb
% endif

    <span style="float: right;">

% if g.users.get_current_user() is None:
  Please proceed to <a href="${g.users.create_login_url('/')}">log in</a>.
% else:
  Logged in as ${g.users.get_current_user()}.
  <a href="${g.users.create_logout_url('/')}">Log out.</a>
% endif

    </span>

<br/><br/>
<span style="font-size: 9pt;">
Front page image credits: Salad and tomatoes by <a
href="http://www.flickr.com/people/floodkoff/">Michael
Fludkov</a>. Black bean recipe by <a
href="http://www.flickr.com/photos/29278394@N00/2832173460/">Anne
Norman</a>.
</span>

    </p>
  </div>

  </div> <!-- end container -->
  </body>
</html>
