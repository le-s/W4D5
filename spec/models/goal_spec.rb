# == Schema Information
#
# Table name: goals
#
#  id          :bigint(8)        not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  secret_goal :boolean          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:secret_goal) }

  describe 'Goal creation' do
    context "goal is public" do
      it "should be visible to the submitter"
      it "should be visible to others"
    end
    context "goal is private" do
      it "should be visible to the submitter"
      it "should not be visible to others"
    end
  end

end
