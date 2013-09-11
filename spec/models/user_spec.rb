require 'spec_helper'

describe User do
  it { should have_many(:customers) }
end

describe "User" do

  context "#valid?" do
    let!(:existing_user) { FactoryGirl.create(:user, email: user.email.swapcase) }
    subject(:user) { FactoryGirl.build(:user) }

    it "Fails validation, with a message about email" do
      expects(user).to_not be_valid
      email_message = user.errors.full_messages.detect { |m| m =~ /[Ee]mail/ }
      expect(email_message).to_not be_nil
    end
  end  
end
