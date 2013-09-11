require 'spec_helper'

describe UsersController do
  let!(:user) { FactoryGirl.create(:user) }

  shared_examples_for "redirects to sign in" do
    it { expects(response).to redirect_to(new_user_session_path) }
  end

  describe "DELETE destroy" do
    context "Signed in as super-user" do
      before { sign_in(user) }
      let!(:response) { delete :destroy, id: user.id }
      it { expects(response).to redirect_to(users_path) }
    end

    context "Not signed in" do
      let!(:response) { delete :destroy, id: user.id }
      it_behaves_like "redirects to sign in"
    end
  end

  describe "GET edit" do
    context "Signed in as super-user" do
      before { sign_in(user) }
      let!(:response) { get :edit, id: user.id }

      it { expects(response).to be_success }

      it "finds the right user" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders view" do
        expect(response).to render_template("edit")
      end
    end

    context "Not signed in" do
      let!(:response) { get :edit, id: user.id }
      it_behaves_like "redirects to sign in"
    end
  end

  describe "GET index" do
    context "Signed in as super-user" do
      before { sign_in(user) }
      let!(:response) { get :index }

      it { expects(response).to be_success }

      it "finds the right users" do
        expect(assigns(:users).to_set).to eq(Set[user])
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
      before { sign_in(user) }
      let!(:response) { get :show, id: user.id }

      it { expects(response).to be_success }

      it "finds the right user" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders view" do
        expect(response).to render_template("show")
      end
    end

    context "Not signed in" do
      let!(:response) { get :show, id: user.id }
      it_behaves_like "redirects to sign in"
    end
  end
end