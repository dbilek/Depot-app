require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :all
  setup do
    @product = products(:ruby)
    @cart = carts(:unique_product_cart)
    @line_item = line_items(:unique_product_item)
    @second_line_item = line_items(:second_product_item)
  end

  test "Should add new unique product" do
    @cart.add_product(@product)
    assert_equal 1, @cart.line_items.length
    assert_equal @product.id, @line_item.product_id
  end

  test "Should add second same product" do
    @cart.add_product(@product)
    assert_equal 1, @cart.line_items.length
    assert_equal @product.id, @line_item.product_id

    #add second product on same cart
    @cart.add_product(@product)
    assert_equal 2, @cart.line_items.length
    assert_equal @product.id, @second_line_item.product_id
  end
end
