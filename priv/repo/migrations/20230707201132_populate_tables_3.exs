defmodule SurfaceApp.Repo.Migrations.PopulateTables2 do
  use Ecto.Migration
  alias SurfaceApp.Game.McCard
  alias SurfaceApp.Repo

  def change do
    Repo.insert_all(McCard, [
      %{category: "Music", points_worth: 60, question_text: "Who had a 1981 hit with the song 'Japanese Boy'?", answer: "Aneka", choice_one: "Aneka", choice_two: "Toyah", choice_three: "Sandra", choice_four: "Madonna"},
      %{category: "Music", points_worth: 50, question_text: "Who was not in the band 'The Smiths'?", answer: "Martin Chambers", choice_one: "Morrissey", choice_four: "Andy Rourke", choice_three: "Mike Joyce", choice_two: "Martin Chambers"},
      %{category: "Music", points_worth: 50, question_text: "Which of these aliases has NOT been used by electronic musician Aphex Twin?", answer: "Burial", choice_one: "Caustic Window", choice_four: "Bradley Strider", choice_three: "GAK", choice_two: "Burial"},
      %{category: "Music", points_worth: 40, question_text: "Who won the 1989 Drum Corps International championships?", answer: "Santa Clara Vanguard", choice_one: "Blue Devils", choice_four: "The Academy", choice_three: "The Bluecoats", choice_two: "Santa Clara Vanguard"},
      %{category: "Music", points_worth: 50, question_text: "Which Death Grips album is the only one to feature a band member?", answer: "No Love Deep Web", choice_one: "Bottomless Pit", choice_four: "The Money Store", choice_three: "The Powers That B", choice_two: "No Love Deep Web"},
      %{category: "Music", points_worth: 50, question_text: "The key of sharps does the key of G# minor contain?", answer: "5", choice_one: "3", choice_four: "7", choice_three: "0", choice_two: "5"},
      %{category: "Music", points_worth: 60, question_text: "In Kendrick Lamar's 2012 album, 'Good Kid, M.A.A.D City', the album's story takes place in which city?", answer: "Compton", choice_one: "Detroit", choice_four: "New York", choice_three: "Baltimore", choice_two: "Compton"},
      %{category: "Music", points_worth: 60, question_text: "Which album was released by Kanye West in 2013?", answer: "Yeezus", choice_one: "My Beautiful Dark Twisted Fantasy", choice_four: "The Life of Pablo", choice_three: "Watch the Throne", choice_two: "Yeezus"},
      %{category: "Music", points_worth: 50, question_text: "What is the name of the song by Beyonc&eacute; and Alejandro Fern&aacute;ndez released in 2007?", answer: "Amor Gitano", choice_one: "La ultima vez", choice_two: "Rocket", choice_three: "Hasta Dondes Estes", choice_four: "Amor Gitano" },
      %{category: "Music", points_worth: 30, question_text: "Who wrote the song 'You Know You Like It'?", answer: "AlunaGeorge", choice_one: "DJ Snake", choice_two: "Steve Aoki", choice_three: "Major Lazer", choice_four: "AlunaGeorge"},
      %{category: "Music", points_worth: 60, question_text: "What is the first Studio Album to be released on the Internet with a 'Pay-What-You-Want' price?", answer: "In Rainbows", choice_one: "The Help Album", choice_two: "Skrillex and Diplo Present Jack &Uuml;", choice_three: "Blackstar", choice_four: "In Rainbows"},
      %{category: "Music", points_worth: 50, question_text: "What year was Min Yoongi from South Korea boy band 'BTS' born in?", answer: "1993", choice_one: "1992", choice_four: "1995", choice_two: "1994", choice_three: "1993"},
      %{category: "Music", points_worth: 60, question_text: "Who is a pioneer of 'Minimal Music' in 1960s?", answer: "Steve Reich", choice_one: "Wolfgang Amadeus Mozart", choice_four: "Brian Eno", choice_two: "Sigur R&oacute;s", choice_three: "Steve Reich"},
      %{category: "Music", points_worth: 30, question_text: "What was the name of the hip hop group Kanye West was a member of in the late 90s?", answer: "The Go-Getters", choice_one: "The Jumpers", choice_four: "The Kickstarters", choice_two: "The Beat-Busters", choice_three: "The Go-Getters"},
      %{category: "Music", points_worth: 60, question_text: "What was the name of the rock band that Nobuo Uematsu formed that played songs from various Final Fantasy games?", answer: "The Black Mages", choice_one: "The Final Fantasies", choice_two: "The Espers", choice_four: "The Rock Summoners", choice_three: "The Black Mages"},
      %{category: "Music", points_worth: 60, question_text: "Chino Moreno is the lead singer of which alternative metal band?", answer: "Deftones", choice_one: "Tool", choice_two: "Korn", choice_four: "Type O Negative", choice_three: "Deftones"},
      %{category: "Music", points_worth: 30, question_text: "Where was Nicki Minaj born?", answer: "Trinidad and Tobago", choice_one: "Haiti", choice_two: "Saint Lucia", choice_four: "Grenada", choice_three: "Trinidad and Tobago"},
      %{category: "Music", points_worth: 20, question_text: "When did the rapper Eazy-E die?", answer: "March 26, 1995", choice_one: "July 11, 1992", choice_two: "February 14, 1993", choice_three: "October 21, 1994", choice_four: "March 26, 1995"},
      %{category: "Music", points_worth: 60, question_text: "What year did Dire Straits's Song 'Money for Nothing' release?", answer: "1985", choice_one: "1973", choice_two: "1980", choice_three: "1991", choice_four: "1985"}
    ])
  end
end
