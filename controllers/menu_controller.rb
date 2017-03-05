require_relative '../models/address_book'

module SampleData
 NAMES = [ "Ada Lovelace", "Charles Babbage", "Alan Turing"]
 PHONES = [ "(234) 567-8901", "(345) 678-9012", "(456) 789-0123"]
 EMAILS = [ "ada_l@lovelace.net", "chuck_b@babbage.net", "turing@universal.com"]
 NUMBER_ENTRIES = 3
end
 
 class MenuController
   attr_reader :address_book
   include SampleData
   
   def initialize
     @address_book = AddressBook.new
   end
   
   def populate # I added this to create some sample data for viewing
    return if defined? @populated
    (1..NUMBER_ENTRIES).each do |i|
      name = NAMES[i-1]
      email = EMAILS[i-1]
      phone = PHONES[i-1]
      address_book.add_entry(name, phone, email)
     end
     @populated = true
    end
      
 
   def main_menu
     # #2
     puts "Main Menu - #{address_book.entries.count} entries"
     puts "0 - Populate with sample data" unless defined? @populated # I added this for sample data
     puts "1 - View all entries"
     puts "2 - View entry by entry number"
     puts "3 - Create an entry"
     puts "4 - Search for an entry"
     puts "5 - Import entries from a CSV"
     puts "6 - Exit"

     print "Enter your selection: "
 
     # #3
     selection = gets.to_i
      
     # #7
     case selection
      when 0 # added to generate sample data
       system "clear"
       populate
       main_menu
       when 1
         system "clear"
         view_all_entries
         main_menu
       when 2
         system "clear"
         view_single_entry
         main_menu
       when 3
         system "clear"
         create_entry
         main_menu
       when 4
         system "clear"
         search_entries
         main_menu
       when 5
         system "clear"
         read_csv
         main_menu
       when 6
         puts "Good-bye!"
         # #8
         exit(0)
       # #9
       else
         system "clear"
         puts "Sorry, that is not a valid input"
         main_menu
     end
   end
   
   # http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
   def is_number?(selection) # checks if the entry number is a number
    /\A[-+]?\d+\z/ === selection
   end
 
   # #10
   def view_all_entries
       index = 0
       address_book.entries.each do |entry|
       index += 1
       system "clear"
       print "#{index}: " # added this, so users will know what the index is
       puts entry.to_s
     # #15
       entry_submenu(entry)
     end
 
     system "clear"
     puts "End of entries"
   end
   
   def view_single_entry
          print "What entry (Enter 'c' to cancel): "
     
         # #3
         selection = gets.chomp
         if selection.downcase == "c"
             return
         end
         unless is_number?(selection)
            puts "Please enter a number"
            view_single_entry
         end
         selection = selection.to_i # note: this is expected to be an index
                                    # that starts with 1, not 0.
         
        unless selection <= address_book.entries.length
            puts "Entry not found"
            view_single_entry
        end
        
        entry = address_book.entries[selection - 1] # subtract 1 to get to 0-based
                                                    # index
        system "clear"
        print "#{selection}: " # print out index (starting with 1)
        puts entry.to_s
        
        puts "(Hit Return to return to the main menu)"
        gets # Don't clear until user hits enter
        system "clear"
    end

 
   def create_entry
    system "clear"
     puts "New AddressBloc Entry"
     # #12
     print "Name: "
     name = gets.chomp
     print "Phone number: "
     phone = gets.chomp
     print "Email: "
     email = gets.chomp
 
     # #13
     address_book.add_entry(name, phone, email)
 
     system "clear"
     puts "New entry created"
   end
 
   def search_entries
     print "Search by name: "
     name = gets.chomp
     # #10
     match = address_book.binary_search(name)
     system "clear"
     # #11
     if match
       puts match.to_s
       search_submenu(match)
     else
       puts "No match found for #{name}"
     end
   end
 
   def read_csv
     print "Enter CSV file to import: "
     file_name = gets.chomp
 
     # #2
     if file_name.empty?
       system "clear"
       puts "No CSV file read"
       main_menu
     end
 
     # #3
     begin
       entry_count = address_book.import_from_csv(file_name).count
       system "clear"
       puts "#{entry_count} new entries added from #{file_name}"
     rescue
       puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
       read_csv
     end
   end
   
   def delete_entry(entry)
     address_book.entries.delete(entry)
     puts "#{entry.name} has been deleted"
   end
   
   def edit_entry(entry)
     # #4
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
     # #5
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"
     # #6
     puts "Updated entry:"
     puts entry
   end
   
   def search_submenu(entry)
     # #12
     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     # #13
     selection = gets.chomp
 
     # #14
     case selection
       when "d"
         system "clear"
         delete_entry(entry)
         main_menu
       when "e"
         edit_entry(entry)
         system "clear"
         main_menu
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         puts entry.to_s
         search_submenu(entry)
     end
   end
    
   def entry_submenu(entry)
     # #16
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

     # #17
     selection = gets.chomp
 
     case selection
     # #18
       when "n"
     # #19
       when "d"
        delete_entry(entry)
       when "e"
        edit_entry(entry)
        entry_submenu(entry)
     # #20
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         entry_submenu(entry)
     end
   end
 end