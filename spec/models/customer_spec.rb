require 'spec_helper'

describe Customer do
  it { should belong_to(:user) }
end
