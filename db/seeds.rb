# Ensure Users are Unique
admin = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin User"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "admin"  # ✅ Ensure role is set
end

user1 = User.find_or_create_by!(email: "jeri@gmail.com") do |user|
  user.name = "Jess Fernandez"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "user"  # ✅ Ensure role is set
end

# Ensure Categories are Unique
categories = [
  { name: "Dining" },
  { name: "Travel" },
  { name: "Groceries" },
  { name: "Gas" },
  { name: "Online Shopping" },
  { name: "Other" }
]
categories.each { |category| Category.find_or_create_by!(category) }

# Fetch categories from DB to prevent nil errors
dining = Category.find_by(name: "Dining")
travel = Category.find_by(name: "Travel")
groceries = Category.find_by(name: "Groceries")
gas = Category.find_by(name: "Gas")
online_shopping = Category.find_by(name: "Online Shopping")
other = Category.find_by(name: "Other")

# Ensure Credit Cards are Unique
jeri_card = user1.credit_cards.find_or_create_by!(name: "Chase Sapphire Preferred", bank: "Chase") do |card|
  card.custom_name = "Sapphire"
end

jeri_card2 = user1.credit_cards.find_or_create_by!(name: "FHB United", bank: "First Hawaiian Bank") do |card|
  card.custom_name = "FHB"
end

jeri_card3 = user1.credit_cards.find_or_create_by!(name: "Capital One Venture X", bank: "Capital One") do |card|
  card.custom_name = "C1VX"
end

# Assign Categories to Credit Cards (Only if they exist)
UserCategory.find_or_create_by!(credit_card: jeri_card, category: dining) do |uc|
  uc.points_per_dollar = 3
end

UserCategory.find_or_create_by!(credit_card: jeri_card, category: travel) do |uc|
  uc.points_per_dollar = 2
end

UserCategory.find_or_create_by!(credit_card: jeri_card, category: other) do |uc|
  uc.points_per_dollar = 1
end

UserCategory.find_or_create_by!(credit_card: jeri_card2, category: travel) do |uc|
  uc.points_per_dollar = 3
end

UserCategory.find_or_create_by!(credit_card: jeri_card2, category: groceries) do |uc|
  uc.points_per_dollar = 2
end

UserCategory.find_or_create_by!(credit_card: jeri_card2, category: other) do |uc|
  uc.points_per_dollar = 1
end

UserCategory.find_or_create_by!(credit_card: jeri_card3, category: gas) do |uc|
  uc.points_per_dollar = 3
end

UserCategory.find_or_create_by!(credit_card: jeri_card3, category: groceries) do |uc|
  uc.points_per_dollar = 2
end

UserCategory.find_or_create_by!(credit_card: jeri_card3, category: other) do |uc|
  uc.points_per_dollar = 1.5
end

puts "Seeding completed successfully!"