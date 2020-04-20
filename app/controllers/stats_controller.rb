class StatsController < ApplicationController
  def product_stats
    all_orders = OrderService.get_orders
    all_products = ProductService.get_products

    calculation_count = 0

    products = all_products.each_with_object({}) { |product, products|
      orders_matched = []
      orders_matched = all_orders.filter { |o| o["product_id"] == product["id"] }
      total_ordered = orders_matched.map { |order| order["quantity"] }.reduce(:+)

      calculation_count += orders_matched.length

      products["product_#{product["id"]}"] = {
        name: product["name"],
        orders: orders_matched.length,
        total_ordered: total_ordered,
        earned: (total_ordered * product["price"]).round(2),
      }
    }
    render json: { calculation_count: calculation_count, product_stats: products }, status: :ok
  end

  def order_stats
    all_orders = OrderService.get_orders
    all_products = ProductService.get_products

    calculation_count = 0

    orders = all_orders.each_with_object({}) { |order, orders|
      total_price = 0
      product_name = ""
      all_products.each { |product|
        if order["product_id"] == product["id"]
          total_price = product["price"] * order["quantity"]
          product_name = product["name"]
          calculation_count += 1
        end
      }
      orders["order_#{order["id"]}"] = {
        total_price: total_price.round(2),
        product: product_name,
      }
    }

    render json: { calculation_count: calculation_count, order_stats: orders }, status: :ok
  end
end
