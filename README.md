# fredit: front-end edit

fredit is a simple, no-frills Rails Engine that lets you edit your Rails
application's view templates, css stylesheets, and javascript files
(a.k.a front-end files) through the browser.

fredit injects an edit link into every view template. These edit links
are visible wherever the template is rendered, whether it is a layout,
a page, or a partial. 

<img style="width:300px" src="https://github.com/danchoi/fredit/raw/master/screens/links.png"/>

By clicking on these links, you call up a edit page that will let you
directly edit the source. An update button lets you save these changes
and alter the underlying source files.

<img style="width:300px" src="https://github.com/danchoi/fredit/raw/master/screens/fredit.png"/>

In addition to view templates, stylesheets and javascript files are
accessible through a file selection drop down at the top of the fredit
edit page. 

You can also create and delete front-end files on the fredit edit page.

**NOTE: Currently only the ERB Rails template handler is supported.**
You are welcome to fork and add support for Haml and other template
handlers. 


## Why fredit?

On a current Rails project, I needed to delegate responsibility for
improving the user interface to another person. Let's call this person
"Chad." Chad:

* is not a Ruby or Rails programmer
* knows HTML and CSS
* can make perfect sense of ERB, Rails partials, and basic Ruby
  constructs found in ERB after a few minutes of explanation 
* can use a web browser interface to edit files

One option here is to set up a full Rails development environment on
Chad's computer. But this option is not attractive for several
reasons. Chad is not familiar with Linux or git. I would have to install
Ruby, gems, and the RDBMS on Chad's computer for him. I would have to
teach Chad a lot of things: how to check out the application code from
the git repository, how to start the Rails app, how to run migrations,
how to check his changes into the git repository and push them upstream.
All this work just to get Chad to the point where he can edit the view
templates and the stylesheets of your Rails app.

Another option is to integrate a CMS into your Rails app. But in
addition to being quite heavyweight, this approach is too restrictive when
you want to give your collaborator as much control over the front-end as
he or she can handle.

fredit lets a collaborator make significant front-end tweaks to a Rails
applications without the hassles of having to set up and run a local
instance of it on their computer. Just run a fredit-enabled instance of
your Rails app on a server that your collaborator can access through his
or her browser. This fredit-enabled instance can have its own Rails
environment, database, and git branch. You can add an authentication
gateway and even run the instance as a special chrooted user if you want
to make the sandbox more secure.


## Install and setup

Put something like this in the `Gemfile` of your Rails app:

    group :staging do
      gem 'fredit'
    end

and then run `RAILS_ENV=staging bundle install`, adjusting the
`RAILS_ENV` to your target environment.

To run your Rails app with fredit, just start it in the Rails
environment Gemfile group you put the fredit gem in. The special view
template links should then be visible and link to the fredit editor.


## fredit and git 

fredit assumes that the Rails instance it is running on is a cloned git
repository. **It also assumes that you have set the current branch of git
repository to the one you want your collaborator's changes committed
to.**

When your collaborator makes and save changes, fredit will commit those
changes on the current git branch of the git repository the root of this
instance of your Rails application. There is a form field in the fredit
editor for the collaborator to enter git author information and a git
log message. These bits of information accompany the git commit.

When you're ready to review and merge the changes your collaborator made
via fredit, it's all just a matter of working with git commits and
branches. You can set up client-side git hooks on the fredit server to
notify you when your collaborator has made changes, to automatically
push those changes to the appropriate branch in the upstream repository,
run a CI build server, etc.





## License

Fredit is distributed under the MIT-LICENSE.
