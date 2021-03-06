require 'rails_helper'

describe Post do

  include TestFactories
  
  describe "vote methods" do

    before do

      @user = create :user
      @post = create(:post, user: @user)
      allow(@post).to receive(:create_vote)
      @post.save

      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe '#up_votes' do
      it "counts the number of votes with value = 1" do
        expect( @post.up_votes).to eq(3)
      end
    end

    describe '#down_votes' do
      it "counts the number of votes with value = -1" do
        expect( @post.down_votes).to eq(2)
      end
    end

    describe '#points' do
      it 'returns the sum of all down and up votes' do
        expect( @post.points ).to eq(1) # 3 - 2
      end
    end

    describe 'creation' do
      it "generates an automatic up-vote" do
#        user = authenticated_user
#        post = Post.create(title: 'Post Title', body: 'This is a small post body string', user: user)
        post = create(:post)
       
        expect( post.up_votes ).to eq(0)
      end
    end
  end
end
