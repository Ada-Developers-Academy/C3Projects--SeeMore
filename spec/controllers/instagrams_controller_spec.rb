require 'rails_helper'

RSpec.describe InstagramsController, type: :controller do

  describe "POST #search" do
    context "valid params" do
      xit "searches users in Instagram API" do
        post :search, instagram: { username: "name" }
        expect()
      end

      it "renders search template" do
        post :search, instagram: { username: "name" }
        expect(response).to render_template("feeds/search")
      end
    end

    context "invalid params" do
      it "redirects to search page" do
        post :search, instagram: { username: nil }
        expect(response).to redirect_to(search_path)
      end

      it "displays an error message" do
        post :search, instagram: { username: nil }
        expect(flash[:error]).to_not be nil
      end
    end
  end

  describe "POST #create" do
    context "login required" do
      it "doesn't create instagram record" do
        session[:user_id] = nil

        post :create, instagram: attributes_for(:instagram)
        expect(Instagram.count).to eq(0)
        expect(flash[:error]).to_not be nil
      end
    end

    context "valid params" do
      before :each do
        @user = create :user
        session[:user_id] = @user.id
        post :create, instagram: attributes_for(:instagram)
      end

      it "creates an instagram record" do
        expect(Instagram.count).to eq(1)
        expect(Instagram.first.username).to eq("Ada")
      end

      it "associates with a user" do
        expect(Instagram.first.user_ids).to include(@user.id)
      end

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
      end
    end

    context "invalid params" do
      before :each do
        user = create :user
        session[:user_id] = user.id
        post :create, instagram: attributes_for(:instagram, username: nil)
      end

      it "invalid attributes fail validations" do
        bad_instagram_record = Instagram.create(attributes_for(:instagram, username: nil, user_ids: [1]))
        expect(bad_instagram_record).to_not be_valid
        expect(bad_instagram_record.errors).to include(:username)
      end

      it "does not create a instagram record" do
        expect(Instagram.count).to eq 0
      end

      it "renders the feeds/search view" do
        expect(response).to render_template("feeds/search")
      end
    end
  end # POST #create

  describe "DELETE #destroy" do
    context "valid params" do
      before :each do
        @user = create :user
        session[:user_id] = @user.id
        @instagrammer = create :instagram
      end

      it "unfollows a tweeter" do
        delete :destroy, id: @instagrammer.id

        expect(@user.instagrams.count).to eq(0)
      end

      it "redirects to the people page" do
        delete :destroy, id: @instagrammer.id
        expect(subject).to redirect_to(people_path)
      end
    end
  end # DELETE #destroy

end # controller spec
