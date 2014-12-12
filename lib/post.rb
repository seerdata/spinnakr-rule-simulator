require 'bunny'
require 'json'
require 'rest_client'

class Post

  #
  # RestClient
  #

  def buildURL(options)
    hostname = options.g
    port = options.p
    if options.ep2 != ""
      endpoint = options.ep1 + "/" + options.ep2
    else
      endpoint = options.ep1
    end
    url = "http://" + hostname + ":" + port + "/" + endpoint
  end

  def post_rest(rules,url)
    n = rules.length
    x = n - 1
    for i in 0..x
      hmap = rules[i]
      jdata = hmap.to_json
      response = RestClient.post url, jdata, :content_type => :'application/json'
      puts response
    end
  end

  def process_url(options,rules)
    url = buildURL(options)
    post_rest(rules,url)
  end

  #
  # File
  #

  def process_file(options,rules)
    filename = options.f

    if filename == ""
      puts "Please enter a filename"
      exit
    end

    json_array_length = rules.length
    count = 1

    if json_array_length != 0
      fx = File.open(filename.to_s,"w")
      fx.write("[")
      rules.each do |item|
        myjson = JSON::generate(item)
        fx.write(myjson)
        if count < json_array_length
          fx.write(",")
          count = count + 1
          print 'count = ', count; puts
        end
      end
      fx.write("]")
      print 'wrote json data to filename ', options.f; puts
    end
  end

  #
  # RabbitMQ
  #

  def process_queue(options,rules)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    exchange_name = options.e
    exchange = channel.fanout(exchange_name, :passive => true)

    n = rules.length
    x = n - 1
    for i in 0..x
      exchange.publish(rules[i].to_json)
    end
    if options.verbose == true
      print n, " messages were published to ", options.e; puts
    end
  end

  def process_rules(options,rules)
    x = options.x
    if (x == "1")
      process_url(options,rules)
    elsif (x == "2")
      process_file(options,rules)
    elsif (x == "3")
      process_queue(options,rules)
    else
      puts 'Not a URL, File, or Queue'
    end
  end

end
