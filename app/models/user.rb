class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, uniqueness: true,
                    length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image
  
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  # foreign_key: "followed_id"でどのカラムを参照して欲しいのかを定義します。
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 被フォロー関係を通じて参照→followed_idをフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  # 与フォロー関係を通じて参照→follower_idをフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
end
