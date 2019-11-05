# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company_1 = Company.find_or_create_by(name: "TECHNOLOGY")

user_1 = User.find_or_create_by(name: "Star Wars 001", email: "lord_of_the_rings_001@gmail.com", company_id: company_1.id)
user_2 = User.find_or_create_by(name: "Star Wars 002", email: "lord_of_the_rings_002@gmail.com", company_id: company_1.id)
user_3 = User.find_or_create_by(name: "Star Wars 002", email: "lord_of_the_rings_003@gmail.com", company_id: company_1.id)

skill_1 = Skill.find_or_create_by(name: "React")
skill_2 = Skill.find_or_create_by(name: "Ruby")
skill_3 = Skill.find_or_create_by(name: "Rails")
skill_4 = Skill.find_or_create_by(name: "JS")

UserSkill.find_or_create_by(user_id: user_1.id, skill_id: skill_1.id)
UserSkill.find_or_create_by(user_id: user_1.id, skill_id: skill_2.id)
UserSkill.find_or_create_by(user_id: user_1.id, skill_id: skill_3.id)
UserSkill.find_or_create_by(user_id: user_1.id, skill_id: skill_4.id)

UserSkill.find_or_create_by(user_id: user_2.id, skill_id: skill_1.id)
UserSkill.find_or_create_by(user_id: user_2.id, skill_id: skill_2.id)
UserSkill.find_or_create_by(user_id: user_2.id, skill_id: skill_3.id)
UserSkill.find_or_create_by(user_id: user_2.id, skill_id: skill_4.id)

UserSkill.find_or_create_by(user_id: user_3.id, skill_id: skill_1.id)
UserSkill.find_or_create_by(user_id: user_3.id, skill_id: skill_2.id)
UserSkill.find_or_create_by(user_id: user_3.id, skill_id: skill_3.id)
UserSkill.find_or_create_by(user_id: user_3.id, skill_id: skill_4.id)
