require 'sdb-backup'
require 'optparse'

class SdbBackup
  
  class CLI
    
    def run

      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: sdb-backup [options]"

        opts.on("-f", "--from=[sdb|xml]", "Backup source") do |f|
          options[:from] = f
        end

        opts.on("-t", "--to=[sdb|xml]", "Backup destination") do |t|
          options[:to] = t 
        end

        opts.on("-c", "--config=<filename>", "YAML configuration file") do |c|
          options[:config_file] = c
        end

        opts.on("-x", "--xml=<filename>", "Location of XML backup") do |c|
          options[:xml_path] = c
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!

      puts options
      puts options[:source]

      config = YAML.load_file(options[:config_file])
      puts config.inspect

      case options[:from]
      when "sdb"
        reader = SdbBackup::Reader::SdbDomain.new(AWS::SimpleDB.new(config['source']['sdb']))
      when "xml"
        puts "Reader not supported"
        exit
      end

      case options[:to]
      when "sdb"
        writer = SdbBackup::Writer::SdbDomain.new(AWS::SimpleDB.new(config['destination']['sdb']))
      when "xml"
        raise "Must provide a path to the XML backup file with --xml" if options[:xml_path].nil?
        writer = SdbBackup::Writer::Xml.new(options[:xml_path])
      end

      sdb_backup = SdbBackup.new(reader, writer)
      sdb_backup.perform

    end
  end
end
