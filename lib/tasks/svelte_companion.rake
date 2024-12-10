# frozen_string_literal: true
desc 'add random 64-character-long global_id to all posts'
task 'svelte_companion:populate_global_id' => :environment do
  require 'securerandom'
  require 'parallel'
  Parallel.each(Post.all, progress: "Posts") do |post|
      post.update_column(:global_id, SecureRandom.hex(32))
  end

end

