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
      self.instance_variables.each do |property_symbol|
        result += ',' unless first
        property_name = property_symbol.to_s.gsub(/@/,'')
        property = self.instance_variable_get(property_symbol)
        result += '"' + property_name + '":' + property.to_json
        first = false
      end
      result += "}"
    end
    return result
  end
end