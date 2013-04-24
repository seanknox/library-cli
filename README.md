library-cli
===========

Interactive CLI for managing a personal library. All books are stored in memory (no DB).

# Run library.rb:
```
chmod +x library.rb
./library.rb
```

or

```
ruby library.rb
```

# Library commands:
```
    add "<book title>" "<author>" - adds a book to the library
    read "<book title>" - marks a given book as read
    show all - displays all of the books in the library
    show unread - display all of the books that are unread
    show all by "<author>" - shows all of the books in the library by the given author
    show unread by "<author>" - shows the unread books in the library by the given author
    quit - quits the program (exits the library)
```
