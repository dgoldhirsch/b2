require 'spec_helper'
require 'b2_controller_spec_helper'

describe InvoicesController do
  render_views

  # Background
  # Given a user
  let!(:user) { FactoryGirl.create(:user) }

  # With a customer
  let!(:customer) do
    result = FactoryGirl.create(:customer, user: user)
    user.customers << result
    result
  end

  # With an invoice
  let!(:invoice) do
    result = FactoryGirl.create(:invoice, customer: customer)
    customer.invoices << result
    result
  end

  describe "GET index" do
    context "given that I'm signed in" do
      before { sign_in(user) }

      context "and given a red-herring, additional customer and invoice" do
        before do
          other_customer = FactoryGirl.create(:customer, user: user)
          other_customer.invoices << FactoryGirl.create(:invoice, customer: other_customer)
        end

        describe "when I GET the INDEX of invoices" do
          let!(:html) { get :index, customer_id: customer.id }
          it { expects(html).to be_success }
          it { expects(html).to render_template("index") }

          it "finds only the invoice for the asked-for customer" do
            expect(assigns(:invoices).to_set).to eq(Set[invoice])
          end
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I GET the INDEX of invoices" do
        before { get :index, customer_id: customer }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "GET show" do
    context "given that I'm signed in" do
      before { sign_in(user) }

      describe "when I SHOW one of my invoices" do
        let!(:html) { get :show, customer_id: customer.id, id: invoice.id }
        it { expects(html).to be_success }
        it { expects(html).to render_template("show") }

        it "finds the right invoice" do
          expect(assigns(:invoice)).to eq(invoice)
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I SHOW one of my invoices" do
        before { get :show, customer_id: customer, id: invoice.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "GET edit" do
    context "given that I'm signed in" do
      before { sign_in(user) }

      describe "when I EDIT one of my invoices" do
        let!(:html) { get :edit, customer_id: customer.id, id: invoice.id }
        it { expects(html).to be_success }
        it { expects(html).to render_template("edit") }

        it "finds the right invoice" do
          expect(assigns(:invoice)).to eq(invoice)
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I EDIT one of my invoices" do
        before { get :edit, customer_id: customer, id: invoice.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end

  describe "DELETE destroy" do
    context "given that I'm signed in" do
      before { sign_in(user) }

      context "when I DELETE one of my invoices" do
        let!(:html) { delete :destroy, customer_id: customer.id, id: invoice.id }

        it "finds the right invoice" do
          expect(assigns(:invoice)).to eq(invoice)
        end

        it "redirects to the (customer's) index of invoices" do
          expects(html).to redirect_to(customer_invoices_path(customer))
        end
      end
    end

    context "given that I'm not signed in" do
      describe "when I DELETE one of my invoices" do
        before { delete :destroy, customer_id: customer.id, id: invoice.id }
        it_behaves_like "redirects to sign in"
      end
    end
  end
end
