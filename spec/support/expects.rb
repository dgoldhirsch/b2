# This doesn't read well:
#
#   it { expect(a).to be_true }
#
# This is grammatically correct, so it's nicer to read:
#
#   it { expects(a).to be_true }
#
module RSpec
  module Matchers
    alias_method :expects, :expect
  end
end
