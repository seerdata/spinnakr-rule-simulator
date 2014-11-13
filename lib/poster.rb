
require_relative './msgjob'
require_relative './msguuid'
require_relative './msguseragent'
require 'json'

class Publisher

  def publish(options,exchange)
    if options.forever == true
      publish_forever(options,exchange)
    elsif options.i > 1
      publish_iterations(options,exchange)
    else
      publish_once(options,exchange)
    end
  end

  def publish_once(options,exchange)
    msg = get_message_type(options)
    n = options.n
    msgs = msg.build_n_messages(n)
    for i in 1..n
      exchange.publish(msgs[i].to_json)
    end
    if options.verbose == true
      print n, " messages were published to ", options.e; puts
    end
  end

  def publish_iterations(options,exchange)
    seconds = options.s
    iterations = options.i
    for i in 1..iterations
      msg = get_message_type(options)
      n = options.n
      msgs = msg.build_n_messages(n)
      for i in 1..n
        exchange.publish(msgs[i].to_json)
      end
      if options.verbose == true
        print n, " messages were published to ", options.e; puts
      end
      sleep seconds
    end
  end

  def publish_forever(options,exchange)
    while true
      seconds = options.s
      iterations = options.i
      for i in 1..iterations
        msg = get_message_type(options)
        n = options.n
        msgs = msg.build_n_messages(n)
        for i in 1..n
          exchange.publish(msgs[i].to_json)
        end
        if options.verbose == true
          print n, " messages were published to ", options.e; puts
        end
        sleep seconds
      end
    end
  end

  def get_message_type(options)
    if options.m == 'uuid'
      if options.verbose
        puts 'Inside MsgUUID'
      end
      MsgUUID.new(options)
    elsif options.m == 'user-agent'
      if options.verbose
        puts 'Inside MsgUserAgent'
      end
      MsgUserAgent.new(options)
    elsif options.m == 'job-skills'
      if options.verbose
        puts 'Inside Msgjob'
      end
      Msgjob.new(options)
    else
      print 'publisher.rb ', options.m, ' is not a supported message dimension'
      puts
      exit
    end
  end
end
