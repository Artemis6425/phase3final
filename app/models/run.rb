class Run < ApplicationRecord
  belongs_to :game, required: false
  belongs_to :user
  validates :hour, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 23 }
  validates :minute, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 59 }
  validates :second, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 59 }

  def add_zero
    if self.minute.length == 1
      self.minute = "0"+self.minute
    end
    if self.second.length == 1
      self.second = "0"+self.second
    end
  end

  def time_formatting
    if ((self.hour == 0) || (self.hour == ""))
      return self.minute.to_s + ":" + self.second.to_s
    else
      return self.hour.to_s + ":" + self.minute.to_s + ":" + self.second.to_s
    end
  end
end
