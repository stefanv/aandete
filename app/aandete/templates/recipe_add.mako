<%inherit file="/base.mako" />
<%def name="head_tags()">
      <!-- add some head tags -->
</%def>

<%namespace file="recipe_form.mako" import="recipe_form"/>
${recipe_form(action=c.save_url)}

<p style="clear: both;">&nbsp;</p>
