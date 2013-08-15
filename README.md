#Ski Binding Value Calculator
[![Gem Version](https://badge.fury.io/rb/ski_binding_calculator.png)](http://badge.fury.io/rb/ski_binding_calculator)

Calculates the z-value according to ISO 11088.

### Input & Measuring Units
You can give the calculator a hash with the below specified attributes. The <code>weight</code>, <code>height</code>, and <code>shoe_size</code> can be given as strings or floats. <code>birthday</code> and <code>type</code> must be strings. The measuring units and formats of the attributes are as follows:
 
- <code>weight</code> [kg]
- <code>height</code> [cm]
- <code>shoe_size</code> [mm]
- <code>birthday</code> [yyyy-mm-dd]
- <code>type</code> ["Type1-", "Type1", "Type2", "Type3", "Type3+"]

###Codes
In ISO 11088 Table B.1 are codes defined. We redefined the names of those codes from one letter to one digit as follows:
- A => 0
- B => 1
- C => 2
- D => 3
- E => 4
- F => 5
- G => 6
- H => 7
- I => 8
- J => 9
- K => 10
- L => 11
- M => 12
- N => 13
- O => 14
- P => 15

Therefore we can use the names of the codes as array indexes in the yaml files.

### Feedback
If you have questions or suggestions don't hesitate open an issue.