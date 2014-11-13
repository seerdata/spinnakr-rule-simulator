require_relative './rulebase'

class RuleComparator < RuleBase

  def initialize(options)
    @options = options
  end

  def get_operator
    ["<", "<=", "=", ">", ">="].sample
  end

  def get_threshold
    ['5','10','15','20'].sample
  end

  def get_calculation
    ['count','sum','average','standard_deviation']
  end

  def buildrule
    msg_hash = Hash.new
    msg_hash[:account] = get_account
    msg_hash[:project] = get_project
    msg_hash[:dimension] = get_dimension
    msg_hash[:key] = get_key
    msg_hash[:calculation] = get_calculation
    msg_hash[:threshold] = get_threshold
    msg_hash[:operator] = get_operator
    msg_hash[:interval] = get_interval
    msg_hash
  end

  def build_n_rules(n)
    messages = []
    for i in 0..n
      mymsg = buildmsg
      messages.push(mymsg)
    end
    messages
  end
end


require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
rule = RuleComparator.new(options)
puts rule.buildrule

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
msg = Msgjob.new(options)
n = 3
msgs = msg.build_n_messages(n)
for i in 0..n
  puts msgs[i]
end
=end
