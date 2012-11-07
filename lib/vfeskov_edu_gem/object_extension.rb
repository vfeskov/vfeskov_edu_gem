class Object

  def to_json
    if self.instance_variables.length == 0
      if self.class.name == 'Array'
        result = '['
        first = true
        self.each do |item|
          result += ',' unless first
          result += item.to_json
          first = false
        end
        result += ']'
      else
        result = '"' + self.to_s + '"'
      end
    else
      result = "{";
      first = true
      self.instance_variables.each do |variable_symbol|

        if defined? self.should_variable_be_serialized?
          next unless self.should_variable_be_serialized?(variable_symbol)
        end

        result += ',' unless first
        variable_name = variable_symbol.to_s.gsub(/@/,'')
        variable = self.instance_variable_get(variable_symbol)
        result += '"' + variable_name + '":' + variable.to_json
        first = false

      end
      result += "}"
    end
    return result
  end

  alias_method :orig_to_json, :to_json
end