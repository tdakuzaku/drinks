class Drink < ApplicationRecord
  validates :name, :description, :image_url, presence: true
  validates :rating_avg, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :alcohol_level, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  # Bitterness level
  validates :ibu, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  enum temperature: %i[
    hot
    warm
    ambient
    cold
    extra_cold
  ]

  # attr_accessor :recommend_score
  after_find :recalculate_score
  
  def recalculate_score
    self.rating_avg = self.class.calculate_score(self.alcohol_level, self.ibu)
  end

  def self.calculate_score(abv, ibu)
    wAbv = 1.0
    wIbu = 1.0
    diff = (abv - ibu)
    # Adds proportional weight to ABV or IBU
    if (diff > 0)
      wAbv = 1 + (diff / 100.0)
    else
      wIbu = 1 + (diff.abs / 100.0)
    end
    score = (abv * wAbv + ibu * wIbu) / 2
    return score / 5
  end
end
