require 'optparse'
require 'ostruct'
require 'pp'

class Options

  def parse(args)

    options = OpenStruct.new
    options.verbose = false

    options.i = 1
    options.m = "job-skills"
    options.n = 2
    options.s = 10
    options.t = "comparator"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: sim.rb [options]"

      # Boolean switch.
      opts.on("-v", "Run verbosely") do |v|
        options.verbose = v
      end

      # Dimension Options

      opts.on("-m Dimension", "String Dimension name") do |m|
        options.m = m
      end

      # Rule Type

      opts.on("-t Type", "String Rule Type name") do |t|
        options.t = t
      end

      # Integer Options

      opts.on("-n Rules", Integer, "Integer Send in n rules") do |x|
        options.n = x
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
