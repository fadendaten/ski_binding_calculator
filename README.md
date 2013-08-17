#Ski Binding Release Value Calculator
[![Gem Version](https://badge.fury.io/rb/ski_binding_calculator.png)](http://badge.fury.io/rb/ski_binding_calculator)
[![Dependency Status](https://gemnasium.com/fadendaten/ski_binding_calculator.png)](https://gemnasium.com/fadendaten/ski_binding_calculator)
[![Build Status](https://travis-ci.org/fadendaten/ski_binding_calculator.png)](https://travis-ci.org/fadendaten/ski_binding_calculator])


Calculates the initial indicator value (z-value) according to ISO 11088 standard.

## Installation
Add to your Gemfile: <code>gem ski_binding_calculator</code>, run <code>$ bundle install</code>.
Even though not version 1.x this gem is stable and fully tested. Productive use is possible but at your own risk.

## Usage
You can give the calculator a hash with the following key value pairs:

| key           | value          | 
|:--------------|:---------------| 
| weight        | float, string  | 
| height        | float, string  | 
| sole_length   | float, string  |
| birthday_year | int, string    |
| birthday_month| int, string    |
| birthday_day  | int, string    |
| type          | string         |

A key can be a <code>string</code> or <code>symbol</code>.

## Measuring Units & Formats
The measuring units and formats of the attributes are as follows:

| attribute     | unit  | 
|:--------------|:------| 
| weight        | [kg]  | 
| height        | [cm]  | 
| sole_length   | [mm]  |
| birthday_year | [yyyy]|
| birthday_month| [mm]  |
| birthday_day  | [dd]  |
| type          | ["Type1-", "Type1", "Type2", "Type3", "Type3+"]  |

## Example
Regarding the last two sections a hash could look like that:

```ruby
{ :type => "Type2", 
  :weight => "70", 
  :height => "170", 
  :sole_length => "315", 
  :birthday_year => "1983", 
  :birthday_month => "01", 
  :birthday_day => "01" }
```

## Codes
In ISO 11088 table B.1 are codes defined. We map the codes to digits as follows:

|code|digit|
|:---|:----|
| A  | 0   |
| B  | 1   |
| C  | 2   |
| D  | 3   |
| E  | 4   |
| F  | 5   |
| G  | 6   |
| H  | 7   |
| I  | 8   |
| J  | 9   |
| K  | 10  |
| L  | 11  |
| M  | 12  |
| N  | 13  |
| O  | 14  |
| P  | 15  |

The mappings allow us to use the codes as array indexes in the yaml files.

## Feedback
If you have questions or suggestions don't hesitate open an issue.

## Copyright
Copyright &copy; 2013 Fadendaten GmbH. See MIT-LICENSE for details.