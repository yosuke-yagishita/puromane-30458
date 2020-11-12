require 'rails_helper'

RSpec.describe "プロジェクトの削除機能", type: :system do
  before do
    @project_user = FactoryBot.create(:project_user)
  end

  it 'プロジェクトを削除すると、関連するタスクがすべて削除されていること' do
    sign_in(@project_user.user)
    find_link(href: project_path(@project_user.project.id)).click
    FactoryBot.create_list(:task, 5, project_id: @project_user.project.id, user_id: @project_user.user.id)
    expect {
      page.accept_confirm do
      find_link("プロジェクトの終了", href: project_path(@project_user.project)).click
      end
    }.to change { Task.count }.by(0)
  end
end
