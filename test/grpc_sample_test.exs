defmodule GrpcSampleTest do
  use ExUnit.Case
  doctest GrpcSample

  test "greets the world" do
    assert GrpcSample.hello() == :world
  end
end
