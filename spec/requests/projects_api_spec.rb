require 'rails_helper'

RSpec.describe "Projects API", type: :request do
  it "1件のプロジェクトを読み出すこと" do
    user = create(:user)
    create(:project,
      name: "Sample Project")
    create(:project,
      name: "Second Sample Project",
      owner: user)

      get api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token
      }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
      project_id = json[0]["id"]

      get api_projects_path(project_id), params: {
        user_email: user.email,
        user_token: user.authentication_token
      }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json[0]["name"]).to eq "Second Sample Project"
  end

  it "プロジェクトを作成出来ること" do
    user = create(:user)

    project_attributes = attributes_for(:project)

    expect{
      post api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token,
        project: project_attributes
      }
    }.to change(user.projects, :count).by(1)

    expect(response).to have_http_status(:success)
  end
end
