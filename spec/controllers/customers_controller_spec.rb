require 'spec_helper'
require 'b2_controller_spec_helper'

describe CustomersController do
  render_views

  # Background
  # Given a super-user
  let!(:superuser) { FactoryGirl.create(:user, superuser: true) }

  # A regular user
  let!(:user) { FactoryGirl.create(:user) }

  # And a customer for the regular user
  let!(:customer) do
    result = FactoryGirl.create(:customer, user: user)
    user.customers << result
    result
  end

  # And a red-herring customer for another user
  let!(:other_customer) do
    other_user = FactoryGirl.create(:user)
    result = FactoryGirl.create(:customer, user: other_user)
    other_user.customers << result
    result
  end

  describe "GET index" do

    context "given that I'm signed in as the super-user" do
      before { sign_in(superuser) }

      describe "when I GET the INDEX of customers" do
        let!(:html) { get :index }
        it { expects(html).to be_success }
        it { expects(html).to render_template("index") }

        it "finds all customers (regardless of their owning users)" do
          expect(assigns(:customers).to_set).to eq(Customer.all.to_set)
        end
      end
    end

    context "given that I'm signed in as an ordinary user" do
      before { sign_in(user) }

      describe "when I GET the INDEX of customers" do
        let!(:html) { get :index }
        it { expects(html).to be_success }
        it { expects(response).to render_template("index") }

        it "finds only my customers" do
          expect(assigns(:customers).to_set).to eq(Set[customer])
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I GET the INDEX of customers" do
        before { get :index }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "GET show" do
    context "given that I'm signed in as the super-user" do
      before { sign_in(superuser) }

      describe "when I SHOW one of my customers" do
        let!(:html) { get :show, id: customer.id }
        it { expects(response).to be_success }
        it { expects(response).to render_template("show") }

        it "finds the customer" do
          expect(assigns(:customer)).to eq(customer)
        end
      end
    end

    context "given that I'm signed in as an ordinary user" do
      before { sign_in(user) }

      describe "when I SHOW of one of my customers" do
        let!(:html) { get :show, id: customer.id }
        it { expects(response).to be_success }
        it { expects(response).to render_template("show") }

        it "finds the customer" do
          expect(assigns(:customer)).to eq(customer)
        end
      end

      describe "when I SHOW someone else's customer" do
        before { get :show, id: other_customer.id }
        it_behaves_like "unauthorized"
      end
    end

    context "given that I'm not signed in" do
      describe "when I SHOW one of my customers" do
        before { get :show, id: customer.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "GET edit" do
    context "given that I'm signed in as the super-user" do
      before { sign_in(superuser) }

      describe "when I EDIT one of my customers" do
        let!(:html) { get :edit, id: customer.id }
        it { expects(html).to be_success }
        it { expects(html).to render_template("edit") }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer)
        end
      end
    end

    context "given that I'm signed in as an ordinary user" do
      before { sign_in(user) }

      describe "when I EDIT one of my customers" do
        let!(:html) { get :edit, id: customer.id }
        it { expects(html).to be_success }
        it { expects(html).to render_template("edit") }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer)
        end
      end

      describe "when I EDIT someone else's customer" do
        let!(:html) { get :edit, id: other_customer.id }
        it_behaves_like "unauthorized"
      end
    end

    context "given that I'm not signed in" do
      describe "when I EDIT for one of my customers" do
        before { get :edit, id: customer.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "DELETE destroy" do
    context "given that I'm signed in as the super-user" do
      before { sign_in(superuser) }

      describe "when I DELETE one of my customers" do
        let!(:html) { delete :destroy, id: customer.id }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer)
        end

        it "redirects to the INDEX of customers" do
          expects(response).to redirect_to(customers_path)
        end
      end
    end

    context "given that I'm signed in as an ordinary user" do
      before { sign_in(user) }

      describe "when I DELETE one of my customers" do
        let!(:html) { delete :destroy, id: customer.id }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer)
        end

        it "redirects to the INDEX of customers" do
          expects(html).to redirect_to(customers_path)
        end
      end

      describe "when I DELETE someone else's customer" do
        before { delete :destroy, id: other_customer.id }
        it_behaves_like "unauthorized"
      end
    end
  end

  context "given that I'm not signed in" do
    describe "when I DELETE one of my customers" do
      before { delete :destroy, id: superuser.id }
      it_behaves_like "redirects to sign in"
    end
  end
end
