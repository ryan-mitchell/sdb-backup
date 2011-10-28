class SdbBackup
  module Writer

    class SdbDomain

      def initialize(sdb)
        @sdb = sdb
      end

      def write(data)

        @sdb.domains.each { |domain| domain.delete! }

        data.each do |domain|
          @sdb.domains.create(domain.name)
          domain.items.each do |item|
            @sdb.domains[domain.name].items.create(item.name, item.attributes.to_h)
          end
        end
      end

    end
  end
end
