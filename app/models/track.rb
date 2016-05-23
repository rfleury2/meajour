class Track < ActiveRecord::Base
  belongs_to :user
  has_many :crumbs

  validates_presence_of :name

  validates_uniqueness_of :name, scope: :user
end