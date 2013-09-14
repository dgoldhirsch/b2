shared_examples_for "redirects to sign in" do
  it { expects(response).to redirect_to(new_user_session_path) }
end

shared_examples_for "unauthorized" do
  it { expects(response).to be_forbidden } # synonymous with response.status == 403
end