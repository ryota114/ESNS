# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "テスト太郎",
  email: "test@test.com",
  password: "testtest",
  encrypted_password: "testtest",
  introduction: "test",
  is_deleted: false
  )

Post.create!(
  user_id: 1,
  body: "テスト投稿",
  genre: 0,
  exercise_intensity: 0,
  exercise_time: 0
  )