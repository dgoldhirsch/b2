require 'spec_helper'
require 'b2_controller_spec_helper'

describe UsersController do
  let!(:user) { create(:user) }

  describe "DELETE destroy" do
    context "given I'm signed in as the super-user" do
      before { sign_in(user) }

      describe "when I DELETE myself" do
        let!(:html) { delete :destroy, id: user.id }
        it { expects(html).to redirect_to(users_path) } # Hey, wait a minute, maybe this shouldn't be allowed???
      end
    end

    context "given that I'm not signed in" do
      before { delete :destroy, id: user.id }
      it_behaves_like "redirects to sign in"
    end
  end

  describe "GET edit" do
    context "given that I'm signed in as an ordinary user" do
      before { sign_in(user) }

      describe "when I EDIT myself" do
        let!(:html) { get :edit, id: user.id }
        it { expects(html).to be_success }
        it { expects(html).to render_template("edit") }

        it "finds the right user" do
          expect(assigns(:user)).to eq(user)
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I EDIT myself" do
        before { get :edit, id: user.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "GET index" do
    context "given that I'm signed in as the super-user" do
      before { sign_in(user) }

      describe "when I GET the INDEX of users" do
        let!(:html) { get :index }

        it { expects(html).to be_success }
        it { expects(html).to render_template("index") }

        it "finds the right users" do
          expect(assigns(:users).to_set).to eq(Set[user])
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I GET the INDEX of users" do
        before { get :index }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "GET show" do
    context "given that I'm signed in as the super-user" do
      before { sign_in(user) }

      describe "when I SHOW myself" do
        let!(:html) { get :show, id: user.id }
        it { expects(html).to be_success }
        it { expects(html).to render_template("show") }

        it "finds the right user" do
          expect(assigns(:user)).to eq(user)
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I SHOW myself" do
        before { get :show, id: user.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end
end
