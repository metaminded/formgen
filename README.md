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
  * remember
  * submit_text


### Helper: render_form_replies

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:
  * foo

### Helper: render_form_editor

* path: If a path is set, it will be used to identify the form. Otherwise the path of the request will be used.
* options:
  * fields_only

### Helper: render_form_into_other_form

### Helper: render_reply_into_other_form

### Helper: save_form_out_of_other_form

### Helper: save_reply_out_of_other_form

## License

This project rocks and uses MIT-LICENSE.
