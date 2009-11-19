<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <link href="${url('/style.css')}" rel="stylesheet" type="text/css" media="screen"/>
    ${self.head_tags()}
  </head>
  <body>
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
  </div>

  </body>
</html>
