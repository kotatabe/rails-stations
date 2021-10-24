require 'rails_helper'

RSpec.describe "Admin::Schedules", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/schedules/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/schedules/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin/schedules/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/schedules/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admin/schedules/update"
      expect(response).to have_http_status(:success)
    end
  end

end
