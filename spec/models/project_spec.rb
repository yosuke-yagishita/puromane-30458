require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @project = FactoryBot.build(:project)
  end

  describe 'プロジェクトの新規作成' do
    context 'プロジェクトの新規作成がうまくいくとき' do
      it 'titleの値が存在すれば登録できること' do
        expect(@project).to be_valid
      end
    end
    context 'titleが空では登録できないこと' do
      it 'titleが空では登録できないこと' do
        @project.title = nil
        @project.valid?
        expect(@project.errors.full_messages).to include("Title can't be blank")
      end
    end
  end
end
