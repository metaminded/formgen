# Formgen

[![Build Status](https://travis-ci.org/simkimsia/UtilityBehaviors.png)](https://travis-ci.org/hanspolo/formgen)
[![Dependency Status](https://gemnasium.com/renspr/bsat.svg)](https://gemnasium.com/hanspolo/formgen)

## Requirements

* Rails 4.1.1 or higher
* Ruby 2.1.2 or higher

## Installation

Start by adding the gem to your Gemfile and run `bundle install`
```ruby
gem 'formgen', github: 'metaminded/formgen'
```

To get Formgen working, the database migrations are needed.
Install them with

```ruby
rake formgen:install:migrations
rake db:migrate
```

## Usage

Formgen provides a backend to manage your forms and some helpers to integrate them into your page.
The backend can be called by linking to the `formgen.forms_path`.

### Helper: render_form
The basic call to render a form in your views.
Multiple arguments are allowed to customize the behaviour of the form.

* id: The id that will be used to identify the form
or
* path: The path will be used to identify the form.
* options:
  * flash [true]: Display flash notices
  * remember [false]: Remember input of the user
  * submit_text: Alternative text for the submit button

### Helper: render_form_editor
Renders the complete editor for forms and questions.

* id: The id that will be used to identify the form
or
* path: The path will be used to identify the form.
* options:
  * fields_only [false]

### Helper: render_questions_for form_for, obj
Renders the editor for questions only.
It integrates into an existing nested_form.
The form_for is the object of the nested_form, obj is an instance of a class, that acts like a form.
Use `include Formgen::ActsAsForm` for this propose.

* path: The path will be used to identify the form.
* options:

### Helper: render_reply_for form_for, obj
Renders the editor for answers into another form.
It integrates into an existing form.
The form_for is the object of the form, obj is an instance of a class, that acts like a form.
Use `include Formgen::ActsAsForm` for this propose.

* path: The path will be used to identify the form.
* options:
  * remember [false]

### Helper: save_reply_for
Saves the reply of the render_reply_for helper in the controller.

* path: The path will be used to identify the form.

## License

This project rocks and uses MIT-LICENSE.
