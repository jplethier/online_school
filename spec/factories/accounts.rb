# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do |f|
    f.contact_mail 'F_CONTACT_MAIL'
    f.name 'F_NAME'
    f.subdomain 'SUBDOMAIN'
  end
end
