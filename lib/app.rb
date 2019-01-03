module App

  def self.hello
    "ewqewq"
  end

  def self.migration_hash
    @_migration_hash ||= Digest::MD5.hexdigest(migration_version)
  end
end