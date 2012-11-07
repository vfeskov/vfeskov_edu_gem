require 'vfeskov_edu_gem/object_extension'
require 'vfeskov_edu_gem/version'

module VfeskovEduGem
  def self.extend_to_json(object)

    def object.to_be_serialized(*fields)
      @to_be_serialized = []
      fields.each do |field|
        @to_be_serialized << field.to_s.gsub(/@/,'')
      end
    end

    def object.should_variable_be_serialized?(variable_symbol)
      variable_name = variable_symbol.to_s.gsub(/@/,'')
      if defined? @to_be_serialized
        serialize = false
        if @to_be_serialized.length > 0 && variable_name != 'to_be_serialized'
          @to_be_serialized.each do |to_be_serialized|
            if to_be_serialized == variable_name
              serialize = true
              break
            end
          end
        end
      else
        serialize = true
      end
      return serialize
    end

    def object.method_missing(name, *args)
      if name.to_s =~ /to_json_for_/
        prev_state = @to_be_serialized

        @to_be_serialized = []
        variables = name.to_s[12..-1].split('_and_');
        variables.each do |variable_name|
          @to_be_serialized << variable_name
        end

        json = self.to_json

        @to_be_serialized = prev_state

        return json
      else
        super
      end
    end

    def object.to_json
      json = self.orig_to_json
      json.gsub!(/([\"\'\&\/\\\@])/,'\\\\\1')
      return json
    end

  end
end
