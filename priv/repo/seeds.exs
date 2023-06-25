# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SurfaceApp.Repo.insert!(%SurfaceApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SurfaceApp.Repo
import Ecto.UUID
alias SurfaceApp.Accounts.User
alias SurfaceApp.Accounts.UserStats
alias SurfaceApp.Timeline.Post

alias Ecto.UUID

{:ok, result} = Repo.query("
INSERT INTO mc_card(id,category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four)
  VALUES ($1,'Sports',30,'What position is former Major League Baseball player, Rollie Fingers famous for playing?','Pitcher','Catcher','First Base','Pitcher','Third Base'),
   ($2,'Literature',50,'At The Mountains of Madness','H.P. Lovecraft','H.P. Lovecraft','Peter Straub','Edgar Allan Poe','C.S. Lewis'),
   ($3,'Sports',10,'What position is former baseball player for the Cincinnati Reds, Johnny Bench famous for playing?','Catcher','Second Base','Shortstop','Catcher','Pitcher'),
   ($4,'Literature',40,'Leaves of Grass','Walt Whitman','Carl Sandberg','T.S. Eliot','Robert Frost','Walt Whitman'),
   ($5,'Literature',10,'1984; Animal Farm','George Orwell','Herman Hesse','Rudyard Kipling','George Orwell','Aldous Huxley'),
   ($6,'History',30,'After unsuccessful  talks about oil production and debt repayment, Iraq occupied Kuwait.  In January 1991 the US launched an air attack against military targets in Iraq and Kuwait in this operation.','Desert Storm','Matador','BOLERO','Determined Force','Desert Storm'),
   ($7,'History',20,'It is the process of producing identical copies of a DNA segment asexually.  In 1996 the first successful one of an animal was made. The animals name was Dolly.  Dolly later died, but Richard Seed announced that he intended try it on humans.','Cloning','Organ Transplant','Cloning','Bloodless Surgery','Laser Surgery'),
   ($8,'Geography',30,'What is the capital of Belgium?','Brussels','Amsterdam','Luxemburg','Brussels','Stockholm'),
   ($9,'Geography',30,'What is the capital of Afghanistan?','Kabul','Tirana','Kabul','Dushanbe','Tashkent'),
   ($10,'Geography',50,'The longest river in Europe is Volga. But do you know which is the second longest one? It flows through several major European cities, such as Ulm, Vienna, Bratislava, Budapest and Belgrade. The river empties in the Black Sea on the terrirories of Romania and Ukraine.','Danube','Don','Dniepr','Danube','Emba'),
   ($11,'History',10,'In 1990, this 5000 year old body was found in the Alps. Scientists discovered some tattoos on his leg which indicated that acupuncture was used as far back as the Copper-stone Age.','Oetzi','Big Foot','Sasquatch','Nessie','Oetzi'),
   ($12,'Movies',30,'I would rather be a ghost drifting by your side as a condemned soul than enter heaven without you. Because of your love, I will never be a lonely spirit. (2000)','Crouching Tiger, Hidden Dragon','Don Juan DeMarco','Ever After','Crouching Tiger, Hidden Dragon','Dracula'),
   ($13,'Movies',30,'Love has given me wings so I must fly. (2001)','A Knights Tale','A Knights Tale','Phenomenon','Ever After','Forget Paris'),
   ($14,'Movies',40,'Love? Above all things I believe in love! Love is like oxygen! Love is a many splendored thing, love lifts us up where we belong, all you need is love!','001)','Moulin Rouge','Hope Floats','Some Like It Hot','Casablanca'),
   ($15,'Science',10,'Clouds are made up of these.','Water droplets and ice crystals','Carbon atoms','Water droplets and ice crystals','Oxygen ions','Dust mites'),
   ($16,'Science',40,'This formation is a conical hill or mountain. It is formed by mantle material being pressed through an opening in the Earths crust.','A volcano','A volcano','A hill','An earthquake','A geyser'),
   ($17,'Science',20,'Japan suffers from this event very often. It is the sudden, light or violent movement of the earths surface caused by the release of energy in the earths crust.','Earthquake','Volcano','Earthquake','Tide','Tsunami'),
   ($18,'Literature',60,'Its translation into local languages was forbidden in Burma.','The Bible','The Quran','The Cabala','Arabian Nights','The Bible'),
   ($19,'Sports',30,'Steve Garvey is a famous former baseball player, who is known for playing what position?','First Base','First Base','Shortstop','Third Base','Catcher')",
   [UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(),
   UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate(), UUID.bingenerate()]
)

Repo.insert_all(User, [
      %{username: "admin", user_follows: [2,3,4,5,6], user_post_likes: [1,2,5], email: "admin@admin.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "jim_the_og", user_follows: [1,3,4,5,6], user_post_likes: [1], email: "jim@jim.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "aaron", user_follows: [1,2,4,5,6], user_post_likes: [7], email: "aaron@aaron.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "r_boyd", user_follows: [1,2,3,5], email: "User1@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "TheMan98", email: "User2@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "Anders01", email: "User3@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "j_trumpet", email: "User4@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "JudFrazier", email: "User5@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "MMMM0101", email: "User6@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "BigBadRoy", email: "User7@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "tatTay33", email: "User8@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "r_r_lays", email: "User9@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "redman6", email: "redman@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "Howitzaaah", email: "bbr@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "temp09tem", email: "t89t@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

Repo.insert_all(UserStats, [
      %{id: 1, easy_games_played: 10, easy_games_finished: 10, easy_poss_pts: 700, easy_earned_pts: 650,
                    med_games_played: 5, med_games_finished: 5, med_poss_pts: 700, med_earned_pts: 650,
                    hard_games_played: 5, hard_games_finished: 5,  hard_poss_pts: 1000, hard_earned_pts: 900},
      %{id: 2, easy_games_played: 5, easy_games_finished: 5, easy_poss_pts: 450, easy_earned_pts: 450,
                    med_games_played: 2, med_games_finished: 2, med_poss_pts: 600, med_earned_pts: 600,
                    hard_games_played: 2, hard_games_finished: 2,  hard_poss_pts: 900, hard_earned_pts: 900},
      %{id: 3, easy_games_played: 2, easy_games_finished: 2, easy_poss_pts: 350, easy_earned_pts: 350,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 400, med_earned_pts: 400,
                    hard_games_played: 1, hard_games_finished: 1,  hard_poss_pts: 600, hard_earned_pts: 600},
      %{id: 4, easy_games_played: 0, easy_games_finished: 0, easy_poss_pts: 0, easy_earned_pts: 0,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 200, med_earned_pts: 200,
                    hard_games_played: 0, hard_games_finished: 0,  hard_poss_pts: 0, hard_earned_pts: 0},
      %{id: 5, easy_games_played: 10, easy_games_finished: 10, easy_poss_pts: 700, easy_earned_pts: 650,
                    med_games_played: 5, med_games_finished: 5, med_poss_pts: 700, med_earned_pts: 650,
                    hard_games_played: 5, hard_games_finished: 5,  hard_poss_pts: 1000, hard_earned_pts: 900},
      %{id: 6, easy_games_played: 5, easy_games_finished: 5, easy_poss_pts: 450, easy_earned_pts: 450,
                    med_games_played: 2, med_games_finished: 2, med_poss_pts: 600, med_earned_pts: 600,
                    hard_games_played: 2, hard_games_finished: 2,  hard_poss_pts: 900, hard_earned_pts: 900},
      %{id: 7, easy_games_played: 2, easy_games_finished: 2, easy_poss_pts: 350, easy_earned_pts: 350,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 400, med_earned_pts: 400,
                    hard_games_played: 1, hard_games_finished: 1,  hard_poss_pts: 600, hard_earned_pts: 600},
      %{id: 8, easy_games_played: 0, easy_games_finished: 0, easy_poss_pts: 0, easy_earned_pts: 0,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 200, med_earned_pts: 200,
                    hard_games_played: 0, hard_games_finished: 0,  hard_poss_pts: 0, hard_earned_pts: 0},
      %{id: 9, easy_games_played: 10, easy_games_finished: 10, easy_poss_pts: 700, easy_earned_pts: 650,
                    med_games_played: 5, med_games_finished: 5, med_poss_pts: 700, med_earned_pts: 650,
                    hard_games_played: 5, hard_games_finished: 5,  hard_poss_pts: 1000, hard_earned_pts: 900},
      %{id: 10, easy_games_played: 5, easy_games_finished: 5, easy_poss_pts: 450, easy_earned_pts: 450,
                    med_games_played: 2, med_games_finished: 2, med_poss_pts: 600, med_earned_pts: 600,
                    hard_games_played: 2, hard_games_finished: 2,  hard_poss_pts: 900, hard_earned_pts: 900},
      %{id: 11, easy_games_played: 2, easy_games_finished: 2, easy_poss_pts: 350, easy_earned_pts: 350,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 400, med_earned_pts: 400,
                    hard_games_played: 1, hard_games_finished: 1,  hard_poss_pts: 600, hard_earned_pts: 600},
      %{id: 12, easy_games_played: 0, easy_games_finished: 0, easy_poss_pts: 0, easy_earned_pts: 0,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 200, med_earned_pts: 200,
                    hard_games_played: 0, hard_games_finished: 0,  hard_poss_pts: 0, hard_earned_pts: 0},
      %{id: 13, easy_games_played: 5, easy_games_finished: 5, easy_poss_pts: 450, easy_earned_pts: 450,
                    med_games_played: 2, med_games_finished: 2, med_poss_pts: 800, med_earned_pts: 800,
                    hard_games_played: 2, hard_games_finished: 2,  hard_poss_pts: 900, hard_earned_pts: 900},
      %{id: 14, easy_games_played: 2, easy_games_finished: 2, easy_poss_pts: 350, easy_earned_pts: 350,
                    med_games_played: 1, med_games_finished: 1, med_poss_pts: 400, med_earned_pts: 400,
                    hard_games_played: 1, hard_games_finished: 1,  hard_poss_pts: 700, hard_earned_pts: 700}
])

# # For if using binary id for autogenerate purposes
# if Mix.env() == :dev do
#       Timeline.create_post(%{title: "First Post", body: "This is my first post here. It sure is nice to meet everyone and joine a great community :)", user_id: 1, username: "jim_the_og", likes_count: 2, 
#                     reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "Need Some Help Here", body: "Does anyone know where I can find a good solution for this one problem that I have?", user_id: 4, username: "TheMan98", likes_count: 1, 
#                     reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "The Beret", body: "This morning I woke up and decided I was going to wear a beret. Today is the day.", user_id: 6, username: "j_trumpet", likes_count: 0, 
#                     reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "2nd Post", body: "Hey look, it is post #2 for me. Still liking it here.", user_id: 1, username: "jim_the_og", likes_count: 0, 
#                     reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "First Post", body: "Blouse!", user_id: 1, username: "jim_the_og", likes_count: 1, 
#                     reposts_count: 1, private: true, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "Tell Me ...", body: "Who is your favorite band for anyone there who would like to answer?", user_id: 4, username: "TheMan98", likes_count: 0, 
#                     reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "Like?", body: "Well this is pretty cool to be able to see that everyone here is liking the posts", user_id: 3, username: "r_boyd", likes_count: 1, 
#                     reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
#       Timeline.create_post(%{title: "Private Post", body: "This is a private post so I wonder who will be able to see this one?", user_id: 3, username: "r_boyd", likes_count: 1, 
#                     reposts_count: 1, private: true, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()})
# end

Repo.insert_all(Post, [
      %{id: 1, title: "First Post", body: "This is my first post here. It sure is nice to meet everyone and joine a great community :)", user_id: 1, username: "jim_the_og", likes_count: 2, 
                    reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 2, title: "Need Some Help Here", body: "Does anyone know where I can find a good solution for this one problem that I have?", user_id: 4, username: "TheMan98", likes_count: 1, 
                    reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 3, title: "The Beret", body: "This morning I woke up and decided I was going to wear a beret. Today is the day.", user_id: 6, username: "j_trumpet", likes_count: 0, 
                    reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 4, title: "2nd Post", body: "Hey look, it is post #2 for me. Still liking it here.", user_id: 1, username: "jim_the_og", likes_count: 0, 
                    reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 5, title: "First Post", body: "Blouse!", user_id: 1, username: "jim_the_og", likes_count: 1, 
                    reposts_count: 1, private: true, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 6, title: "Tell Me ...", body: "Who is your favorite band for anyone there who would like to answer?", user_id: 4, username: "TheMan98", likes_count: 0, 
                    reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 7, title: "Like?", body: "Well this is pretty cool to be able to see that everyone here is liking the posts", user_id: 3, username: "r_boyd", likes_count: 1, 
                    reposts_count: 1, private: false, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: 8, title: "Private Post", body: "This is a private post so I wonder who will be able to see this one?", user_id: 3, username: "r_boyd", likes_count: 1, 
                    reposts_count: 1, private: true, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
])


SurfaceApp.Rooms.create_room(%{"create_room" => %{"name" => "lobby", "description" => "Welcome", "user_id" => 1}})

# SurfaceApp.Rooms.create_room(user = %User{username: "jim_the_og"}, room = %Room{id: 1})
# {:ok, result} = Repo.query("INSERT INTO mc_card(category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four) VALUES ('Literature',30,'This book led Austin Miles to the courts in 1992.  Miles was sued because his book was ...a vitriolic attack upon organized Christianity.','Dont Call Me Brother','Leaves of Grass','Dictionary of American Slang','Jerusalem Delivered','Dont Call Me Brother')")
# {:ok, result} = Repo.query("INSERT INTO mc_card(category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four) VALUES ('Literature',20,'This book by Judy Blume was censored as it discussed adolescent sexuality in too much detail.','Forever','Grapes of Wrath','Lolita','Freedom and Order','Forever')")
# {:ok, result} = Repo.query("INSERT INTO mc_card(category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four) VALUES ('Literature',20,'This book by George Orwell was banned as it was pro-communist.','1984','The Sun Also Rises','Coming Up for Air','1984','Deliverance')")
# {:ok, result} = Repo.query("INSERT INTO mc_card(category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four) VALUES ('Literature',50,'This Lewis Carrolls work was banned in China because in it humans and animals used the same language.','Alices Adventures in Wonderland','Sylvie and Bruno','Alices Adventures in Wonderland','Through The Looking Glass','The Hunting of the Snark')")
# {:ok, result} = Repo.query("INSERT INTO mc_card(category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four) VALUES ('Literature',60,'Its translation into local languages was forbidden in Burma.','The Bible','The Quran','The Cabala','Arabian Nights','The Bible')")
# {:ok, result} = Repo.query("INSERT INTO mc_card(category,points_worth,question_text,answer,choice_one,choice_two,choice_three,choice_four) VALUES ('Literature',60,'This book was censored in 1985 in Cairo, Egypt as it contained obscene passages which posed a threat to the countrys moral fabric.','Arabian Nights','Arabian Nights','Don Quixote','Analects','Brave New World')")