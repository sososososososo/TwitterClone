class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favoritings, through: :relationfavorits, source: :micropost
  has_many :reverses_of_favoritship, class_name: 'relationfavorit', foreign_key: 'micropost_id'
  has_many :favoriters, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
      #見つかれば Relation を返し,
      #見つからなければフォロー関係を保存(create = build + save)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship#relationshipが見つかればデストロイ
  end

  def following?(other_user)
    self.followings.include?(other_user)
    #含まれている場合true 、含まれていない場合false
  end
  
  
  
  def favorit(micropost)
    #unless self == other_user
      self.relationfavorits.find_or_create_by(micropost_id: other_user.id)
    #end
  end

  def unfavorit(micropost)
    relationfavorit = self.relationfavorits.find_by(micropost_id: other_user.id)
    relationfavorit.destroy if relationfavorit
  end

  def favoriting?(micropost)
    self.favoritings.include?(micropost)
  end
  
  
  
end