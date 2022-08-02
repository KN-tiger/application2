class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user
  validates :title, presence:true
  validates :body, presence:true, length: { maximum:200 }


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def self.create_all_ranks
    Book.find(Favorite.group(:book_id).where(created_at: Time.current.all_week).pluck(:book_id))
    Book.includes(:fav_users).sort {|a,b| b.fav_users.size <=> a.fav_users.size}
  end

end
