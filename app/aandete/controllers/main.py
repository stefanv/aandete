import logging

from pylons import request, response, session, tmpl_context as c
from pylons import url

from google.appengine.api import users

from aandete.lib.base import BaseController, render
from aandete.model import Recipe

log = logging.getLogger(__name__)

class MainController(BaseController):
    def home(self):
        latest = Recipe.all().order('-modified').fetch(5)

        c.latest = [(r,
                     url(controller='recipe', action='view',
                         id=r.key().id()),
                     url(controller='recipe', action='search',
                            user=r.owner))
                    for r in latest]

        return render('home.mako')
