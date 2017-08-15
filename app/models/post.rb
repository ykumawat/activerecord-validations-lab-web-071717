class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {:minimum => 250}
  validates :summary, length: {:maximum => 250}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
  validate :clickbait?

  CLICKBAIT = ["Won\'t Believe", "Secret", "Guess"]

  def clickbait?
    if self.title
      CLICKBAIT.each do |word|
        if self.title.include?(word) || (self.title.include?("Top") && self.title.split(" ")[1].is_integer?)
          return true
        else
          errors.add(:title, "Not clickbait")
          return false
        end
      end
    end
  end


end
