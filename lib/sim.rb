require_relative './options'
require_relative './poster'

class Sim
  def run(options)

    post = Poster.new
    post.publish(options)
    sleep 3.5
  end
end

mysim = Sim.new
myoptions = Options.new
options = myoptions.parse(ARGV)
if options.verbose == true
  puts options
end
mysim.run(options)
