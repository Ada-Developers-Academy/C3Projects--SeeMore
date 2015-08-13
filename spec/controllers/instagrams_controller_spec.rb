require 'rails_helper'

RSpec.describe InstagramsController, type: :controller do
  describe "POST #search" do
    context "valid params" do
      before :each do
        VCR.use_cassette 'instagram_response' do
          post :search, instagram: { username: "acmei" }
        end
      end

      it 'searches users in Instagram API' do
        expect(assigns(:users).first["username"]).to eq("acmei")
      end

      it "renders search template" do
        expect(response).to render_template("feeds/search")
      end
    end

    context "invalid params" do
      before :each do
        VCR.use_cassette 'instagram_response' do
          post :search, instagram: { username: nil }
        end
      end

      it "redirects to search page" do
        expect(response).to redirect_to(search_path)
      end

      it "displays an error message" do
        expect(flash[:error]).to_not be nil
      end
    end

    context "params not found" do
      before :each do
        VCR.use_cassette 'instagram_no_response' do
          post :search, instagram: { username: "xisoweze" }
        end
      end

      it "displays an error message" do
        expect(flash[:error]).to_not be nil
      end

      it "redirects to the search page" do
        expect(response).to redirect_to(search_path)
      end
    end
  end # POST #search

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
        VCR.use_cassette 'instagram_create_response' do
          post :create, instagram: attributes_for(:instagram, provider_id: "31042754")
        end
      end

      it "creates an instagram record" do
        expect(Instagram.count).to eq(1)
        expect(Instagram.first.username).to eq("Ada")
      end

      it "associates with a user" do
        expect(Instagram.first.user_ids).to include(@user.id)
      end

      it "redirects to root_path" do
        expect(response).to render_template(root_path)
        expect(response).to have_http_status(200)
      end

      it "throws an error when trying re-follow the same person" do
        VCR.use_cassette 'instagram_duplicate_response' do
          post :create, instagram: attributes_for(:instagram)
        end
        expect(flash[:error]).to_not be nil
      end
    end

    context "invalid params" do
      before :each do
        user = create :user
        session[:user_id] = user.id
        VCR.use_cassette 'instagram_create_fail_response' do
          post :create, instagram: attributes_for(:instagram, username: nil)
        end
      end

      it "invalid attributes fail validations" do
        bad_instagram_record = Instagram.create(attributes_for(:instagram, username: nil, user_ids: [1]))
        expect(bad_instagram_record).to_not be_valid
        expect(bad_instagram_record.errors).to include(:username)
      end

      it "does not create a instagram record" do
        expect(Instagram.count).to eq 0
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

      it "unfollows an instagrammer" do
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
