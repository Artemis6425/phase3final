class Run < ApplicationRecord
  belongs_to :game, required: false
  belongs_to :user

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
