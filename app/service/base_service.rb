class BaseService
  include ActiveModel::Validations

  def initialize(*params)
    raise 'params必须是一个hash' unless params.is_a? Hash

    params.each { |key, value| instance_variable_set("@#{key}", value)}
    exec
  end

  def execute_validation(*validate_methods)
    validate_methods.each do |validate_method|
      break if errors.any?

      send(validate_method)
    end
  end

  def error_add

  end

  def exec

  end
end
