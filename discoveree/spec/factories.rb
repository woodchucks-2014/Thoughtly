FactoryGirl.define do
  factory :user do
    email {"user@gmail.com"}
    password "password"
    password_confirmation "password"
  end

  # factory :category do
  #   name {"Gut Bacteria"}
  #   related_categories {"[fungus, bacteria, gut flora, E. coli, bifidobacteria]"}
  # end

  # factory :content do
  #   url {"http://www.webmd.com/digestive-disorders/news/20140725/diet-changes-can-alter-gut-bacteria-study-says"}
  #   source {"gut bacteria"}
  #   user {user.id}
  #   references {category.id}
  # end
end
