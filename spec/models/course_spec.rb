require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'association' do
    it { should have_many(:enrollments) }
    it { should have_many(:students).through(:enrollments) }
    it { should belong_to(:teacher) }
  end
end
