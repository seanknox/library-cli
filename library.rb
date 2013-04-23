#!/usr/bin/env ruby

require 'readline'

class Book
  attr_accessor :title, :author, :status, :books

  @books ||=[]

  def initialize(title, author)
    @title = title
    @author = author
    self.class.add_book(title, author)
  end


  def self.read(title)
    read_status = { status: "read" }
    @books.collect! { |hash|
      if hash[:title] == title
        puts "You've read \"#{hash[:title]}\"!"
        hash.merge!(read_status) { |key, v1, v2| v2 }
      else
        hash
      end
    }
  end

  def self.all(author=nil)
    @books.each do |book|
      if author
        puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})" if book[:author] == author
      else
        puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})"
      end
    end
  end

  def self.unread(author=nil)
    if author
      @books.each do |book|
        if book[:status] == "unread" && book[:author] == author
          puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})"
        end
      end
    else
      @books.each do |book|
        if book[:status] == "unread"
          puts "\"#{book[:title]}\" by #{book[:author]} (#{book[:status]})"
        end
      end
    end
  end

  def self.add_book(title, author, status="unread")
    if @books.any? { |h| h[:title] == title }
      puts "Horrible news: The library already has that book."
    else
      @books << {title: title, author: author, status: status}
      puts "Added \"#{title}\" by #{author}"
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
  puts "\nBye!\n\n"
end

def execute_command(command)
  case command
  when /^add "(.*)" "(.*)"$/
    puts "\n"
    Book.new("#{$1}", "#{$2}")
    puts "\n"
  when /^read "(.*)"$/
    puts "\n"
    Book.read $1
    puts "\n"
  when /^show all$/
    puts "\n"
    Book.all
    puts "\n"
  when /^show unread$/
    puts "\n"
    Book.unread
    puts "\n"
  when /^show all by "(.*)"$/
    puts "\n"
    Book.all $1
    puts "\n"
  when /^show unread by "(.*)"$/
    puts "\n"
    Book.unread $1
    puts "\n"
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
