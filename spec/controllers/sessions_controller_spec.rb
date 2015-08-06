require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    context "when using twitter authentication" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

        it "redirects to the homepage" do
          get :create, provider: :twitter

          expect(response).to redirect_to root_path
        end

        it "creates a stalker" do
           expect { get :create, provider: :twitter }.to change(Stalker, :count).by(1)
        end

        it "assigns session[:stalker_id]" do
          get :create, provider: :twitter
          expect(session[:stalker_id]).to eq(1)
        end
      end

      context "stalker already exists" do
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
          get :create, provider: :twitter
        end
        # before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
        let(:stalker) { Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:twitter]) }

        it "doesn't create a new stalker" do
          get :create, provider: :twitter

          expect(Stalker.count).to eq 1
        end

        it "assigns session[:stalker_id]" do
          get :create, provider: :twitter

          expect(session[:stalker_id]).to eq stalker.id
        end
      end

      context "when failing to save the stalker" do
        let(:invalid_params) { {
          "provider" => "twitter",
          "uid" => "1234",
          "info" => { "nickname" => nil}
          }
        }
        before { request.env["omniauth.auth"] = invalid_params }

       it "redirects to home with flash error" do
         get :create, provider: :twitter

         expect(response).to redirect_to root_path
         expect(flash[:error]).to_not be nil
       end
      end
    end

    context "when using vimeo authentication" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo] }

        it "redirects to the homepage" do
          get :create, provider: :vimeo

          expect(response).to redirect_to root_path
        end

        it "creates a stalker" do
           expect { get :create, provider: :vimeo }.to change(Stalker, :count).by(1)
        end

        it "assigns session[:stalker_id]" do
          get :create, provider: :vimeo
          expect(session[:stalker_id]).to eq(1)
        end
      end

      context "stalker already exists" do
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo]
          get :create, provider: :vimeo
        end
        # before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo] }
        let(:stalker) { Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:vimeo]) }

        it "doesn't create a new stalker" do
          get :create, provider: :vimeo

          expect(Stalker.count).to eq 1
        end

        it "assigns session[:stalker_id]" do
          get :create, provider: :vimeo

          expect(session[:stalker_id]).to eq stalker.id
        end
      end

      context "when failing to save the stalker" do
        let(:invalid_params) { {
          "provider" => "vimeo",
          "uid" => "1234",
          "info" => { "name" => nil}
          }
        }
        before { request.env["omniauth.auth"] = invalid_params }

       it "redirects to home with flash error" do
         get :create, provider: :vimeo

         expect(response).to redirect_to root_path
         expect(flash[:error]).to_not be nil
       end
      end
    end

    context "when using instagram authentication" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }

        it "redirects to the homepage" do
          get :create, provider: :instagram

          expect(response).to redirect_to root_path
        end

        it "creates a stalker" do
           expect { get :create, provider: :instagram }.to change(Stalker, :count).by(1)
        end

        it "assigns session[:stalker_id]" do
          get :create, provider: :instagram
          expect(session[:stalker_id]).to eq(1)
        end
      end

      context "stalker already exists" do
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram]
          get :create, provider: :instagram
        end
        # before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }
        let(:stalker) { Stalker.find_or_create_from_auth_hash(OmniAuth.config.mock_auth[:instagram]) }

        it "doesn't create a new stalker" do
          get :create, provider: :instagram

          expect(Stalker.count).to eq 1
        end

        it "assigns session[:stalker_id]" do
          get :create, provider: :instagram

          expect(session[:stalker_id]).to eq stalker.id
        end
      end

      context "when failing to save the stalker" do
        let(:invalid_params) { {
          "provider" => "instagram",
          "uid" => "1234",
          "info" => { "nickname" => nil}
          }
        }
        before { request.env["omniauth.auth"] = invalid_params }

       it "redirects to home with flash error" do
         get :create, provider: :instagram

         expect(response).to redirect_to root_path
         expect(flash[:error]).to_not be nil
       end
      end
    end
  end

end
