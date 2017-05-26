require 'digest'

class Review
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :product

  field :hash
  field :body

  before_create do
    self.hash = self.class.compute_sha1( self.body )
  end

  def self.where_body_hash(body)
    hash = self.compute_sha1( body )
    self.where(hash: hash)
  end

private

  def self.compute_sha1(hash)
    Digest::SHA1.hexdigest hash
  end

end
