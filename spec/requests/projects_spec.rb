require 'rails_helper'

RSpec.describe "Projects", type: :request do
  context "認証済みのユーザーとして" do
    before do
      @user = create(:user)
    end

    context "有効な属性値の場合" do
      it "プロジェクトを追加出来ること" do
        project_params = @user.projects.build(attributes_for(:project))
        sign_in @user
        expect {
          post api_projects_path, params: { project: project_params }
        }.to change(@user.projects, :count).by(1)
      end

      it "プロジェクトが追加出来ないこと" do
        project_params = attributes_for(:project, :invalid)
        sign_in @user
        expect {
          post api_projects_path, params: { project: project_params }
        }.to_not change(@user.projects, :count)
      end
    end
  end

end
