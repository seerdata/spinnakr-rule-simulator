require_relative './rulebase'

class RuleObserver < RuleBase

  def initialize(options)
    @options = options
  end

  def get_watch
    'keys'
  end

  def get_trigger
    ['5','10','15','20'].sample
  end

  def buildrule
    rule_hash = Hash.new
    rule_hash[:account] = get_account
    rule_hash[:project] = get_project
    rule_hash[:dimension] = get_dimension
    rule_hash[:key] = get_key
    rule_hash[:watch] = get_watch
    rule_hash[:trigger] = get_trigger
    rule_hash[:interval] = get_interval
    rule_hash
  end
end

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
rule = RuleObserver.new(options)
puts rule.buildrule
=end

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
