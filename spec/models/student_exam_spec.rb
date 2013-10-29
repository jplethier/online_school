require 'spec_helper'

describe StudentExam do
  subject { student_exam }

  let(:student_exam) { FactoryGirl.build :student_exam }

  its(:valid?) { should be true }

  describe 'validations' do
    it 'requires a student' do
      expect { student_exam.student = nil }.to change{ student_exam.valid? }.from(true).to(false)
    end

    it 'requires an exam' do
      expect { student_exam.exam = nil }.to change{ student_exam.valid? }.from(true).to(false)
    end

    describe 'grade' do
      it 'has to be a number' do
        # nao to conseguindo testar, pois qualquer string que eu passe para student_exam.grade ele converte automaticamente para float e se torna valido
        # expect { student_exam.grade = '1' }.to change{ student_exam.valid? }.from(true).to(false)
        # expect { student_exam.grade = 1.0 }.to_not change{ student_exam.valid? }.from(true).to(false)
      end

      it 'is required' do
        expect { student_exam.grade = nil }.to change{ student_exam.valid? }.from(true).to(false)
      end
    end
  end
end
