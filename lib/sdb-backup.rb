require 'aws-sdk'
require 'reader/sdb_domain.rb'
require 'writer/sdb_domain.rb'

class SdbBackup

  def initialize(reader, writer)
    @reader = reader
    @writer = writer
  end

  def perform
    data = @reader.read
    @writer.write(data)  
  end
end
