require 'spec_helper'

describe CustomersController do

  let!(:superuser) { FactoryGirl.create(:user, superuser: true) }
  let!(:user1) { FactoryGirl.create(:user) }
  
  let!(:customer1) do
    result = FactoryGirl.create(:customer, user: user1)
    user1.customers << result
    result
  end
  
  let!(:user2) { FactoryGirl.create(:user) }

  let!(:customer2) do
    result = FactoryGirl.create(:customer, user: user2)
    user2.customers << result
    result
  end

  shared_examples_for "redirects to sign in" do
    it { expects(response).to redirect_to(new_user_session_path) }
  end
  
  describe "GET index" do
    context "Signed in as super-user" do
      before { sign_in(superuser) }
      let!(:response) { get :index }

      it { expects(response).to be_success }

      it "finds all customers" do
        expect(assigns(:customers).to_set).to eq(Customer.all.to_set)
      end

      it "renders view" do
        expect(response).to render_template("index")
      end
    end
  end

  context "Signed in as regular user" do
    before { sign_in(user1) }
    let!(:response) { get :index }

    it { expects(response).to be_success }

    it "finds only this user's customers" do
      expect(assigns(:customers).to_set).to eq(Set[customer1])
    end

    it "renders view" do
      expect(response).to render_template("index")
    end
  end
  
  context "Not signed in" do
    let!(:response) { get :index }
    it_behaves_like "redirects to sign in"
  end
end
