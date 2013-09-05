require 'spec_helper'

describe "User" do
  let!(:user) { FactoryGirl.build(:user) }

  context "#valid?" do
              
    context "Given a created user with the same e-mail (regardless of case)" do
      let!(:existing_user) { FactoryGirl.create(:user, email: user.email.swapcase) }
      
      it "Fails validation, with a message about email" do
        expects(user).to_not be_valid
        email_message = user.errors.full_messages.detect { |m| m =~ /[Ee]mail/ }
        expect(email_message).to_not be_nil
      end
    end
    
    context "Given a created user with a different e-mail" do
      let!(:existing_user) { FactoryGirl.create(:user, email: 'a' + user.email) }
      it { expects(user).to be_valid }          
    end
  end  
end
