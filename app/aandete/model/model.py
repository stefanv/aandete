from google.appengine.ext import db

class Recipe(db.Model):
    title = db.StringProperty(required=True)
    text = db.TextProperty()
    ingredients = db.TextProperty()
    tags = db.StringListProperty()
    photo = db.BlobProperty()

    owner = db.UserProperty(auto_current_user_add=True, required=True)

    @classmethod
    def get_by_id(cls, id):
        id = int(id)
        key = db.Key.from_path('Recipe', id)
        return db.Model.get(key)

class Cookbook(db.Model):
    title = db.StringProperty(required=True)
    desc = db.Text()
    recipes = db.ListProperty(int) # list of recipe keys
    shared_with = db.ListProperty(db.Email)

    owner = db.UserProperty(auto_current_user_add=True, required=True)
