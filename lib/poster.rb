
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
    n = options.n
    rule = get_rule_type(options)
    rules = rule.build_n_rules(n)
    @post.process_data(options,rules)
    if options.verbose == true
      print options.n, " rules were published to the api"; puts
    end
  end

  def get_rule_type(options)
    if options.z == 'comparator'
      if options.verbose
        puts 'Inside Comparator'
      end
      RuleComparator.new(options)
    elsif options.z == 'observer'
      if options.verbose
        puts 'Inside Observer'
      end
      RuleObserver.new(options)
    else
      print 'poster.rb ', options.z, ' is not a supported rule type'
      puts
      exit
    end
  end
end
