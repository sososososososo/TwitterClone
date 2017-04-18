class Micropost < ApplicationRecord
  belongs_to :user #User と Micropost の一対多を表現
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  #ユーザの紐付け無しには Micropost を保存できません。
  
end
