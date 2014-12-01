
require_relative './post'
require_relative './rulecomparator'
require_relative './ruleobserver'
require 'json'

class Poster

  def initialize
    @post = Post.new
  end

  def publish(options)
      publish_once(options)
  end

  def publish_once(options)
    rule = get_rule_type(options)
    n = options.n
    type = options.t
    rules = rule.build_n_rules(n)
    for i in 1..n
      if type == 'comparator'
        @post.comparator(rules[i])
      elsif type == 'observer'
        @post.observer(rules[i])
      else
        print 'publish once type not found'
      end
    end
    if options.verbose == true
      print n, " rules were published to the api"; puts
    end
  end

  def get_rule_type(options)
    if options.t == 'comparator'
      if options.verbose
        puts 'Inside Comparator'
      end
      RuleComparator.new(options)
    elsif options.t == 'observer'
      if options.verbose
        puts 'Inside Observer'
      end
      RuleObserver.new(options)
    else
      print 'poster.rb ', options.t, ' is not a supported rule type'
      puts
      exit
    end
  end
end
