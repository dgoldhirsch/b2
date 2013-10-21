module B2CoreSteps
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
end