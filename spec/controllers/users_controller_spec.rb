require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:premium_user) {FactoryBot.create(:user, role: "premium")}
  let!(:private_wiki) {FactoryBot.create(:wiki, user_id: premium_user.id, private: true)}
  let!(:private_wiki2) {FactoryBot.create(:wiki, user_id: premium_user.id, private: true)}

  context "PUT downgrade" do
    before(:each) do
      sign_in premium_user
    end

    it "downgrades user to standard" do
      put :downgrade
      expect(premium_user.reload.role).to eq("standard")
    end

    it "returns wikis to public status" do
      put :downgrade
      expect(private_wiki.reload.private).to eq(false)
      expect(private_wiki2.reload.private).to eq(false)
    end
  end

end
