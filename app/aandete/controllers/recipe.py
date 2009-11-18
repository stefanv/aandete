import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons import url

from google.appengine.api import users
from google.appengine.api import memcache

from aandete.lib.base import BaseController, render

from decorator import decorator

log = logging.getLogger(__name__)

@decorator
def require_login(f, *args, **kwargs):
    if not users.get_current_user():
        redirect_to(users.create_login_url(url.current()))
    else:
        return f(args, **kwargs)

class RecipeController(BaseController):
    def index(self):
        user = users.get_current_user()
        if user:
            greeting = ("Welcome, %s! (<a href=\"%s\">sign out</a>)" %
                        (user.nickname(), users.create_logout_url("/")))
        else:
            greeting = ("<a href=\"%s\">Sign in or register</a>." %
                        users.create_login_url("."))

        c.greeting = greeting

        return render('/recipe.mako')

    @require_login
    def all(self):
        return 'Show all recipes'

    def add(self):
        return 'Add a recipe'


