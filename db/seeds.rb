# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(username:  "Admin",
             email: "admin@example.jp",
             password:  "11111111",
             password_confirmation: "11111111",
             admin: true)

5.times do |n|
  User.create!(username:  "User#{n + 1}",
               email: "user#{n + 1}@example.jp",
               password:  "11111111",
               password_confirmation: "11111111",
               admin: false)
end

# 5.times do |n|
#   Article.create!(
#     title: "article-title-#{n + 1}",
#     text: "article-text-#{n + 1}",
#     site_url: "https://iphone-mania.jp/news-47436#{n + 1}/",
#     user_id: "#{n + 1}",
#     url_id: "#{n + 1}"
#   )
# end

# 5.times do |n|
#   Article.create!(
#     title: "article-title-#{n + 1}",
#     text: "article-text-#{n + 1}",
#     site_url: "https://iphone-mania.jp/news-47435#{n + 1}/",
#     user_id: "#{4 - n}",
#     url_id: "#{4 - n}"
#   )
# end

# 5.times do |n|
#   Urls.create!(
#     content: "comment-content-#{n + 1}",
#     user_id: "#{n + 1}",
#     article_id: "#{n + 1}"
#   )
# end

# 5.times do |n|
#   Comment.create!(
#     content: "comment-content-#{n + 1}",
#     user_id: "#{n + 1}",
#     article_id: "#{n + 1}"
#   )
# end

# 5.times do |n|
#   Comment.create!(
#     content: "comment-content-#{n + 1}",
#     user_id: "#{4 - n}",
#     article_id: "#{4 - n}",
#   )
# end
