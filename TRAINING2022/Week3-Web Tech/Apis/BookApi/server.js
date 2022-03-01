import express from "express";
import path from "path";
import Book from "./Book.js";

const server = express();
const port = 3000;
const serverMessage = "http://localhost:3000 started";

server.use(express.urlencoded({ extended: true }));
server.use(express.json());

const __dirname = path.resolve(path.dirname(""));

const book = [];
book.push(new Book(1, "abc", "xyz", 3000));
book.push(new Book(2, "flglisj", "dsljfhd", 22));
book.push(new Book(3, "dlfhljdh", "dfs", 355));
book.push(new Book(4, "qwe", "sda", 30));
book.push(new Book(5, "afgfdbc", "xyvdffz", 322));

server.get("/", (req, resp) => {
  resp.setHeader("Content-Type", "text/html");
  resp.sendFile(__dirname + "/index.html");
});

// get all the books
//  GET : http://localhost:3000/books
server.get("/books", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  resp.send(book);
});
// get book by id
//  GET : http://localhost:3000/app/books/:id

server.get("/books/:id", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  resp.send(book.find((b) => bookid === bookid));
});

// Add Book
//  POST : http://localhost:3000/app/books/addBook

// Delete by ID
//  DELETE : http://localhost:3000/app/books/:id

// Update
//  PUT : http://localhost:3000/app/books/update/:id

server.listen(port, () => {
  console.log(serverMessage);
});
