defmodule Interpreters.Macros do
  defmacro create_interpreter!(fun) do
    quote do
      def interpret(:exit), do: :ok
      def interpret(:ok), do: interpret
      def interpret() do
        input = IO.gets ""
        case input do
          { :error, err } ->
            IO.puts "Some kind of error has occurred: " <> err
            interpret(:exit)
          _ ->
            unquote(fun).(input)
        end
      end
    end
  end
end

defmodule Interpreters do
  import Interpreters.Macros

  defmodule IInterpreter do
    @callback interpret(atom) :: nil
    @callback interpret() :: nil
  end
end

# NOTE(jordan): this doesn't really belong here, but I was having fun figuring out IO.stream
defmodule WhitespaceTokenizer do
  @behaviour Interpreters.IInterpreter

  def interpret(:exit), do: :ok
  def interpret(:ok), do: tokenize
  def tokenize() do
    ios = IO.stream(:stdio, :line)

    for line <- Stream.take_while(ios, &(&1 != "\n")), into: [], do:
      line
        |> String.replace_trailing("\n", "")
        |> String.replace_trailing(" ", "")
        |> String.split(~r/\s+/)
  end
end

defmodule Interpreters.Echo do
  @behaviour Interpreters.IInterpreter

  import Interpreters.Macros

  # NOTE(jordan): anonymous functions can pattern match!
  create_interpreter! fn
    "exit\n" ->
      interpret(:exit)
    line ->
      IO.puts line
      interpret(:ok)
  end
end

defmodule Interpreters.Calculator do
  @behaviour Interpreters.IInterpreter

  import Interpreters.Macros

  create_interpreter! fn (input) ->
    # TODO(jordan): actually implement the interpreter
    IO.inspect input
  end
end

