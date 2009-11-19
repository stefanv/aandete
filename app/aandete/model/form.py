import formencode

# This could be improved by using the built-in validation of GAE db properties:
# http://code.google.com/appengine/docs/python/datastore/propertyclass.html

class RecipeForm(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True
    title = formencode.validators.String(not_empty=True)
