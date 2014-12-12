require 'optparse'
require 'ostruct'
require 'pp'

class Options

  def parse(args)

    options = OpenStruct.new
    options.verbose = false

    ### 1 = URL, 2 = File, 3 = Queue

    options.x = "1"

    ### One can post to a URL, File, or Queue

    options.e = "test.spnee.rules"
    options.f = "mydata.json"

    ### Components of the URL
    options.g = "localhost"
    options.p = "4567"

    ### Endpoint Part1 and Part2

    options.y = "api/1.0/rule"
    # This is also the rule type
    options.z = "comparator"

    options.m = "job-skills"
    options.n = 2

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: sim.rb [options]"

      opts.on("-x PostType", "String 1 = URL, 2 = File, 3 = Rabbit") do |q|
        options.x = q
      end

      opts.on("-e Exchange", "String RabbitMQ Exchange name") do |q|
        options.e = q
      end

      opts.on("-f File", "String File name") do |f|
        options.f = f
      end

      opts.on("-g Host", "String Host name") do |q|
        options.g = q
      end

      opts.on("-p Port", "String Port number") do |q|
        options.p = q
      end

      opts.on("-y Endpoint1", "String Endpoint Part 1") do |q|
        options.y = q
      end

      opts.on("-z Endpoint2", "String Endpoint Part 2 and RuleType") do |q|
        options.z = q
      end


      # Dimension Options

      opts.on("-m Dimension", "String Dimension name") do |m|
        options.m = m
      end

      # Integer Options

      opts.on("-n Rules", Integer, "Integer Send in n rules") do |x|
        options.n = x
      end

      # Boolean switch.
      opts.on("-v", "Run verbosely") do |v|
        options.verbose = v
      end

      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
    opt_parser.parse!(args)
    options
  end
end

#myoptions = Options.new
#puts myoptions.parse(ARGV)
