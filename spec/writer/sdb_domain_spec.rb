require 'spec_helper'

describe SdbBackup::Writer::SdbDomain do

  let(:domain_1) { AWS::SimpleDB::Domain.new('test-domain-1') }
  let(:domain_2) { AWS::SimpleDB::Domain.new('test-domain-2') }
  let(:item) { AWS::SimpleDB::Item.new(domain_1, 'test-item') }
  let(:sdb) { mock(AWS::SimpleDB) } 
  let(:writer) { SdbBackup::Writer::SdbDomain.new(sdb) }

  context "#initialize" do
  
    it "requires an access key and secret key" do
      lambda { SdbBackup::Writer::SdbDomain.new }.should raise_error(ArgumentError)
    end

    it "should accept an access key and secret key" do 
      lambda { 
        SdbBackup::Writer::SdbDomain.new({ 
          :access_key_id => 'test', 
          :secret_access_key => 'test' 
        })
      }.should_not raise_error
    end

  end

  context "#write" do

    it "should clear all domains in the target environment" do
      domain_1.should_receive(:delete!)
      domain_2.should_receive(:delete!)
      sdb.should_receive(:domains).and_return([domain_1, domain_2])

      writer.write([])
    end

    it "should create a copy of each domain in the data to write" do
      mock_domain_collection = mock(AWS::SimpleDB::DomainCollection)      
      sdb.should_receive(:domains).any_number_of_times.and_return mock_domain_collection

      # for the purposes of this test the domains have no items
      domain_1.should_receive(:items).and_return []
      domain_2.should_receive(:items).and_return []

      mock_domain_collection.should_receive(:create).with('test-domain-1')
      mock_domain_collection.should_receive(:create).with('test-domain-2')
      mock_domain_collection.stub(:each)

      writer.write([domain_1, domain_2])
    end

    it "should create a copy of each item in a domain in the data to write" do
      item.stub_chain(:attributes, :to_h).and_return({ :one => 'one', :two => 'two' })
      domain_1.should_receive(:items).and_return [item]
       
      sdb.stub_chain(:domains, :create)
      sdb.stub_chain(:domains, :each)

      mock_item_collection = mock(AWS::SimpleDB::ItemCollection)
      mock_item_collection.should_receive(:create).with('test-item', { :one => 'one', :two => 'two' })

      sdb.stub_chain(:domains, :[], :items).and_return mock_item_collection

      writer.write([domain_1])
    end

  end
end
