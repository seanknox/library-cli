#!/usr/bin/env ruby

require 'readline'

class Book
  attr_accessor :title, :author, :status, :books

  def initialize(title, author)
    @title = title
    @author = author
    self.add_book(title, author)
  end


  def self.read(title)
    @books ||=[]
    read_status = { status: "read" }
    @books.collect! { |hash|
      if hash[:title] == title
        puts "\nYou've read \"#{hash[:title]}\"!\n\n"
        hash.merge!(read_status) { |key, v1, v2| v2 }
      else
        hash
      end
    }
  end

  def self.all(author=nil)
    @books ||=[]
    puts "\n"
    @books.each do |book|
      if author
        puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})" if book[:author] == author
      else
        puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})"
      end
    end
    puts "\n"
  end

  ## TODO: refactor the if forest
  def self.unread(author=nil)
    @books ||=[]
    puts "\n"
    if author
      if @books.any? { |h| h[:author] == author }
        @books.each do |book|
          if book[:status] == "unread" && book[:author] == author
            puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})"
          end
        end
      end
    else
      puts "\n"
      @books.each do |book|
        if book[:status] == "unread"
          puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})"
        end
      end
    end
    puts "\n"
  end

  private

  def self.add_book(title, author, status="unread")
    @books ||= []
    if @books.any? { |h| h[:title] == title }
      puts "\nThe library already has that book.\n\n"
    else
      @books << {title: title, author: author, status: status}
      puts "\nAdded \"#{title}\" by #{author}\n\n"
    end
  end
end

def main
  puts "\nWelcome to your library!\n\n"
  command = nil
  while command != 'quit'
    command = Readline.readline("> ", true)
    break if command.nil? ## catches cntl-d for exits
    execute_command(command.strip)
  end
  puts "\n\nBye!\n\n"
end

def execute_command(command)
  case command
  when /^add "(.*)" "(.*)"$/
    Book.add_book("#{$1}", "#{$2}")
  when /^read "(.*)"$/
    Book.read $1
  when /^show all$/
    Book.all
  when /^show unread$/
    Book.unread
  when /^show all by "(.*)"$/
    Book.all $1
  when /^show unread by "(.*)"$/
    Book.unread $1
  when /^help$/
    puts <<-EOS
    add \"<book title>\" \"<author>\" - adds a book to the library
    read \"<book title>\" - marks a given book as read
    show all - displays all of the books in the library
    show unread - display all of the books that are unread
    show all by \"<author>\" - shows all of the books in the library by the given author
    show unread by \"<author>\" - shows the unread books in the library by the given author
    quit - quits the program (exits the library)
    EOS
  end
end

main
