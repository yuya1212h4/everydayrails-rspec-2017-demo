require 'rails_helper'

RSpec.describe Note, type: :model do

    it "検索文字列に一致するメモを返すこと" do
      user = User.create(
        first_name: "Joe",
        last_name: "Tester",
        email:     "joetester@example.com",
        password:  "password"
      )

      project = user.projects.create(
        name: "Test Project"
      )

      note1 = project.notes.create(
        message: "This is the first note.",
        user: user
      )
      note2 = project.notes.create(
        message: "This is the second note.",
        user: user
      )
      note3 = project.notes.create(
        message: "First, preheat the oven.",
        user: user
      )

      expect(Note.search("first")).to include(note1, note3)
      expect(Note.search("first")).not_to include(note2)
    end

    it "検索結果が1件も見つからなかったら、空のコレクションを返すこと" do
      user = User.create(
        first_name: "Joe",
        last_name: "Tester",
        email:     "joetester@example.com",
        password:  "password"
      )

      project = user.projects.create(
        name: "Test Project"
      )

      note1 = project.notes.create(
        message: "This is the first note.",
        user: user
      )
      note2 = project.notes.create(
        message: "This is the second note.",
        user: user
      )
      note3 = project.notes.create(
        message: "First, preheat the oven.",
        user: user
      )

      expect(Note.search("message")).to be_empty
    end
end
