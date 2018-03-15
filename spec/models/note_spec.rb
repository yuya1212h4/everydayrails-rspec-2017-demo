require 'rails_helper'

RSpec.describe Note, type: :model do


    before do
      @user = User.create(
        first_name: "Joe",
        last_name: "Tester",
        email:     "joetester@example.com",
        password:  "password"
      )

      @project = @user.projects.create(
        name: "Test Project"
      )
    end

    it "ユーザー、プロジェクト、メッセージがあれば有効な状態であること" do
      note = Note.new(
        message: "This is a sample note.",
        user: @user,
        project: @project
      )
      expect(note).to be_valid
    end

    it "メッセージがなければ、無効な状態であること" do
      note = Note.new(message: nil)
      note.valid?
      expect(note.errors[:message]).to include("can't be blank")
    end

    describe "文字列に一致するメッセージを検索する" do
      before do
        @note1 = @project.notes.create(
          message: "This is the first note.",
          user: @user
        )
        @note2 = @project.notes.create(
          message: "This is the second note.",
          user: @user
        )
        @note3 = @project.notes.create(
          message: "First, preheat the oven.",
          user: @user
        )
      end

      context "一致するデータが見つかるとき" do
        it "検索文字列に一致するメモを返すこと" do
          expect(Note.search("first")).to include(@note1, @note3)
          expect(Note.search("first")).not_to include(@note2)
        end
      end

      context "一致するデータが一件も見つからないとき" do
        it "検索結果が1件も見つからなかったら、空のコレクションを返すこと" do
          expect(Note.search("message")).to be_empty
        end
      end

  end
end
