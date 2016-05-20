require 'rails_helper'

RSpec.describe Crumb, type: :model do
  it { should belong_to(:tail) }
  
  it { should validate_presence_of(:measurement) }
  it { should validate_presence_of(:record_date) }
  it { should validate_numericality_of(:measurement) }
end