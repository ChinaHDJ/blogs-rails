module BaseService
  class NoImpExecuteDefault << Exception
  end

  def execute
    raise NoImpExecuteDefault
  end

end