require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#index" do

    context "認証済みのユーザーとして" do
      before do
        @user = create(:user)
        sign_in @user
      end

      it "正常なレスポンスを返すこと" do
        get :index
        expect(response).to be_success
      end

      it "200レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストユーザーとして" do
      it "302レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "認可されたユーザーとして" do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        sign_in @user
      end

      it "正常にレスポンスを返すこと" do
        get :show, params: { id: @project.id }
        expect(response).to be_success
      end
    end

    context "認可されていないユーザーとして" do
      before do
        @user = create(:user)
        other_user = create(:user)
        @project = create(:project, owner: other_user)
        sign_in @user
      end

      it "ダッシュボードにリダイレクトすること" do
        get :show, params: { id: @project.id }
        expect(response).to redirect_to root_path
      end

    end
  end

  describe "#create" do
    context "認証済みのユーザーとして" do
      before do
        @user = create(:user)
        sign_in @user
      end

      context "有効な属性値の場合" do
        it "プロジェクトを追加出来ること" do
          project_params = attributes_for(:project)
          expect{
            post :create, params: { project: project_params }
          }.to change(@user.projects, :count).by(1)
        end
      end

      context "無効な属性値の場合" do
        it "プロジェクトが追加出来ないこと" do
          project_params = attributes_for(:project, :invalid)
          sign_in @user
          expect {
            post :create, params: { project: project_params }
          }.to_not change(@user.projects, :count)
        end
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        project_params = attributes_for(:project)
        post :create, params: { project: project_params }
        expect(response).to have_http_status "302"
      end

      it "サイン画面にリダイレクトすること" do
        project_params = attributes_for(:project)
        post :create, params: { project: project_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "認可されたユーザーとして" do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        sign_in @user
      end

      it "プロジェクトが更新出来ること" do
        project_params = attributes_for(:project, name: "New Project Name")
        patch :update, params: { id: @project.id, project: project_params }
        expect(@project.reload.name).to eq "New Project Name"
      end
    end

    context "認可されていないユーザーとして" do
      before do
        @user = create(:user)
        other_user = create(:user)
        @project = create(:project, owner: other_user, name: "Same Old Name")
      end

      it "プロジェクトが更新出来ないこと" do
        project_params = attributes_for(:project, name: "New Name")
        sign_in @user
        patch :update, params: { id: @project.id, project: project_params }
        expect(@project.reload.name).to eq "Same Old Name"
      end

      it "ダッシュボードへリダイレクトされること" do
        project_params = attributes_for(:project)
        sign_in @user
        patch :update, params: { id: @project.id, project: project_params }
        expect(response).to redirect_to root_path
      end
    end

    context "ゲストとして" do
      before do
        @project = create(:project)
      end

      it "302レスポンスを返すこと" do
        project_params = attributes_for(:project)
        patch :update, params: { id: @project.id, project: project_params }
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        project_params = attributes_for(:project)
        patch :update, params: { id: @project.id, project: project_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "認可されたユーザーとして" do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        sign_in @user
      end

      it "プロジェクトを削除出来ること" do
        expect {
          delete :destroy, params: { id: @project.id }
        }.to change(@user.projects, :count).by(-1)
      end
    end

    context "認可されていないユーザーとして" do
      before do
        @user = create(:user)
        other_user = create(:user)
        @project = create(:project, owner: other_user)
        sign_in @user
      end

      it "プロジェクトを削除出来ないこと" do
        delete :destroy, params: { id: @project.id }
        expect{ response }.not_to change(Project, :count)
      end

      it "ダッシュボードにリダイレクトすること" do
        delete :destroy, params: { id: @project.id }
        expect(response).to redirect_to root_path
      end
    end

    context "ゲストとして" do
      before do
        @project = create(:project)
      end

      it "302レスポンスを返すこと" do
        delete :destroy, params: { id: @project.id }
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        delete :destroy, params: { id: @project.id }
        expect(response).to redirect_to "/users/sign_in"
      end

      it "プロジェクトを削除出来ないこと" do
        expect{
          delete :destroy, params: { id: @project.id }
        }.to_not change(Project, :count)
      end
    end
  end
end
