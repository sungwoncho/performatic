require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'association' do
    it { should have_many(:courses) }
  end
end
