require 'aws-sdk'

class SdbBackup

  module Reader

    class BaseReader

    end

    class XmlSelectResult < BaseReader

      def read

      end
    end

    class SdbDomain < BaseReader

      def read

      end
    end
  end

  module Writer

    class SdbDomain

      def write
        
      end
    end
  end

  def initialize(reader, writer)
    @reader = reader
    @writer = writer
  end

  attr_writer :reader, :writer

  def backup_and_restore
    @reader.read
    @writer.write  
  end
end
