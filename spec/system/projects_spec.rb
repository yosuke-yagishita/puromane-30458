require 'rails_helper'

RSpec.describe "プロジェクトの新規作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @project_title = Faker::Team.name
  end

  context 'プロジェクトを作成できるとき' do
    it 'ログインしたユーザーはプロジェクトを新規作成できる' do
      sign_in(@user)
      expect(page).to have_content("新規プロジェクト作成")
      visit new_project_path
      fill_in 'project_title', with: @project_title
      expect{
        click_on("プロジェクト作成")
      }.to change { Project.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content(@project_title)
    end
  end
  context 'プロジェクトが作成できないとき' do
    it 'ログインしていないとindexページに遷移できない' do
      visit root_path
      expect(current_path).to eq new_user_session_path
    end
    it 'タイトルが正しく入力されていないとプロジェクトを作成できない' do
      sign_in(@user)
      expect(page).to have_content("新規プロジェクト作成")
      visit new_project_path
      expect{
        click_on("プロジェクト作成")
      }.to change { Project.count }.by(0)
    end
  end
end

RSpec.describe "プロジェクトのメンバー編集機能", type: :system do
  before do
    @project_user = FactoryBot.create(:project_user)
    @another_user = FactoryBot.create(:user)
  end

  context 'プロジェクトメンバーの編集ができるとき' do
    it 'ログインしたユーザーはindexビューからメンバーを編集できる' do
      sign_in(@project_user.user)
      find_link(href: edit_project_path(@project_user.project.id)).click
      select "#{@another_user.nickname}", from: "user_join"
      click_on ('Update Project')
    end
  end
end

RSpec.describe "プロジェクトの削除機能", type: :system do
  before do
    @project_user = FactoryBot.create(:project_user)
  end

  it 'プロジェクトを削除すると、関連するタスクがすべて削除されていること' do
    sign_in(@project_user.user)
    find_link(href: project_path(@project_user.project.id)).click
    FactoryBot.create_list(:task, 5, project_id: @project_user.project.id, user_id: @project_user.user.id)
    find_link("プロジェクトの終了", href: project_path(@project_user.project)).click
    expect{
      expect(page.accept_confirm).to eq "プロジェクトを終了しますか？"
      # confirmダイアログにアクセプトしたあとに表示が消えていることを確認
      expect(page).to have_no_content "プロジェクトを終了しますか？"
    }.to change { Task.count }.by(-5)
  end
end
