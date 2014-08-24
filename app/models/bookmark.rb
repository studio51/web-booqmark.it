class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :tags, after_add: :check_tag
  accepts_nested_attributes_for :tags

  def check_tag tag
    existing_tag = Tag.where(name: tag.name).first

    if existing_tag
      self.tags = self.tags + [existing_tag]
      self.tags = self.tags - [tag]
    end
  end
end
