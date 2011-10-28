class SdbBackup
  module Reader

    class SdbDomain

      def read
        puts "reading domains"
        @sdb.domains
      end

      def initialize(sdb)
        @sdb = sdb
      end
    end

  end
end
