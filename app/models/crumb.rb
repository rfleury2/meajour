class Crumb < ActiveRecord::Base
  belongs_to :track
  validates_presence_of :measurement, :record_date

  validates_numericality_of :measurement
  # validate_format_of :record_date
end