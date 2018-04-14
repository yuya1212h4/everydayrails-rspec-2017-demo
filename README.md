# *Everyday Rails Testing with RSpec* sample application (2017 edition)

**Still a work in progress:** Refer to the [Everyday Rails] blog for news on
this edition of the book. You can find sample source for earlier editions in
the [everydayrails organization] on GitHub. Thanks!

---

Sample Rails 5.1 application for *[Everyday Rails Testing with RSpec]: A
Practical Approach to Test-driven Development* by Aaron Sumner. This
repository demonstrates incremental testing of an existing application,
starting with an untested codebase and working through model, controller,
feature, and request specs.

Each chapter's progress has a specific branch in this repository. See chapter
1 of the book for details.

Using Git, you can check out each version by name. See details in the book.

If you're not comfortable with Git, you can also use GitHub's handy branch/tag
filter to select a specific tag and browse the source code online. To learn
more about Git, I recommend the free resources [Git Immersion] or [Try Git].

[Everyday Rails]: https://everydayrails.com
[everydayrails organization]: https://github.com/everydayrails
[Everyday Rails Testing with RSpec]: https://leanpub.com/everydayrailsrspec
[Git Immersion]: http://gitimmersion.com/
[Try Git]: http://www.codeschool.com/courses/try-git


# 03-models
- 有効な属性で初期化された場合は、モデルの状態が有効（valid）になっていること
- バリデーションを失敗させるデータであれば、モデルの状態が有効になっていないこと
- クラスメソッドとインスタンスメソッドが期待通りに動作すること

期待する結果をまとめて記述（describe）している
example一つにつき、結果を一つだけ期待している
どのexampleも明示的である
各exampleの説明は動詞で始まっている、shouldではない

- 起きて欲しいこととと、起きて欲しくないことの両方をテストする
- 境界値のテストを行う
- 可読性を上げるために、スペックを整理する



<div id="node">
 <a href="http://nodejs.org">click here!</a>
</div>
<div id="rails">
 <a href="http://rubyonrails.org">click here!</a>
</div>

within "#rails" do
 click_link "click here!"
end

language = find_field("Programminglanguage").value
expect(language).to eq "Ruby"

find("#fine_print").find("#disclaimer").click
find_button("Publish").click
