-module(simpleArraySum).
-export([main/0]).

main() ->
        { ok, [N]} = io:fread("", "~d"),
         Summa =  summ_n_numbers_off_stdin(N,0),
        io:format("~p~n",[Summa]).                                                               
     summ_n_numbers_off_stdin(0,Summa) -> Summa;

     summ_n_numbers_off_stdin(N,Summa) -> 
       {ok, [X]} = io:fread("", "~d"),
          summ_n_numbers_off_stdin(N-1,Summa+X).
