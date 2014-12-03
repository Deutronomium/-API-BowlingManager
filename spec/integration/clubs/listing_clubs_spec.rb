require 'spec_helper'
require 'club'

describe '#listing all clubs' do
  context 'without filter' do
    before do
      FactoryGirl.create(:club)
      FactoryGirl.create(:club, name: 'secondClub')

      get '/clubs'
    end

    it 'should respond wih success' do
      response.status.should eq(200)
    end

    it 'should respond with json' do
      response.content_type.should eq(Mime::JSON)
    end

    it 'should respond with 2 clubs' do
      clubs = json(response.body)[:clubs]
      clubs.size.should eq(Club.count)
    end
  end

  context 'with filter' do
    before do
      FactoryGirl.create(:club, name: 'Test')
      FactoryGirl.create(:club, name: 'FilterTest')

      get '/clubs?name=Test'
    end

    context 'answer type' do
      it 'should respond with status code ok' do
        response.should be_success
      end

      it 'should answer with json' do
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context 'answer content' do
      let(:clubs) { json(response.body)[:clubs] }

      it 'should answer with the club who has the name Test' do
        clubs.first[:name].should == Club.find_by_name('Test').name
      end

      it 'should answer with one club' do
        clubs.size.should eq(1)
      end
    end
  end
end