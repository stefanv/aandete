<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<%def name="option_list()">
<span class="option_list">
<p><a href="${c.edit_url}">Edit</a> |

   <a href="${c.rm_url}"> Delete</a> |

   <a href="${c.add_url}">Add Recipe</a> |

   <a href="${c.list_url}">Recipe List</a>
</p>
</span>
</%def>

${self.option_list()}

<div class="recipe_page">
<h2>${c.recipe.title}</h2>

<div class="recipe_instructions">

% if c.recipe.text:

% for par in c.recipe.text.split('\n'):
${par}<br/>
% endfor

% else:
The author of this recipe provided no instructions.
%endif
</div>

<div class="recipe_ingredients">
<h3><span style="text-decoration: underline;">Ingredients</span></h3>

% if c.recipe.ingredients:
% for i in c.recipe.ingredients.split('\n'):
${i}<br/>
% endfor
% endif
</div>

<div class="recipe_footer">
<img src="/divide_line.png">
</div>

</div>

${self.option_list()}