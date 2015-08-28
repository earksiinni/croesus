FactoryGirl.define do
  factory :fruit_bat do
    fangs 'medium'
    
    trait :with_local_credential do
      after(:create) { |fruit_bat|
        FactoryGirl.create(:local_credential, authenticatable: fruit_bat)
      }
    end
  end
  
  factory :local_credential, class: Croesus::LocalCredential do
    sequence :username do |n|
      "ersin_#{n}@twomaestros.com"
    end
    encrypted_password 'abcdefg'
    salt 'saltysalt'
  end
  
  factory :session, class: Croesus::Session do
    secret 'mostsecret'
    sequence :nonce do |n|
      "mostnonce_#{n}"
    end
    token 'mosttoken'
    expires_at 5.years.from_now
  end
end