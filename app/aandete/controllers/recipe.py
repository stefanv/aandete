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
        c.message = request.params.get('message', None)

        query = Recipe.all()
        query.filter('owner =', users.get_current_user())
        query.order('title')

        c.recipes = query
        return render('/recipe_all.mako')

    def view(self, id=None):
        c.message = request.params.get('message', None)

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
        recipe = Recipe.get_by_id(id)

        c.update_url = url.current(action='update', id=id)

        html = render('/recipe_edit.mako')
        return htmlfill.render(html, model_dict(recipe))

    def _own_recipe(self, recipe):
        if not recipe.owner == users.get_current_user():
            abort(403) # Forbidden

    @require_login
    @validate(schema=RecipeForm(), form='edit')
    def update(self, id):
        recipe = Recipe.get_by_id(id)
        if not recipe:
            abort(404) # Not found

        self._own_recipe(recipe)

        for k, v in self.form_result.iteritems():
            setattr(recipe, k, v)
        recipe.put()

        redirect_to(url.current(action='view', id=id,
                                message="Recipe updated."))

    @require_login
    def delete(self, id):
        recipe = Recipe.get_by_id(id)
        if not recipe:
            abort(404) # Not found

        self._own_recipe(recipe)

        title = recipe.title
        recipe.delete()
        redirect_to(url.current(action='all',
                                message='Recipe "%s" deleted.' % title))

    def search(self, user=None):
        user = request.params.get('user', None)
        keywords = request.params.get('keywords', None)

        if user is not None:
            c.results = [r for r in Recipe.all() if r.owner.email() == user]

        elif keywords is not None:
            keywords = keywords.split(' ')

            query = Recipe.all()
            c.results = [r for r in query if \
                         [k for k in keywords if k.lower() in r.title.lower()]]
        else:
            redirect_to(request.headers.get('REFERER', '/'))

        return render('/search_results.mako')
