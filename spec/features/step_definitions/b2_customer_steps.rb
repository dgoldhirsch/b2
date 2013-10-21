module B2CustomerSteps
  step "I should be on the customers page" do
    page.should have_selector(".customers_index_page")
  end
end