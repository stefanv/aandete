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

import math

log = logging.getLogger(__name__)

def paginate(query, page, limit=10):
    offset = (page - 1) * limit
    if isinstance(query, list):
        total = len(query)
        items = query[offset:offset + limit]
    else:
        # Query is a database result
        total = query.count(None)
        items = query.fetch(limit=limit, offset=offset)

    pages = math.ceil(total / float(limit))

    return items, pages


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
    def mine(self):
        c.message = request.params.get('message', None)

        query = Recipe.all()
        query.filter('owner =', users.get_current_user())
        query.order('title')

        c.page = int(request.params.get('page', 1))
        c.recipes, c.pages = paginate(query, c.page, limit=5)

        c.page_url = url(controller='recipe', action='mine',
                         id=None)
        return render('/recipes.mako')

    def browse(self):
        c.message = request.params.get('message', None)

        query = Recipe.all()
        query.order('title')

        c.page = int(request.params.get('page', 1))
        c.recipes, c.pages = paginate(query, c.page, limit=5)
        c.page_url = url(controller='recipe', action='browse', id=None)

        return render('/recipes.mako')

    def view(self, id=None):
        c.message = request.params.get('message', None)

        if not id:
            abort(404)

        c.recipe = Recipe.get_by_id(id)

        if not c.recipe:
            abort(404)

        c.rm_url = url(controller='recipe', action='delete', id=id)
        c.edit_url = url(controller='recipe', action='edit', id=id)
        c.list_url = url(controller='recipe', action='browse')
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

        if not recipe:
            abort(404)

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
        redirect_to(url.current(action='mine',
                                message='Recipe "%s" deleted.' % title))

    def search(self):
        c.page = int(request.params.get('page', 1))

        user = request.params.get('user', None)
        if user == 'None': user = None

        keywords = request.params.get('keywords', None)
        if keywords == 'None': keywords = ''

        query = Recipe.all()
        query.order('title')
        if user is not None:
            if user and not '@' in user: user += '@gmail.com'
            query.filter('owner =', users.User(user))
            results = query

        elif keywords is not None:
            kwds = keywords.split(' ')

            results = [r for r in query if \
                       [k for k in kwds if k.lower() in r.title.lower()
                        or k.lower() in str(r.owner).lower()]]
        else:
            redirect_to(request.headers.get('REFERER', '/'))

        c.user = user
        c.keywords = keywords
        c.recipes, c.pages = paginate(results, c.page, limit=5)

        page_url_params = dict(controller='recipe', action='search',
                               id=None)
        if user is not None:
            page_url_params['user'] = user
        if keywords is not None:
            page_url_params['keywords'] = keywords

        c.page_url = url(**page_url_params)

        return render('/recipes.mako')
