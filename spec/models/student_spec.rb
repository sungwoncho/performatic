require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'association' do
    it { should have_many(:enrollments) }
    it { should have_many(:courses).through(:enrollments) }
  end
end
