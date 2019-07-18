defmodule WakandaBot.Bot do
  @bot :wakanda_bot

  use ExGram.Bot,
    name: @bot

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Well hello! This bot can show you your Wakanda name.\nHow to use? /name myname")
  end

  def handle({:command, "help", _msg}, context) do
    answer(context, "How to use?\n/name myname\nNOTE: you cant send a message with more than 500 characters.")
  end
  
  def handle({:command, "name", msg}, context) do
    if String.length(msg.text) > 500 do
      answer(context, "That message was too long, please try to not use more than 500 characters.")
    else
      if msg.text == "" do
	answer(context, "You have to follow the command by your name (/name myname).")
      else
	  alphabet = %{'a' => "ka", 'b' => "zu", 'c' => "mi", 'd' => "te", 'e' => "ku",
		       'f' => "lu", 'g' => "ji", 'h' => "ri", 'i' => "ki", 'j' => "zu",
		       'k' => "me", 'l' => "ta", 'm' => "rim", 'n' => "to", 'o' => "mo",
		       'p' => "no", 'q' => "ke", 'r' => "shi", 's' => "ari", 't' => "chi",
		       'u' => "do", 'v' => "ru", 'w' => "mei", 'x' => "na", 'y' => "fu",
		       'z' => "z"}
	  wakname = wakandan(String.to_charlist(String.downcase(msg.text)), "", alphabet)
	  answer(context, String.capitalize(wakname))
      end
    end
  end

  def wakandan([], wakname, _), do: wakname
  
  def wakandan(name, wakname, alphabet) do
    [head | tail] = name
    if Map.has_key?(alphabet, [head]) do
      wakandan(tail, wakname <> alphabet[[head]], alphabet)
    else
      wakandan(tail, wakname <> List.to_string([head]), alphabet)
    end  
  end
  
  def handle({:command, _command, _msg}, context) do
    answer(context, "Please, use the correct command /name.")
  end

  def handle({:text, _, _msg}, context) do
    answer(context, "You must use the command /name followed by your name.")
  end

end
