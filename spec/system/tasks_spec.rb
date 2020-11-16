require 'rails_helper'

RSpec.describe "タスクの新規作成", type: :system do
  before do
    @project_user = FactoryBot.create(:project_user)
  end

  context 'タスクの作成に成功したとき' do
    it 'タスクの作成に成功すると、プロジェクト詳細画面に遷移して、タスクが表示されている' do
      sign_in(@project_user.user)
      find_link(href: project_path(@project_user.project.id)).click
      fill_in 'task_task_name', with: "タスク"
      fill_in 'task_person_in_charge', with: "hoge"
      fill_in 'task_plan', with: "002020-12-1"
      expect {
        click_on("タスクを作成する")
      }.to change { Task.count }.by(1)
      expect(page).to have_content("タスク")
      expect(page).to have_content("hoge")
      expect(page).to have_content("12/01")
    end
  end
  context 'タスクの作成に失敗したとき' do
    it 'task_nameが空の為、タスクの作成ができない' do
      sign_in(@project_user.user)
      find_link(href: project_path(@project_user.project.id)).click
      expect {
        click_on("タスクを作成する")
      }.to change { Task.count }.by(0)
      expect(current_path).to eq project_tasks_path(@project_user.project)
    end
  end
end

RSpec.describe "タスクの編集", type: :system do
  before do
    @project_user = FactoryBot.create(:project_user)
    @task = FactoryBot.create_list(:task, 1, project_id: @project_user.project.id, user_id: @project_user.user.id)
  end

  context 'タスクの編集に成功したとき' do
    it 'プロジェクトのメンバーはタスクの編集ができる' do
      sign_in(@project_user.user)
      find_link(href: project_path(@project_user.project.id)).click
      find_link(href: edit_project_task_path(@project_user.project, @task)).click
      fill_in 'task_task_name', with: "edit_タスク"
      fill_in 'task_person_in_charge', with: "edit_hoge"
      fill_in 'task_plan', with: "002020-12-2"
      fill_in 'task_completion_date', with: "002020-12-3"
      click_on ("タスクを編集する")
      expect(current_path).to eq project_path(@project_user.project.id)
      expect(page).to have_content("edit_タスク")
      expect(page).to have_content("edit_hoge")
      expect(page).to have_content("12/02")
      expect(page).to have_content("12/03")
    end
  end
  context 'タスクの編集に失敗したとき' do
    it 'ロウグインしていないユーザーはタスクの編集画面に遷移できない' do
      visit edit_project_task_path(@project_user.project, @task)
      expect(current_path).to eq new_user_session_path
    end
    it 'プロジェクトに参加していないメンバーはユーザーはタスクの編集画面に遷移できない' do
      @another_user = FactoryBot.create(:user)
      sign_in(@another_user)
      visit edit_project_task_path(@project_user.project, @task)
      expect(current_path).to eq root_path
    end
  end
end
  
RSpec.describe "タスクの削除", type: :system do
  before do
    @project_user = FactoryBot.create(:project_user)
    @task = FactoryBot.create_list(:task, 1, project_id: @project_user.project.id, user_id: @project_user.user.id)
  end

  context 'タスクの削除に成功したとき' do
    it 'プロジェクトのメンバーはタスクの削除ができる' do
      sign_in(@project_user.user)
      find_link(href: project_path(@project_user.project.id)).click
      find_link(href: edit_project_task_path(@project_user.project, @task)).click
      click_on ("タスクの終了")
      expect {
        expect(page.accept_confirm).to eq "タスクを終了しますか？"
        # confirmダイアログにアクセプトしたあとに表示が消えていることを確認
        expect(page).to have_no_content "タスクを終了しますか？"
      }.to change { Task.count }.by(-1)
      expect(current_path).to eq project_path(@project_user.project.id)
    end
  end
end