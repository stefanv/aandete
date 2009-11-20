<%def name="recipe_form(action)">

<form class="recipe" action="${action}" method="POST">

<p>Please fill out the form below and click <em>"Save this
recipe"</em> to proceed. The blue box is for listing ingredients.</span>

</p>
<label>Title:</label>
${h.text('title', size=60)}<br/>

<label>Instructions:</label>
${h.textarea('text', cols=60, rows=10,
             class_="recipe_form_text")}<br/>

${h.textarea('ingredients', cols="20", rows="10",
             class_="recipe_form_ingredients")}

<p>
<input id="submit" name="submit" type="submit"
       value="Save this recipe" class="recipe_form_submit" /></p>
</form>

</%def>