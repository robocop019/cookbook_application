class Recipe < ApplicationRecord
  validates :prep_time, numericality: {greater_than: 0}
  validates :title, presence: true
  validates :ingredients, presence: true
  validates :directions, presence: true

  belongs_to :user

  
  def ingredients_list
    ingredients.split(", ")
  end

  def directions_list
    directions.split(", ")
  end

  def friendly_created_at
    created_at.strftime("%b %d, %Y")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60
    time_string = ""

    time_string += "#{hours} #{'Hour'.pluralize(hours)}" if hours > 0
    time_string += ", " if hours > 0 && minutes > 0
    time_string += "#{minutes} #{'Minute'.pluralize(minutes)}" if minutes > 0

    time_string
  end
end
