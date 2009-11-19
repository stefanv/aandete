import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons import url
from pylons.decorators import validate

from google.appengine.api import users
from google.appengine.api import memcache

from aandete.lib.base import BaseController, render
from aandete.model import Recipe
from aandete.model.form import RecipeForm
from aandete.controllers.gae import require_login, model_dict

from formencode import htmlfill

log = logging.getLogger(__name__)

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
        query = Recipe.all()
        query = query.filter('owner =', users.get_current_user())

        c.recipes = query
        return render('/recipe_all.mako')

    def view(self, id=None):
        id = int(id)
        c.message = request.params['message']

        if not id:
            abort(404)

        c.recipe = Recipe.get_by_id(id)

        c.rm_url = url(controller='recipe', action='delete', id=id)
        c.edit_url = url(controller='recipe', action='edit', id=id)
        c.list_url = url(controller='recipe', action='all')
        c.add_url = url(controller='recipe', action='add')

        return render('/recipe_view.mako')

    @require_login
    def add(self):
        c.save_url = url.current(action='save')
        return render('/recipe_add.mako')

    @require_login
    @validate(schema=RecipeForm(), form='add')
    def save(self):
        self.form_result['owner'] = users.get_current_user()

        r = Recipe(**self.form_result)
        r.put()

        redirect_to(url.current(action='view', id=r.key().id(),
                                message='Recipe saved.'))


    @require_login
    def edit(self, id):
        id = int(id)
        recipe = Recipe.get_by_id(id)

        c.update_url = url.current(action='update', id=id)

        html = render('/recipe_edit.mako')
        return htmlfill.render(html, model_dict(recipe))

    @require_login
    @validate(schema=RecipeForm(), form='edit')
    def update(self, id):
        id = int(id)

        recipe = Recipe.get_by_id(id)

        for k, v in self.form_result.iteritems():
            setattr(recipe, k, v)
        recipe.put()

        redirect_to(url.current(action='view', id=id,
                                message="Recipe updated."))
