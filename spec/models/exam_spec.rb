require 'spec_helper'

describe Exam do
  subject { exam }

  let(:exam) { FactoryGirl.build :exam }

  its(:valid?) { should be true }

  describe 'validations' do
    it 'requires an account' do
      expect { exam.account = nil }.to change{ exam.valid? }.from(true).to(false)
    end

    it 'requires a classroom' do
      expect { exam.classroom = nil }.to change{ exam.valid? }.from(true).to(false)
    end

    it 'requires a kind' do
      expect { exam.kind = nil }.to change{ exam.valid? }.from(true).to(false)
    end

    it 'requires an exam date' do
      expect { exam.exam_date = nil }.to change{ exam.valid? }.from(true).to(false)
    end

    describe 'period' do
      it 'can not be a string' do
        expect { exam.period = 'period' }.to change { exam.valid? }.from(true).to(false)
      end

      it 'can not be a float' do
        expect { exam.period = 2013.1 }.to change { exam.valid? }.from(true).to(false)
      end

      it 'has to be integer' do
        expect { exam.period = 20131 }.to_not change { exam.valid? }.from(true).to(false)
      end
    end
  end
end
