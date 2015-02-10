require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'association' do
    it { should belong_to(:student) }
    it { should belong_to(:teacher) }
  end
end
