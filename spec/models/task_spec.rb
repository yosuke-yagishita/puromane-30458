require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'タスク新規登録' do
    context '新規登録がうまくいくとき' do
      it '値が正しく存在すれば登録できること' do
        expect(@task).to be_valid
      end
      it 'task_nameが存在すれば登録できること' do
        @task.task_name = '新規プロジェクト'
        expect(@task).to be_valid
      end
      it 'person_in_chargeがなくても登録できること' do
        @task.person_in_charge = nil
        expect(@task).to be_valid
      end
      it 'planがなくても登録できること' do
        @task.plan = nil
        expect(@task).to be_valid
      end
      it 'completion_dateがなくても登録できること' do
        @task.completion_date = nil
        expect(@task).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'task_nameが存在しないと保存ができないこと' do
        @task.task_name = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("Task name can't be blank")
      end
      it 'userが紐づいていないと保存できないこと' do
        @task.user = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("User must exist")
      end
      it 'projectが紐づいていないと保存できないこと' do
        @task.project = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("Project must exist")
      end
    end
  end
end
