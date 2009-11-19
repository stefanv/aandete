<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<h2>${c.recipe.title}</h2>

<p><a href="${c.edit_url}">Edit</a> |

   <a href="${c.rm_url}"> Delete</a> |

   <a href="${c.list_url}">Recipe List</a>
</p>

<h3>Ingredients:</h3>
${c.recipe.ingredients}

<h3>Instructions:</h3>
${c.recipe.text}
