require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'John Doe', posts_counter: 0) }

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#most_recent_posts' do
    let(:user) { User.create(name: 'mohamed', posts_counter: 0) }
    let!(:post1) { Post.create(title: 'first post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:post2) { Post.create(title: 'second post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:post3) { Post.create(title: 'third post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:post4) { Post.create(title: 'fourth post', author: user, comments_counter: 0, likes_counter: 0) }

    it 'returns the 3 most recent posts' do
      expect(user.most_recent_posts).to eq([post2, post3, post4])
    end
  end
end
