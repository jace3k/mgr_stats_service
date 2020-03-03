class OrderService
  def self.get_orders
    url = "#{ENV["ORDER_HOST"]}:#{ENV["ORDER_PORT"]}/orders"
    p url
    RestClient.proxy = ''
    r = RestClient.get(url)

    return Oj.load(r.body)['data'] if r.code == 200
    return { error: "error with order service." }
  end
end
