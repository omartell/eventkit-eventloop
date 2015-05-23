# Eventkit::Eventloop

[![Build Status](https://travis-ci.org/omartell/eventkit-eventloop.svg?branch=master)](https://travis-ci.org/omartell/eventkit-eventloop)

A basic event loop implemented with Ruby's IO.select to perform non blocking IO.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eventkit-eventloop'
```

## Event Loop Usage

Eventkit provides a basic event loop on top of Ruby's IO.select.
Callbacks can be registered to monitor the readability or writability of IO objects.
These callbacks are executed when the IO object is ready to be read or written to.

Another feature is timers, which allows you to execute code at some point in the future.

```ruby
require 'eventkit/event_loop'

# Getting notified when an IO object is ready to be read or written
event_loop = Eventkit::EventLoop.new

server = TCPServer.new('localhost', 9595)

client = TCPSocket.new('localhost', 9595)

event_loop.register_read(server) do |server|
  # This will be executed every time a new connection is ready to be accepted
  connection, _ = server.accept_nonblock
  event_loop.register_write(connection) do |connection|
    bytes_written = connection.write_nonblock('hello world')
  end
end

event_loop.start


# Unsubscribing from notifications
# A single read
event_loop.deregister_read(io_object, handler)

# A single write
event_loop.deregister_write(io_object, handler)

# All handlers
event_loop.deregister_write(io_object)
event_loop.deregister_read(io_object)


# Registering a handler to be run on the next tick
event_loop = Eventkit::EventLoop.new

event_loop.on_next_tick do
  puts 'hello world'
  event_loop.stop
end

event_loop.start


# Registering timers

event_loop = Eventkit::EventLoop.new

event_loop.register_timer(run_in: 5) do
  # Block executes after 5 seconds have passed
  puts 'hello world'
  event_loop.stop
end

event_loop.start
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/eventkit-eventloop/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
