class SdbBackup
  module Writer

    class Xml

      def initialize(path)
        @path = path
      end

      def write(data)
        print data.inspect
      end

    end
  end
end
