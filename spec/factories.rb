FactoryGirl.define do

  factory :booking do
    name "Awesome t-shirt"
    quantity  50
    tags "t-shirts, fashion, tops"
    categories { build_list :category, 1 }
  end

end
