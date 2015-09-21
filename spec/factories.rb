FactoryGirl.define do
  to_create { |i| i.save }

  factory :post, class: Scanty::Post do
    title      'whatever'
    created_at DateTime.now
    tags       'nothing'
    body       'bla bla bla'
  end
end
