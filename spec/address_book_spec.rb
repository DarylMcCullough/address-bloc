 require_relative '../models/address_book'
 
 RSpec.describe AddressBook do
   describe "attributes" do
     it "responds to entries" do
       book = AddressBook.new
       expect(book).to respond_to(:entries)
     end
      it "initializes entries as an array" do
       book = AddressBook.new
       expect(book.entries).to be_an(Array)
     end
 
     it "initializes entries as empty" do
       book = AddressBook.new
       expect(book.entries.size).to eq(0)
     end
   end
   
   let(:book1) do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       book
   end
   
    let(:book2) do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Charles Babbage', '607.222.3333', 'chuck-b@babbage.com')
       book
   end

   describe "#add_entry" do
     it "adds only one entry to the address book" do
       expect(book1.entries.size).to eq(1)
     end
 
     it "adds the correct information to entries" do
       new_entry = book1.entries[0]
 
       expect(new_entry.name).to eq('Ada Lovelace')
       expect(new_entry.phone_number).to eq('010.012.1815')
       expect(new_entry.email).to eq('augusta.king@lovelace.com')
     end
   end
   
   describe "#remove_entry" do
     it "removes only one entry to the address book" do
       book2.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       expect(book2.entries.size).to eq(1)
     end
 
     it "removes the correct information to entries" do
        book2.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       first_entry = book2.entries[0]
       expect(first_entry.name).to eq('Charles Babbage')
     end
   end
   
   
 end