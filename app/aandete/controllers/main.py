import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from google.appengine.api import users

from aandete.lib.base import BaseController, render

log = logging.getLogger(__name__)

class MainController(BaseController):
    def home(self):
        c.user = users.get_current_user()
        c.login_url = users.create_login_url("/")
        c.logout_url = users.create_logout_url("/")
        return render('home.mako')
