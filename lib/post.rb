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
    if options.z != ""
      endpoint = options.y + "/" + options.z
    else
      endpoint = options.y
    end
    url = "http://" + hostname + ":" + port + "/" + endpoint
  end

  def post_rest(data,url)
    n = data.length
    x = n - 1
    for i in 0..x
      hmap = data[i]
      postjson = hmap.to_json
      response = RestClient.post url, postjson, :content_type => :'application/json'
      puts response
    end
  end

  def process_url(options,data)
    url = buildURL(options)
    post_rest(data,url)
  end

  #
  # File
  #

  def process_file(options,data)
    filename = options.f

    if filename == ""
      puts "Please enter a filename"
      exit
    end

    json_array_length = data.length
    count = 1

    if json_array_length != 0
      fx = File.open(filename.to_s,"w")
      fx.write("[")
      data.each do |item|
        myjson = JSON::generate(item)
        fx.write(myjson)
        if count < json_array_length
          fx.write(",")
          count = count + 1
          print 'count = ', count; puts
        end
      end
      fx.write("]")
      print 'wrote json to filename ', options.f; puts
    end
  end

  #
  # RabbitMQ
  #

  def process_queue(options,data)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    exchange_name = options.e
    exchange = channel.fanout(exchange_name, :passive => true)

    n = data.length
    x = n - 1
    for i in 0..x
      exchange.publish(data[i].to_json)
    end
    print n, " messages were published to rabbitmq exchange ", options.e; puts
  end

  def process_data(options,data)
    x = options.x
    if (x == "1")
      process_url(options,data)
    elsif (x == "2")
      process_file(options,data)
    elsif (x == "3")
      process_queue(options,data)
    else
      puts 'Not a URL, File, or Queue'
    end
  end

end
