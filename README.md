# Cal

Cal is a Ruby library for display nice looking, standard compliant 
monthly calendar displays in HTML. Cal is a simple interface with features 
such as highlighting days with events.

## Installation

Add this line to your application's Gemfile:

    gem 'cal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cal

## Usage

Cal is easy to use. It supplies a default layout, including the HTML, CSS, 
and JavaScript. You simply call the display method where you want a calendar 
displayed. You pass to the method the year and month you want displayed. In 
addition you can pass a block of events that you want highlighted on the 
calendar.


For example if you wanted to display a calendar for April of 2012:

   `Cal.display(2012, 4)`

Cal defaults to the current year and month if not passed:

  `Cal.display`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
