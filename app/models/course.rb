class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments
  belongs_to :teacher

  after_commit :invalidate_cache

  private

    def invalidate_cache
      Rails.cache.delete('courses-count')
      Rails.cache.delete('courses-max-updated-at')
    end
end
