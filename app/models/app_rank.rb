class AppRank < ActiveRecord::Base
  belongs_to :apps
  belongs_to :category
end
