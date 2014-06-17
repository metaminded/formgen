# Formgen

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
The basic call to render a form is `<%= render_form %>` in your views.
Multiple arguments are allowed to customize the behaviour of the form.

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:
  * remember [false]
  * submit_text

### Helper: render_form_replies
Renders the complete input form for replies.

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:
  * flash [true]

### Helper: render_form_editor
Renders the complete editor for forms and questions.

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:
  * fields_only [false]

### Helper: render_questions_for form_for, obj
Renders the editor for questions only.
It integrates into an existing nested_form.
The form_for is the object of the nested_form, obj is an instance of a class, that acts like a form.
Use `include Formgen::ActsAsForm` for this propose.

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:

### Helper: render_reply_for form_for, obj
Renders the editor for answers into another form.
It integrates into an existing form.
The form_for is the object of the form, obj is an instance of a class, that acts like a form.
Use `include Formgen::ActsAsForm` for this propose.

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:
  * remember [false]

### Helper: save_reply_for
Saves the reply of the render_reply_for helper in the controller.

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.

## License

This project rocks and uses MIT-LICENSE.
