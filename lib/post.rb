require 'rest_client'
require 'json'

class Post

  def buildURL(options)
    hostname = options.g
    port = options.p
    endpoint = "api/1.0/rule/" + options.t
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
