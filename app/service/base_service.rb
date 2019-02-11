class BaseService
  include ActiveModel::Validations
  private :initialize
  @options = 1

  def initialize(user:, params:)
    @user = user
    @params = params

    if invalid?

    end
  end


# @param [Object] user
# @param [Object] params
  def self.execute(user:, params:)
    self_object = self.new(user: user, params: params)
    self_object.execute
  end

  def self.option_attrs(*attr_names, to:)
    attr_names.each { |attr_name| method_name(attr_name, to[attr_name.to_sym]) }
  end

  def params
    @params
  end

  def params_object
    return @params_object if defined? @params_object

    hash_data = params
    if hash.is_a? ActionController::Parameters
      hash_data = hash_data.to_unsafe_hash
    end

    @params_object = OpenStruct.new(hash_data)
  end

  def execute_validation(*validate_methods)
    validate_methods.each do |validate_method|
      break if errors.any?

      send(validate_method)
    end
  end

  def error_add(message:, status: 400)
    errors.push(success: false, message: message, status: status)
  end

  def execute ;end

  private

  def method_name(key, value)
    class_eval <<-RUBY
        def #{key}
          #{value}
        end
    RUBY
  end

  def function(lambda)

  end
end
