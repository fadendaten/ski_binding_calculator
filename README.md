#Ski Binding Value Calculator

Calculate the z-value, forward-pressure and turning moment according to ISO 11088.

### Measuring Units
You can give the caluclator a person. The units for the attributes of a person are as follows:
 
- type ["Type1-", "Type1", "Type2", "Type3", "Type3+"]
- weight [kg]
- height [cm]
- shoe size [mm]
- age [yr] 

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

Therefore we can see the codes as array indexes in our yaml files.