from google.appengine.ext import db

class Cookbook(db.Model):
    title = db.StringProperty(required=True)
    desc = db.Text()
    recipes = db.ListProperty(Recipe)
    shared_with = db.ListProperty(db.UserProperty)
    owner = db.UserProperty()

class Recipe(db.Model):
    name = db.StringProperty(required=True)
    text = db.Text()
    ingredients = db.Text()
    tags = db.ListProperty(db.StringProperty)

    owner = db.UserProperty()
