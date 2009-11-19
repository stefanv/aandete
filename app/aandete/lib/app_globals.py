"""The application's Globals object"""

from google.appengine.api import users

class Globals(object):

    """Globals acts as a container for objects available throughout the
    life of the application

    """

    users = users

    def __init__(self):
        """One instance of Globals is created during application
        initialization and is available during requests via the
        'app_globals' variable

        """
