module B2UserSteps
  step "a user with a customer" do
    @customer = create(:customer)
    @user = @customer.user
  end

  step "I am signed in as the user" do
    @user ||= create(:user)
    visit new_user_session_path
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_on "Sign in"
  end
end