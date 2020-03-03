class ProductService
  def self.get_products
    url = "#{ENV["PRODUCT_HOST"]}:#{ENV["PRODUCT_PORT"]}/products"
    p url
    RestClient.proxy = ''
    r = RestClient.get(url)

    return Oj.load(r.body)['data'] if r.code == 200
    return { error: "error with product service." }
  end
end
