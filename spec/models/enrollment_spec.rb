require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'association' do
    it { should belong_to(:course) }
    it { should belong_to(:student) }
  end
end
