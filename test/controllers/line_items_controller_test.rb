require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:first_line_item)
    @line_items_params = {
      quantity: 3,
      cart_id: carts(:first_cart).id,
      product_id: products(:sheets).id,
      variant_id: variants(:large).id,
    }
  end
end
