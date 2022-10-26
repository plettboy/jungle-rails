require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "validates product and all fields save successfully" do
      @category = Category.new(
        id: 5,
        name: "planters",
        created_at: DateTime.now - 3.days,
        updated_at: DateTime.now
      )
      @product = Product.new(
        name: "4' Basin",
        category: @category,
        price: 150,
        quantity: 7
      )
      @product.save
      expect(@product).to be_valid
    end

    it "validates name value's existence" do
      @category = Category.new(
        id: 5,
        name: "planters",
        created_at: DateTime.now - 3.days,
        updated_at: DateTime.now
      )
      @product = Product.new(
        name: nil,
        category: @category,
        price: 150,
        quantity: 7
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "validates the price exists and is true" do
      @category = Category.new(
        id: 5,
        name: "planters",
        created_at: DateTime.now - 3.days,
        updated_at: DateTime.now
      )
      @product = Product.new(
        name: "5' Basin",
        category: @category,
        quantity: 7
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "validates quantity values existence" do
      @category = Category.new(
        id: 5,
        name: "planters",
        created_at: DateTime.now - 3.days,
        updated_at: DateTime.now
      )
      @product = Product.new(
        name: '12" Basin',
        category: @category,
        price: 150,
        quantity: nil
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates category existence" do
      @category = Category.new(
        id: 5,
        name: "planters",
        created_at: DateTime.now - 3.days,
        updated_at: DateTime.now
      )
      @product = Product.new(
        name: "5' Basin",
        category: nil,
        price: 150,
        quantity: 7
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end