alias Anais.Repo
alias Anais.Account

Repo.insert!(%Account.Author{
  email: "algus@mail.com",
  password: "$2b$12$nKyVd1Nd6pWhpFFNp6rzQOpM2sny5WwRdzeycQ2kDeKoxhYbe5iPO",
  name: "Seeder Silva"
  }
)
