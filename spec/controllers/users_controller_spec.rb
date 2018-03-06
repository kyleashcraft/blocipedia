require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:premium_user) {FactoryBot.create(:user, role: "premium")}
  let (:private_wiki) {FactoryBot.create(:wiki, user_id: premium_user.id, private: true)}
  let (:private_wiki2) {FactoryBot.create(:wiki, user_id: premium_user.id, private: true)}

  context "PUT downgrade" do
    before(:each) do
      sign_in premium_user
    end

    it "downgrades user to standard" do
      put :downgrade
      p "From rspec test: "
      p "Wiki.where(user_id: premium_user.id): "
      p Wiki.where(user_id: premium_user.id)
      p "Printing wiki objects"
      p private_wiki
      p private_wiki2
      p "premium_user.id: #{premium_user.id}"
      puts "\n \n"
      expect(premium_user.role).to eq("standard")
    end

    it "returns wikis to public status" do
      put :downgrade
      wikis = Wiki.where(user_id: premium_user.id)
      expect(wikis.private).to eq(false)
    end
  end

end
