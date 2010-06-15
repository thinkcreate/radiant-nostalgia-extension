class NotFoundRequest < ActiveRecord::Base
  
  def self.reset_at
    Radiant::Config['nostalgia.not_found_reset_at'] ||= Time.now
    Time.parse(Radiant::Config['nostalgia.not_found_reset_at'])
  end
  
  def self.reset_at=(time)
    Radiant::Config['nostalgia.not_found_reset_at'] = time
  end

  def increment_count_created!
    if !self[:count_created].blank?
      self.count_created = self[:count_created] + 1
    else
      self.count_created = 1 if self.new_record?
    end
    save
  end
  
  def decrement_count_created!
    decrement(:count_created)
    return destroy if self.count_created.zero?
    save
  end
end
