#Ski Binding Value Calculator

Calculates the z-value according to ISO 11088.

### Input & Measuring Units
You can give the calculator a hash with the below specified attributes. The <pre>weight</pre>, <pre>height, and <pre>shoe_size</pre> can be given as string or float. <pre>birthday</pre> and <pre>type</pre> are strings. The measuring units of the attributes are as follows:
 
- type ["Type1-", "Type1", "Type2", "Type3", "Type3+"]
- weight [kg]
- height [cm]
- shoe size [mm]
- birthday (format: yyyy-mm-dd)

###Codes
In ISO 11088 are so-called codes defined. We redefined those one letter codes as digits as follows:
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

Therefore we can see the codes as array indexes in our yaml files.