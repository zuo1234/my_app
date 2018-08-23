
RSpec.describe User, type: :model do
  context 'create user' do
    before do
      User.new.save
    end

    it do
      expect(User.count).to be 1
    end
  end
end