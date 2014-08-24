class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  def self.find_by_name(name)
    where(name: name).downcase.first
  end

  def self.find_or_create(name)
    find_by_name(name) || create(name: name).downcase
  end
end
