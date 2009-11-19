<%def name="recipe_form(action)">

<form class="recipe" action="${action}" method="POST">

<p>Please fill out the form below and click <em>"Save this
recipe"</em> to proceed. The blue box is for listing ingredients.</span>

</p>
<label>Title:</label>
${h.text('title', size=60)}<br/>

<textarea class="recipe_form_ingredients" id="ingredients" name="ingredients"
          cols="20" rows="10"></textarea>

<label>Instructions:</label>
${h.textarea('text', cols=60, rows=10)}<br/>

<input id="submit" name="submit" type="submit"
       value="Save this recipe" class="recipe_form_submit" />
</form>

</%def>