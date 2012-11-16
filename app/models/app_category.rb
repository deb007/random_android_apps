class AppCategory < ActiveRecord::Base
  belongs_to :apps
  belongs_to :category

  validates_uniqueness_of :app_id, :scope => [:category_id]
end
