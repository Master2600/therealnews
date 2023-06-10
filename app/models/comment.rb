class Comment < ApplicationRecord
  belongs_to :news
  belongs_to :user, optional: true
end

