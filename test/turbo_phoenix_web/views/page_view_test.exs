defmodule TurboPhoenixWeb.PageViewTest do
  use TurboPhoenixWeb.ConnCase, async: true

  import TurboPhoenixWeb.PageView

  describe "completed_stages/1" do
    test "name stage" do
      assert completed_stages(:name) == [:name]
    end

    test "address stage" do
      assert completed_stages(:address) == [:name, :address]
    end

    test "confirm stage" do
      assert completed_stages(:confirm) == [:name, :address, :confirm]
    end

    test "thanks stage" do
      assert completed_stages(:thanks) == [:name, :address, :confirm, :thanks]
    end
  end

  describe "stage_complete?/2" do
    test "name stage" do
      assert stage_complete?(:name, "/signup/name") == "complete"
      assert stage_complete?(:name, "/signup/address") == "complete"
      assert stage_complete?(:name, "/signup/confirm") == "complete"
      assert stage_complete?(:name, "/signup/thanks") == "complete"
    end

    test "address stage" do
      assert stage_complete?(:address, "/signup/name") == nil
      assert stage_complete?(:address, "/signup/address") == "complete"
      assert stage_complete?(:address, "/signup/confirm") == "complete"
      assert stage_complete?(:address, "/signup/thanks") == "complete"
    end

    test "confirm stage" do
      assert stage_complete?(:confirm, "/signup/name") == nil
      assert stage_complete?(:confirm, "/signup/address") == nil
      assert stage_complete?(:confirm, "/signup/confirm") == "complete"
      assert stage_complete?(:confirm, "/signup/thanks") == "complete"
    end

    test "thanks stage" do
      assert stage_complete?(:thanks, "/signup/name") == nil
      assert stage_complete?(:thanks, "/signup/address") == nil
      assert stage_complete?(:thanks, "/signup/confirm") == nil
      assert stage_complete?(:thanks, "/signup/thanks") == "complete"
    end
  end
end
