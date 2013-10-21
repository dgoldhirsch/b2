module B2TurnipUnderstandingSteps
  step "the integer :n" do |n|
    @number = n.to_i
  end

  step "I add :n to it" do |n|
    @sum = @number + n.to_i
  end

  step "I get :n" do |n|
    @sum.should == n.to_i
  end

  step 'a + b = c if equal?:' do |table|
    addition_rows(table).each do |row|
      sum = row['a'] + row['b']
      if row['equal?']
        sum.should == row['c']
      else
        sum.should_not == row['c']
      end
    end
  end
end