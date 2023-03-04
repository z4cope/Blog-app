require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  it 'is valid with a title and an author' do
    post = Post.new(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(author: user, comments_counter: 0, likes_counter: 0)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid with a title longer than 250 characters' do
    post = Post.new(title: 'a' * 251, author: user, comments_counter: 0, likes_counter: 0)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'updates the author posts_counter after save' do
    expect { user.posts.create(title: 'Test Post', comments_counter: 0, likes_counter: 0) }.to change {
                                                                                                 user.reload.posts_counter
                                                                                               }.from(0).to(1)
  end

  describe '#recent_comments' do
    let(:post) { Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:older_comment) { Comment.create(text: 'Older Comment', post: post, author: user) }
    let!(:newer_comments) { Comment.create(text: 'Newer Comment', post: post, author: user) }
    let!(:another_comment) { Comment.create(text: 'Another Comment', post: post, author: user) }

    it 'returns the most recent comments for the post' do
      expect(post.recent_comments.size).to eq(3)
    end

    it 'returns at most 5 comments' do
      3.times do |n|
        Comment.create(text: "Comment #{n}", post: post, author: user)
      end
      expect(post.recent_comments.size).to eq(5)
    end
  end
end
