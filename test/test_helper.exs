Dynamo.under_test(ElixirShrtnr.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule ElixirShrtnr.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
