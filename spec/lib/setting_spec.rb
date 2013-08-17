require 'spec_helper'

describe SkiBinding::Setting do
  it { should respond_to :sole_length_range }
  it { should respond_to :z_value }
  it { should respond_to :twist }
  it { should respond_to :forward_lean }
end
