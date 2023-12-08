require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Relationships" do
    it { is_expected.to have_one(:basket) }
  end

  describe 'Validations' do
    it "is user by default" do
      user = User.create(email: "user@example.com", password: "password")
      expect(user.role).to eq("user")
    end

    it "can be created as an admin" do
      admin = User.create(email: "admin@example.com", password: "password", role: :admin)
      expect(admin.role).to eq("admin")
    end

    it "can change roles from user to admin" do
      user = User.create(email: "change@example.com", password: "password")
      user.admin!
      expect(user.role).to eq("admin")
    end

    it "can change roles from user to admin" do
      user = User.create(email: "change@example.com", password: "password", role: :admin)
      user.user!
      expect(user.role).to eq("user")
    end
  end
end
