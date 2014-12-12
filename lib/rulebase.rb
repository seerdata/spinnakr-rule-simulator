class RuleBase


  def get_account
    ['1','2','3'].sample
  end

  def get_project
    ['1','2','3'].sample
  end

  def get_dimension
    @options.m
  end

  def get_key
    ['ruby','java','python'].sample
  end

  def get_interval
    ['hours','days','weeks','months'].sample
  end

  def build_n_rules(n)
    x = n - 1
    rules = []
    for i in 0..x
      myrule = buildrule
      rules.push(myrule)
    end
    rules
  end

end
