require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "正常にレスポンスを返すこと" do
      get :index
      expect(response).to be_success
    end
  end

end
