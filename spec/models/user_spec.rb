require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it 'validates uniqueness of email' do
    new_user_with_same_email = User.new(name: 'Some', email: user.email)
    expect(new_user_with_same_email.valid?).to be_falsey
  end
end
