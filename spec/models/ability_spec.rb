require 'spec_helper'
require "cancan/matchers"

describe Ability do
  context 'Any user' do
    let(:any_user)   { stub_model(User, account_id: 1, account: account) }
    let(:account)   { stub_model(Account, id: 1) }
    let(:ability)    { Ability.new(any_user) }

    it 'can not browse the dashboard' do
      expect(ability).to_not be_able_to :index, :dashboard
    end

    it 'can not manage groups' do
      group = stub_model(Group, account_id: any_user.account_id)
      expect(ability).to_not be_able_to :manage, group
    end

    it 'can not manage classrooms' do
      classroom = stub_model(Classroom, account_id: any_user.account_id)
      expect(ability).to_not be_able_to :manage, classroom
    end

    it 'can not manage the school account' do
      expect(ability).to_not be_able_to :manage, any_user.account
    end

    it 'can not manage users' do
      user = stub_model(User, account_id: any_user.account_id)
      expect(ability).to_not be_able_to :manage, user
    end

    it 'can not manage exams' do
      exam = stub_model(Exam, account_id: any_user.account_id)
      expect(ability).to_not be_able_to :manage, exam
    end
  end

  context 'Admin' do
    let(:admin)   { stub_model(User, admin: true, account_id: 1, account: account) }
    let(:account)   { stub_model(Account, id: 1) }
    let(:ability) { Ability.new(admin) }

    it 'can browse the dashboard' do
      expect(ability).to be_able_to :index, :dashboard
    end

    it 'can manage the school account' do
      expect(ability).to be_able_to :manage, admin.account
    end

    it 'can manage users that belong to his account' do
      same_account_user      = stub_model(User, account_id: admin.account_id)
      different_account_user = stub_model(User, account_id: 'different')

      expect(ability).to be_able_to :manage, same_account_user
      expect(ability).to_not be_able_to :manage, different_account_user
    end

    it 'can manage groups that belong to his account' do
      same_account_group      = stub_model(Group, account_id: admin.account_id)
      different_account_group = stub_model(Group, account_id: 'different')

      expect(ability).to be_able_to :manage, same_account_group
      expect(ability).to_not be_able_to :manage, different_account_group
    end

    it 'can manage classrooms that belong to his account' do
      same_account_classroom      = stub_model(Classroom, account_id: admin.account_id)
      different_account_classroom = stub_model(Classroom, account_id: 'different')

      expect(ability).to be_able_to :manage, same_account_classroom
      expect(ability).to_not be_able_to :manage, different_account_classroom
    end

    it 'can manage exams that belong to his account' do
      same_account_exam      = stub_model(Exam, account_id: admin.account_id)
      different_account_exam = stub_model(Exam, account_id: 'different')

      expect(ability).to be_able_to :manage, same_account_exam
      expect(ability).to_not be_able_to :manage, different_account_exam
    end
  end

  context 'Student' do
    let(:account) { stub_model(Account, id: 1) }
    let(:student) { stub_model(User, student: true, account_id: 1, account: account) }
    let(:ability) { Ability.new(student) }

    it 'can browse the dashboard' do
      expect(ability).to be_able_to :index, :dashboard
    end

    it 'can not manage the school account' do
      expect(ability).to_not be_able_to :manage, student.account
    end

    it 'can view his classrooms' do
      student_classroom = FactoryGirl.create(:classroom, account: student.account)
      user_group = FactoryGirl.create(:user_group, user: student)
      student_classroom.entries << FactoryGirl.create(:entry, user_group: user_group)
      another_classroom = stub_model(Classroom)

      expect(ability).to be_able_to :read, student_classroom
      expect(ability).to_not be_able_to :read, another_classroom
    end
  end
end
