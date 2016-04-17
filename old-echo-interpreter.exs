defmodule Interpreters do

  defmodule IInterpreter do
    @callback interpret(atom) :: nil
  end

  defmodule Echo do
    @behaviour IInterpreter
    def interpret(:exit), do: :ok
    def interpret(:ok), do: interpret
    def interpret() do
      input = IO.gets ""
      case input do
        { :error, err } ->
          IO.puts "Some kind of error has occurred: " <> err
          interpret(:exit)
        line ->
          if String.equivalent?(line, "exit\n") do
            interpret(:exit)
          else
            IO.puts line
            interpret(:ok)
          end
      end
    end
  end
end

