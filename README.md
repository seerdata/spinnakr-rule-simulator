
To install the simulator

```
git clone git@github.com:stormasm/spinnakr-rule-simulator.git
cd spinnakr-rule-simulator
bundle install
```

**To run the simulator redis and Spn.ee must first be running**

For install instructions to run Spn.ee go
[here]
(https://github.com/stormasm/spinnakr-spne)

After Spn.ee is up and running then go to the lib directory
in the rule simulator.

**To run the simulator you must be in the lib directory**

To see the options that you can pass into the simulator:

```
ruby sim.rb -h
```

#### Default Use

To run the rule simulator with no options simply run this command

```
ruby sim.rb
```

#### Verbosity

All output from the simulator is available in verbose mode

```
ruby sim.rb -v
```

#### Event Type

The default Event Type is **comparator**, to send in an **observer** Event Type
run this command.

```
ruby sim.rb -t observer
```

#### Dimension String

By default the dimension string is **job-skills**.

If you want a different dimension string then you can issue this command.

```
ruby sim.rb -m weather-city
```

#### Number of rules

The default number of rules that get sent to redis is 2

To send more than 2 rules run this command

```
ruby sim.rb -n 10
```
