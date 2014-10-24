require 'spec_helper'
require 'participation'

describe 'listing participations' do
  before do
    @club = FactoryGirl.create(:club)

    @Deutro = FactoryGirl.create(:user, club: @club)
    @Munni = FactoryGirl.create(:user, club: @club, userName: 'Munni')

    @bowling = FactoryGirl.create(:event)
    @driving = FactoryGirl.create(:event, name: 'Driving')

    FactoryGirl.create(:participation, event: @bowling, user: @Deutro)
    FactoryGirl.create(:participation, event: @driving, user: @Deutro)

    FactoryGirl.create(:participation, event: @bowling, user: @Munni)
    FactoryGirl.create(:participation, event: @driving, user: @Munni)
  end

  context 'listing all participations' do
    before do
      get 'participations'
    end

    context 'answer type' do
      it 'should answer with success' do
        response.status.should eq(200)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context 'answer content' do
      it 'should answer with all participations' do
        participations = json(response.body)[:participations]
        participations.size.should eq(Participation.count)
      end
    end
  end

  context 'listing participations by event' do
    it 'should answer with 2 participations' do
      get '/participations?event_id=1'
      participations = json(response.body)[:participations]
      participations.size.should eq(2)
    end
  end

  context 'listing participations by users' do
    it 'should answer with 2 participations' do
      get '/participations?user_id=1'
      participations = json(response.body)[:participations]
      participations.size.should eq(2)
    end
  end
end