FactoryBot.define do
  factory :project do
    title {"Salvar Nassau"}
    description {"Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers"}
    wanted_skills {"Ser capaz de lutar"}
    max_pay {50}
    expiration_date {10.days.from_now}
    user {user}
  end
end
