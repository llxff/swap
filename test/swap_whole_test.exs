defmodule SwapWholeTest do
  @moduledoc """
  In this test we swap modules for this test and reverts after.
  """

  use ExUnit.Case, async: true
  use Swap

  defmodule ModuleA do
    def call(), do: "module A"
  end

  defmodule ModuleB do
    def call(), do: "module B"
  end

  defmodule ModuleC do
    def call(), do: "module C"
  end

  setup do
    swap(ModuleA, ModuleB)

    on_exit(fn() -> revert(ModuleA) end)
    :ok
  end

  test "swaps ModuleA with ModuleB" do
    assert ModuleA.call() == ModuleB.call()
  end

  test "doesnt swap ModuleC with ModuleB" do
    assert ModuleC.call() != ModuleB.call()
  end
end
