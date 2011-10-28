# sdb-backup

sdb-backup provides an easy way to back up and restore SimpleDB data.  It can be used within Ruby code or from the command line.

In Ruby code, to use the utility, you need to create a reader (the source of the data to be backed up) and a writer (the destination of the data).  Right now, the only readers and writers read from and write to SimpleDB domains directly (i.e. it's currently not possible to back up to an XML file, or restore from one).  Hopefully this will change soon.

To instantiate a SimpleDB domain reader, you need an AWS::SimpleDB instance, which in turn is created by passing in a hash containing :access_key_id and :secret_access_key:

    source_sdb = AWS::SimpleDB.new({ :access_key_id => 'xxx', :secret_access_key => 'xxx' })
    reader = SdbBackup::Reader::SdbDomain.new(source_sdb)

A writer is created similarly:

    destination_sdb = AWS::SimpleDB.new({ :access_key_id => 'xxx', :secret_access_key => 'xxx' })
    writer = SdbBackup::Writer::SdbDomain.new(destination_sdb)

Create the instance of SdbBackup by passing in the reader and writer:

    backup = SdbBackup.new(reader, writer)

And perform the backup by calling `perform`:

    backup.perform

For a SdbDomain reader/writer combination, this will read all the domains from the source environment, delete all domains from the destination enviroment, and copy the domains from the source to the destination.  It's important to remember that ALL domains will be deleted from the destination domain, not just those that are included in the source domain.

## Contributing to sdb-backup
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 ryan-mitchell. See LICENSE.txt for
further details.

