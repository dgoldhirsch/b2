require 'spec_helper'
require 'b2_controller_spec_helper'

describe CustomersController do
  render_views

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

  describe "DELETE destroy" do
    context "Signed in as super-user" do
      before { sign_in(superuser) }
      let!(:response) { delete :destroy, id: customer1.id }

      it "finds the right customer" do
        expect(assigns(:customer)).to eq(customer1)
      end

      it "allows deletion of anyone's customers" do
        expects(response).to redirect_to(customers_path)
      end
    end

    context "Signed in as user" do
      before { sign_in(user1) }

      context "Trying to delete his customer" do
        let!(:response) { delete :destroy, id: customer1.id }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer1)
        end

        it "allows deletion" do
          expects(response).to redirect_to(customers_path)
        end
      end

      context "Trying to delete someone else's customer" do
        let!(:response) { delete :destroy, id: customer2.id }
        it_behaves_like "unauthorized"
      end
    end

    context "Not signed in" do
      let!(:response) { delete :destroy, id: superuser.id }
      it_behaves_like "redirects to sign in"
    end
  end

  describe "GET edit" do
    context "Signed in as super-user" do
      before { sign_in(superuser) }
      let!(:response) { get :edit, id: customer1.id }

      it { expects(response).to be_success }

      it "finds the right customer" do
        expect(assigns(:customer)).to eq(customer1)
      end

      it "renders view" do
        expect(response).to render_template("edit")
      end
    end

    context "Signed in as user" do
      before { sign_in(user1) }

      context "Trying to edit his customer" do
        let!(:response) { get :edit, id: customer1.id }

        it { expects(response).to be_success }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer1)
        end

        it "allows deletion" do
          expects(response).to render_template("edit")
        end
      end

      context "Trying to edit someone else's customer" do
        let!(:response) { get :edit, id: customer2.id }
        it_behaves_like "unauthorized"
      end
    end

    context "Not signed in" do
      let!(:response) { get :edit, id: customer1.id }
      it_behaves_like "redirects to sign in"
    end
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

    context "Signed in as user" do
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

  describe "GET show" do
    context "Signed in as super-user" do
      before { sign_in(superuser) }
      let!(:response) { get :show, id: customer1.id }

      it { expects(response).to be_success }

      it "finds the right customer" do
        expect(assigns(:customer)).to eq(customer1)
      end

      it "renders the right view" do
        expect(response).to render_template("show")
      end
    end

    context "Signed in as user" do
      before { sign_in(user1) }

      context "Trying to show his customer" do
        let!(:response) { get :show, id: customer1.id }

        it { expects(response).to be_success }

        it "finds the right customer" do
          expect(assigns(:customer)).to eq(customer1)
        end

        it "renders the right view" do
          expects(response).to render_template("show")
        end
      end

      context "Trying to show someone else's customer" do
        let!(:response) { get :show, id: customer2.id }
        it_behaves_like "unauthorized"
      end
    end

    context "Not signed in" do
      let!(:response) { get :show, id: customer2.id }
      it_behaves_like "redirects to sign in"
    end
  end
end
