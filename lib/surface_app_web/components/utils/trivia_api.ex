defmodule SurfaceAppWeb.Components.Utils.TriviaApi do
    alias SurfaceApp.Game.McCard

    def extract_question(json) do
        cat = json["category"]
        points_worth = 
            case json["difficulty"] do
                "easy" -> 10
                "medium" -> 30
                "hard" -> 50
            end
        question_text = json["question"]
        choice_one = Enum.at(json["incorrect_answers"], 0)
        big_list = json["incorrect_answers"] ++ json["incorrect_answers"] ++ json["incorrect_answers"] ++ json["incorrect_answers"] ++ json["incorrect_answers"] ++ json["incorrect_answers"] ++ json["incorrect_answers"] ++ json["incorrect_answers"]
        # Time the Enum.at
        {list_time, _func_result} = :timer.tc(&Enum.at/2, [big_list, 5])
        IO.inspect(list_time, label: "List Time")
        tuple = List.to_tuple(big_list)
        # Time Kernel.elem() access into a Tuple
        {tup_time, _func_result} = :timer.tc(&Kernel.elem/2, [tuple, 5])
        IO.inspect(tup_time, label: "Tup Time")
        choice_two = Enum.at(json["incorrect_answers"], 1)
        choice_three = Enum.at(json["incorrect_answers"], 2)
        choice_four = json["correct_answer"]
        answer = json["correct_answer"]

        question = %McCard{category: cat, points_worth: points_worth, question_text: question_text, choice_one: choice_one, choice_two: choice_two, choice_three: choice_three, choice_four: choice_four, answer: answer}
        IO.inspect(question)
    end

    def get_trivia do
        {:ok, finch_response} = Finch.build(:get, "https://opentdb.com/api.php?amount=10&category=21&difficulty=medium&type=multiple") |> Finch.request(SurfaceFinch)
        encoded = Jason.decode!(finch_response.body)
        results = encoded["results"]
        IO.inspect(results, label: "Results!!")
        Enum.map(results, fn item -> extract_question(item) end)
    end
end

"""
"results\":[{\"category\":\"Sports\",\"type\":\"multiple\",\"difficulty\":\"medium\",\"question\":\"Which of these teams isn&#039;t a member of the NHL&#039;s &quot;
Original Six&quot; era?\",\"correct_answer\":\"Philadelphia Flyers\",\"incorrect_answers\":[\"New York Rangers\",\"Toronto Maple Leafs\",\"Boston Bruins\"]},
{\"category\":\"Sports\",\"type\":\"multiple\",\"difficulty\":\"medium\",\"question\":\"Which soccer team won the Copa Am&eacute;rica 2015 Championship ?\",
\"correct_answer\":\"Chile\",\"incorrect_answers\":[\"Argentina\",\"Brazil\"
"""