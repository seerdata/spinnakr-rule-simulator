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
    ['count','sum','average','standard_deviation'].sample
  end

  def buildrule
    rule_hash = Hash.new
    rule_hash[:account] = get_account
    rule_hash[:project] = get_project
    rule_hash[:dimension] = get_dimension
    rule_hash[:key] = get_key
    rule_hash[:calculation] = get_calculation
    rule_hash[:threshold] = get_threshold
    rule_hash[:operator] = get_operator
    rule_hash[:interval] = get_interval
    rule_hash
  end

end

=begin
require_relative './options'
myoptions = Options.new
options = myoptions.parse(ARGV)
rule = RuleComparator.new(options)
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
