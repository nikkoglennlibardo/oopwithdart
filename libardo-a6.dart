import 'dart:io';
import 'dart:core';
import 'first.dart';

List<Books> listBooks = []; //class
List<Books> lrBooks = []; //lent book class
void main() {
  home();
}

void home() {
  print("\x1B[2J\x1B[0;0H");
  print('LIBRARY SYSTEM \n');
  print('List of Books');
  print('Return books\n');
  stdout.writeln('Enter 1 to View Books or 2 to return books');
  var input = stdin.readLineSync().toString();
  if (input == "1") {
    listAllbooks(); // view and add books
  } else if (input == "2") {
    returnBooks();
  }
}

void returnBooks() {
  print("\x1B[2J\x1B[0;0H");
  if (lrBooks.isEmpty) {
    print("No available books!");
  } else {
    print("List " + lrBooks.length.toString());
    //header column
    print(columnStructure("Isbn") +
        columnStructure("Title") +
        columnStructure("Author") +
        columnStructure("Genre") +
        columnStructure("Full Name") +
        columnStructure("Address") +
        columnStructure("Date issued") +
        columnStructure("Date returned"));

    for (int b = 0; b < lrBooks.length; b++) {
      print(columnStructure(lrBooks[b].isbn) +
          columnStructure(lrBooks[b].title) +
          columnStructure(lrBooks[b].author) +
          columnStructure(lrBooks[b].genre) +
          columnStructure(lrBooks[b].lendName) +
          columnStructure(lrBooks[b].address) +
          columnStructure(lrBooks[b].lendDate) +
          columnStructure(lrBooks[b].returnDate.toString()));
    }

    print("\nEnter isbn number to return books or 0 to go home");
    var isbn = stdin.readLineSync().toString();
    if (isbn == "0") {
      home();
    } else {
      if (isbn != "") {
        bool isExist = false;
        for (int i = 0; i < listBooks.length; i++) {
          if (listBooks[i].isbn.toUpperCase() == isbn.toUpperCase()) {
            for (int lb = 0; lb < lrBooks.length; lb++) {
              if (lrBooks[lb].isbn.toUpperCase() == isbn.toUpperCase() &&
                  lrBooks[lb].returnDate == "") {
                listBooks[i].lentout = false; // set the book to available
                lrBooks[lb].returnDate = DateTime.now().year.toString() +
                    "/" +
                    DateTime.now().month.toString() +
                    "/" +
                    DateTime.now().day.toString() +
                    " " +
                    DateTime.now().hour.toString() +
                    ":" +
                    DateTime.now().minute.toString();
                isExist = true;
                print(
                    "Successfully returned! \nEnter 1 to refresh or 0 to go back");
                var s = stdin.readLineSync().toString();
                if (s == "0") {
                  home();
                } else if (s == "1") {
                  returnBooks();
                }
                break;
              }
            }
            break;
          }
        }
        if (!isExist) {
          print("No match!, enter 1 to to retry");
          if (stdin.readLineSync().toString() == "1") {
            returnBooks();
          }
        }
      }
    }
  }
}

void listAllbooks() {
  print("\x1B[2J\x1B[0;0H");
  if (listBooks.isEmpty) {
    print("No available books!");
  }
  int ab = 0, ib = 0;
  for (int i = 0; i < books.length; i++) {
    if (listBooks[i].lentout) {
      ib += 1;
    } else {
      ab += 1;
    }
  } //counting available and not available books

  //header column
  print("Available books ($ab)   |   Lent out books ($ib)\n");

  print(columnStructure("Isbn") +
      columnStructure("Title") +
      columnStructure("Author") +
      columnStructure("Genre"));
  for (int b = 0; b < listBooks.length; b++) {
    print(columnStructure(listBooks[b].isbn) +
        columnStructure(listBooks[b].title) +
        columnStructure(listBooks[b].author) +
        columnStructure(listBooks[b].genre));
  }

  print("\nEnter 1 to add more books or 2 to lend a book or 0 to go home");
  var e = stdin.readLineSync().toString();
  if (e == "1") {
    print("\x1B[2J\x1B[0;0H");
    print("1 Computer Science");
    print("2 Philosophy");
    print("3 Pure Science");
    print("4 Art and Recreation");
    print("5 History\n");

    print("Enter 1 - 5 to choose Genre collection");
    String input = stdin.readLineSync().toString();
    String collection = input == "1"
        ? "Computer Science"
        : input == "2"
            ? "Philosophy"
            : input == "3"
                ? "Pure Science"
                : input == "4"
                    ? "Art and Recreation"
                    : input == "5"
                        ? "History"
                        : "";
    if (input == "1" ||
        input == "2" ||
        input == "3" ||
        input == "5" ||
        input == "5") {
      print("\x1B[2J\x1B[0;0H");
      var nb = Books();
      nb.isbn = genereateuniqueNumber();
      nb.genre = collection;
      print("ISBN number : " + nb.isbn);
      print("Genre : " + nb.genre);
      print("Enter Title :");
      nb.title = stdin.readLineSync().toString();
      print("Enter Author :");
      nb.author = stdin.readLineSync().toString();

      print("\nEnter 1 to proceed or 0 to go back");
      var input = stdin.readLineSync().toString();
      if (input == "0") {
        listAllbooks();
      } else if (input == "1") {
        nb.lentout = false;
        listBooks.add(nb);
        print("Successfully save!, Enter 0 to go back");
        if (stdin.readLineSync().toString() == "0") {
          listAllbooks();
        }
      }
    }
  } else if (e == "2") {
    print("Enter Isbn number :");
    var isbn = stdin.readLineSync().toString();

    int itemLocation = -10;
    for (int i = 0; i < listBooks.length; i++) {
      if (listBooks[i].isbn.toUpperCase() == isbn.toUpperCase()) {
        itemLocation = i;
      }
    }
    if (itemLocation >= 0) {
      if (listBooks[itemLocation].lentout) {
        print(
            "books is already borrowed by " + listBooks[itemLocation].lendName);
        print("Enter 0 to go back");
        if (stdin.readLineSync().toString() == "0") {
          listAllbooks();
        }
      } else {
        print("\x1B[2J\x1B[0;0H");
        var lb = Books();
        lb.isbn = listBooks[itemLocation].isbn;
        lb.title = listBooks[itemLocation].title;
        lb.author = listBooks[itemLocation].author;
        lb.genre = listBooks[itemLocation].genre;
        lb.lendName = listBooks[itemLocation].lendName;
        lb.lendDate = listBooks[itemLocation].lendDate;
        lb.returnDate = listBooks[itemLocation].returnDate;
        lb.address = listBooks[itemLocation].address;

        print("ISBN : " + lb.isbn);
        print("TITLE : " + lb.title);
        print("AUTHOR : " + lb.author);
        print("GENRE : " + lb.genre);
        print("Enter Name :");
        listBooks[itemLocation].lendName = stdin.readLineSync().toString();
        print("Enter Address :");
        listBooks[itemLocation].address = stdin.readLineSync().toString();

        print("\nEnter 1 to proceed or 0 to go back");
        if (stdin.readLineSync().toString() == "1") {
          listBooks[itemLocation].lentout = true;
          lb.address = listBooks[itemLocation].address;
          lb.lendName = listBooks[itemLocation].lendName;
          lb.lendDate = DateTime.now().year.toString() +
              "/" +
              DateTime.now().month.toString() +
              "/" +
              DateTime.now().day.toString() +
              " " +
              DateTime.now().hour.toString() +
              ":" +
              DateTime.now().minute.toString();
          lrBooks.add(lb);
          print("Successfully saved!, Enter 0 to go back");
          if (stdin.readLineSync().toString() == "0") {
            listAllbooks();
          } else {
            home();
          }
        } else if (stdin.readLineSync().toString() == "0") {
          listAllbooks();
        }
      }
    } else {
      print("Books not found!, Enter 0 to retry!");
      if (stdin.readLineSync().toString() == "0") {
        listAllbooks();
      }
    }
  } else if (e == "0") {
    home();
  } else {
    listAllbooks();
  }
}

String genereateuniqueNumber() {
  //generating ISBN number
  String ret = "Isbn";
  if (listBooks.length > 99) {
    ret += "0" + (listBooks.length + 1).toString();
  } else if (listBooks.length > 9) {
    ret += "00" + (listBooks.length + 1).toString();
  } else {
    ret += "000" + (listBooks.length + 1).toString();
  }
  return ret;
}

String columnStructure(String input) {
  int width = 20;
  String ret = "";
  for (int i = 0; i < (width - input.length); i++) {
    ret += " ";
  }
  return input + ret;
}

class Books {
  //class for books list
  String lendName = "";
  String lendDate = "";
  String returnDate = "";
  String address = "";
  bool lentout = false;
  String author = "";
  String title = "";
  String genre = "";
  String isbn = "";
}
