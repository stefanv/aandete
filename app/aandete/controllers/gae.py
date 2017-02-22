# Tools for Google App Engine

__all__ = ['require_login', 'model_dict']

from pylons.controllers.util import redirect
from google.appengine.api import users
from pylons import url

from decorator import decorator

@decorator
def require_login(f, *args, **kwargs):
    if not users.get_current_user():
        redirect(users.create_login_url(url.current()))
    else:
        return f(*args, **kwargs)

def model_dict(model):
    d = {}
    for k in model.properties():
        d[k] = getattr(model, k)

    return d
