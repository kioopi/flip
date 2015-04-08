require "spec_helper"

# Perhaps this is silly, but it provides some
# coverage to an important base class.
describe Flip::AbstractStrategy do

  its(:name) { should == "abstract" }
  it { should_not be_switchable }

end
