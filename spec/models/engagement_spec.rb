require 'spec_helper'

describe Engagement do
  it { should validate_presence_of(:start_date) }

  describe "#valid_end_date" do
    context "Having nil end_date but being otherwise valid" do
      let!(:engagement) { engagement_without_end }
      it { expects(engagement).to be_valid }
    end

    context "Having end_date on start_date" do
      let!(:engagement) { engagement_lasting(0) }
      it { expects(engagement).to be_valid }
    end

    context "Having end_date earlier than start_date" do
      let!(:engagement) { engagement_lasting(-1) }
      
      it do
        expects(engagement).not_to be_valid
        expects(engagement.errors.include?(:end_date)).to be_true
      end
    end

    context "Having end_date later than start_date" do
      let!(:engagement) { engagement_lasting(1) }
      it { expects(engagement).to be_valid }
    end
  end
  
private

  # Warning: probably won't do what you expect if you rely on nil end-date.
  # What it will do is allow FactoryGirl to apply whatever its default for
  # end-date is.  If you want a truly nil end-date, call #engagement_without_end_date.
  def engagement_lasting(integer)
    result = FactoryGirl.build(:engagement)
    result.end_date = result.start_date + integer
    result
  end

  def engagement_without_end
    # Take explicit action, to avoid any FactoryGirl default for end_date
    FactoryGirl.build(:engagement).tap { |e| end_date = nil }
  end
end
