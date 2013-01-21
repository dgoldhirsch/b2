module B2Steps
  def addition_rows(table)
    table.hashes.map do |hash|
      result = Hash.new
      result['a'] = parse_integer(hash['a'])
      result['b'] = parse_integer(hash['b'])
      result['c'] = parse_integer(hash['c'])
      result['equal?'] = parse_boolean(hash['equal?'])
      result
    end
  end

  def parse_boolean(string)
    if string
      string[0, 1].downcase == 'y'
    end
  end

  def parse_integer(string)
    if string
      string.to_i
    end
  end
  
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
