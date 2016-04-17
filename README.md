# (Simple) Interpreters Written in Elixir

I wanted to learn a bit more about lexing and parsing, and I wanted to learn a language with pattern matching.

So I wrote some super simple interpreters in elixir.

Cool stuff learned:

* IO.stream
* |>
* defmacro
* @behaviour and @callback
* case
* IO.inspect all the things
* anonymous `fn`s can *pattern match*!

Stuff I still don't know:

* How to actually write a lexer
  * My best guess right now is that I can use some combination of `with` and `case`
    to transform lines to tokens and tokens to data structures, respectively
  * `for line <- stream` seemed promising, but feels like it'll actually not be great
    for processing that requires more than one line of "work" since its `do` block is inline
  * My above best guess doesn't feel like a very good guess
* How to get from a lexer to a parser
* How to tell the difference
  * Although I know I read a nice one-line summary a while ago, I'm struggling to make
    the distinction in my code (also interpreters make that a bit harder)
  * I know that lexers turn characters into tokens, and parsers turn tokens into data
  * I don't have a good idea how to do either process in elixir rn

