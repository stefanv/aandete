<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<%def name="option_list()">
<span class="option_list">
<p><a href="${c.edit_url}">Edit</a> |

   <a href="#" onclick="$('#confirm_delete').modal();">
   Delete</a> |

   <a href="${c.add_url}">Add Recipe</a> |

   <a href="${c.list_url}">Recipe List</a>
</p>
</span>
</%def>

<div id="confirm_delete" style="display: none;">
<h2>Delete <em>${c.recipe.title}</em>?</h2>
Once the recipe has been deleted, it cannot be recovered.
<ul>
<li><a href="${c.rm_url}">Yes, delete this recipe.</a></li>
<li><a href="#" class="simplemodal-close">No, don't delete the recipe.</a></li>
</ul>
</div>

${self.option_list()}

<div class="recipe_page">
<h2>${c.recipe.title}</h2>

<div class="recipe_ingredients">
<h3><span style="text-decoration: underline;">Ingredients</span></h3>

% if c.recipe.ingredients:
% for i in c.recipe.ingredients.split('\n'):
${i}<br/>
% endfor
% endif
</div>

<div class="recipe_instructions">

% if c.recipe.text:

% for par in c.recipe.text.split('\n'):
${par}<br/>
% endfor

% else:
The author of this recipe provided no instructions.
%endif
</div>

<div class="recipe_footer">
<img src="/divide_line.png">
</div>

</div>

${self.option_list()}