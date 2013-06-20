blind
=====

No view rendering in controller testing.

Installation
------------

As usual, you can install it using rubygems.

```console
$ gem install blind
```

If you're using Bundler, add this line to
your application's Gemfile:

```ruby
gem 'blind', group: :test
```

And then execute:

```console
$ bundle
```

Usage
-----

Include the `Blind` module in your controller tests:

```ruby
class ActionController::TestCase
  include Blind
end
```

If you want to assert against the contents of the
rendered view, you can use the `render_views!` method:

```ruby
class HomeControllerTest < ActionController::TestCase
  render_views!

  def test_body
    get :index

    assert_match /content/, response.body
  end
end
```

Motivation
----------

Check my blog post about it:
<http://www.frodsan.com/stubbing-views-rails-controller-testing>
