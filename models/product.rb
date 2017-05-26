class Product
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  has_many :reviews, autosave: true

  field :name
  field :price, type: Float

end
