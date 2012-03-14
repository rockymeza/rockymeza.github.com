---
title: b
github: https://www.github.com/rockymeza/b
---
{% extends "layouts/base.jinja" %}
{% block content %}
{% markdown %}
# b, a simple bookmarking system
I have a lot of projects on my computer.  They are not all in the same folder.
They sometimes have similar names.  I used to spend a lot of time typing out
`cd` commands.  `$ cd /var/www/this_project`, `$ cd ~/project/that_project`.  I
usually have a couple terminals open per project, so it would take me a while to
even get those terminals set up, before I could start to work.  This grew to be
too tedious.

## Introducing b
With b, you no longer have to remember those long directory names.  You don't
even have to know where they are.  Make a bookmark once and never have to `cd`
to that directory again.  b is a small shell script that adds nice bookmarking
to the terminal.

In order to make a bookmark, pass b a short name, and the directory that you
want to bookmark.  For example:

    $ b this /var/www/thisproject

Then, you can `cd` to that directory from anywhere by just passing the short
name to b.

    $ b this
    # will cd to /var/www/thisproject

Finally, you can view a list of bookmarks simply by running b with no
parameters:

    $ b
    this,/var/www/thisproject
    ...

## How does b work?
b stores bookmarks in plain text in `$BOOKMARKS_FILE`, and uses `grep` and
`sed`, just like a simple program should.  b is pretty much done, but there may
be additional features in the future.  You can follow development and contribute
on [GitHub]({{ github }}).

{% endmarkdown %}
{% endblock %}
