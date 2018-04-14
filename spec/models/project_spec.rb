require 'rails_helper'

RSpec.describe Project, type: :model do
  it "ユーザー単位では重複したプロジェクト名を許可しないこと" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email:     "joetester@example.com",
      password:  "password"
    )
    user.projects.create(
      name: "Test Project"
    )
    new_project = user.projects.build(
      name: "Test Project"
    )
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "二人のユーザーが同じ名前を使うことは許可すること" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email:     "joetester@example.com",
      password:  "password"
    )
    user.projects.create(
      name: "Test Project"
    )
    other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email:     "janetester@example.com",
      password:  "password"
    )
    other_project = other_user.projects.build(
      name: "Test Project"
    )
    expect(other_project).to be_valid
  end

  describe "遅延ステータス" do
    it "締切日を過ぎていれば、遅延していること" do
      project = create(:project_due_yesterday)
      expect(project).to be_late
    end

    it "締切日が今日ならスケジュール通りであること" do
      project = create(:project_due_today)
      expect(project).to_not be_late
    end

    it "締切日が未来ならスケジュール通りであること" do
      project = create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  it "沢山のメモが付いていること" do
    project = create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end
