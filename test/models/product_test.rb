require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :all
  def new_product(image_url)
    product = Product.new( title: "Book title", description: "Book description", image_url: image_url, price: 99.99 )
  end
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:description].any?
    assert product.errors[:title].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    product = Product.new( title: "Book title", description: "Book description", image_url: "book.jpg" )
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG fred.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "title must be unique" do
    product = Product.new( title: products(:ruby).title, description: "Book description", image_url: "book.jpg", price: 85.25 )
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "title must have minimum 10 characters" do
    product = Product.new( title: "Short", description: "Book description", image_url: "book.jpg", price: 85.25 )
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]
  end
end
