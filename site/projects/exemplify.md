---
title: Exemplify.js
github: https://www.github.com/rockymeza/exemplify
---
{% extends "layouts/project.jinja" %}
{% block content %}
{% markdown %}
# Exemplify.js, a simple demo tool
I wanted to write some examples for a JavaScript project of mine.  At first I
was writing the examples and then copying and entitizing the code by hand to
display the source of the example.  This quickly became to tedious for me and at
the same time I felt a little disappointed that my documentation was not DRY.
To that end, I have written a small jQuery plugin that will take a working
JavaScript demo and display the source code for it on the page.

## Introducing Exemplify
It takes a container element that has a child element with the class `example`.
Exemplify extracts the HTML, CSS, and JavaScript from that example element and
appends an element to the container to display the extracted code to the user.
For example, if you had a container that looked something like this:

```html
<article class="exemplify">
  <h1>The most basic things</h1>

  <div class="example">
    <p class="my_p"></p>

    <script>
    $('.my_p').awesome();
    </script>
  </div>
</article>
```

and you were to run the `exemplify` command, your resulting
HTML would look something like this:

```html
<article class="exemplify">
  <h1>The most basic things</h1>

  <div class="example">
    <p class="my_p"></p>

    <script>
    $('.my_p').awesome();
    </script>
  </div>
  <div class="source">
    <h2>HTML:</h2>
    <pre>
      <p class="my_p"></p>
    </pre>

    <h2>JavaScript:</h2>
    <pre><code>
      $('.my_p').awesome();
    </code></pre>
  </div>
</article>
```

## Behind the Code
When I set out to write Exemplify, I had not planned on making it a jQuery
plugin.  I knew that I was going to depend on jQuery, at least initially, for
DOM manipulation.  If I had written cross-browser DOM manipulation from scratch
I am not altogether sure just how long the source would be.

The initial method of using Exemplify was an `init` method that you could call
at the bottom of the page.  There was an `exemplify` method on the jQuery
prototype, but only as glue so that I could write the `init` method more easily.
I realized then that the `init` method provided no functionality that the jQuery
method did not, so I decided to switch to providing Exemplify as a jQuery
plugin.

Currently, Exemplify exposes two other methods: `exemplify.exemplify` and
`exemplify.wrapCode`.

`exemplify.exemplify`
:  takes a container as its argument and appends the new HTML inside that container.

`exemplify.wrapCode`
:  is the method that is used to transform the text value of the code into a
   displayable element.  It is exposed to allow you to customize this output.


## Examples
This tool would of course not be complete without demos:

-  [Basic Demo](/exemplify/examples/basic.html)
-  [Syntax Highlighting](/exemplify/examples/syntax-highlighting.html)


## Contribute
Exemplify.js is hosted at [GitHub]({{ github }}).  You can follow development
and contribute there.
 
{% endmarkdown %}
{% endblock %}
