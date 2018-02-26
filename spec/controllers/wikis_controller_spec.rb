require 'rails_helper'
require 'random_data'
include Warden::Test::Helpers

RSpec.describe WikisController, type: :controller do

  include Devise::Test::ControllerHelpers

  let(:user) {FactoryBot.create(:user)}
  let(:other_user) {FactoryBot.create(:user, email: RandomData.random_email)}
  let(:my_wiki) {Wiki.create!(title: RandomData.random_word, body: RandomData.random_paragraph, private: false, user: user)}

  context 'guest' do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns with redirect" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET #edit" do
      it "returns with redirect" do
        get :edit, params: {id: my_wiki.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'user' do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns HTTP success" do
        get :show, params: {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of wikis by 1" do
        expect{post :create, params: { wiki: { title: RandomData.random_word, body: RandomData.random_paragraph, private: false, user: user } } }.to change(Wiki, :count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: { title: RandomData.random_word, body: RandomData.random_paragraph, private: false, user: user }}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: RandomData.random_word, body: RandomData.random_paragraph, private: false, user: user } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "POST update" do
      it "returns http success" do
        new_title = RandomData.random_word
        new_body = RandomData.random_paragraph

        put :update, params: {id: my_wiki.id, wiki: {title: new_title, body: new_body}}
        expect(response).to redirect_to Wiki.last
      end


      it "updates post with expected attributes" do
        new_title = "This is my new Wiki title"
        new_body = "This is my new Wiki body"

        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = Wiki.find(my_wiki.id)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end
    end

    describe "DELETE Destroy" do
      it "deletes the wiki" do
        delete :destroy, params: {id: my_wiki.id }
        count = Wiki.where({id: my_wiki.id }).size
        expect(count).to eq 0
      end

      it "redirects to the wikis index" do
        delete :destroy, params: {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end
  end

  context "user doing RUD on other user's wiki" do
    before(:each) do
      sign_in other_user
    end
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns HTTP success" do
        get :show, params: {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST update" do
      it "returns http success" do
        new_title = RandomData.random_word
        new_body = RandomData.random_paragraph

        put :update, params: {id: my_wiki.id, wiki: {title: new_title, body: new_body}}
        expect(response).to redirect_to Wiki.last
      end


      it "updates post with expected attributes" do
        new_title = "This is my new Wiki title"
        new_body = "This is my new Wiki body"

        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = Wiki.find(my_wiki.id)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end
    end

    describe "DELETE Destroy" do
      it "deletes the wiki" do
        delete :destroy, params: {id: my_wiki.id }
        count = Wiki.where({id: my_wiki.id }).size
        expect(count).to eq 0
      end

      it "redirects to the wikis index" do
        delete :destroy, params: {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end
  end

end
