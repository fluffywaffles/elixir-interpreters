defmodule Interpreters.Macros do
  defmacro create_interpreter!(fun) do
    quote do
      def interpret() do
        input = IO.stream :stdio, :line
        for line <- Stream.take_while input, &(&1 != "exit\n") do
          unquote(fun).(line)
        end
      end
    end
  end
end

defmodule Interpreters do
  import Interpreters.Macros

  defmodule IInterpreter do
    @callback interpret() :: nil
  end
end

# NOTE(jordan): this doesn't really belong here, but I was having fun figuring out IO.stream
defmodule WhitespaceTokenizer do
  def tokenize() do
    ios = IO.stream(:stdio, :line)

    # NOTE(jordan): into is kinda fun, now I get a list of the results from the loop
    # Also for loops don't have to have a one-line body, which is nice
    for line <- Stream.take_while(ios, &(&1 != "\n")), into: [] do
      line
        |> String.replace_trailing("\n", "")
        |> String.replace_trailing(" ", "")
        |> String.split(~r/\s+/)
    end
  end
end

defmodule Interpreters.Echo do
  @behaviour Interpreters.IInterpreter

  import Interpreters.Macros

  # NOTE(jordan): anonymous functions can pattern match!
  create_interpreter! fn
    # NOTE(jordan): after switching to streams, this got a lot simpler
    line ->
      IO.puts line
  end
end

defmodule Interpreters.Calculator do
  @behaviour Interpreters.IInterpreter

  import Interpreters.Macros

  create_interpreter! fn
    line ->
      IO.puts line
  end
end

