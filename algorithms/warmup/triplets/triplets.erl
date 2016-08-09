-module(triplets).
-export([main/0]).

main() ->
    

    { ok, [A0,A1,A2]} = io:fread("", "~d~d~d"),
    { ok, [B0,B1,B2]} = io:fread("", "~d~d~d"),
        compare([A0,A1,A2],[B0,B1,B2],[0,0]).


compare([],[],[ScoreA,ScoreB]) -> io:format("~p ~p~n",[ScoreA,ScoreB]);

compare([HA|TA],[HB|TB],[ScoreA,ScoreB]) when HA > HB ->
    compare(TA,TB,[ScoreA+1,ScoreB]);

compare([HA|TA],[HB|TB],[ScoreA,ScoreB]) when HA < HB -> 
    compare(TA,TB,[ScoreA,ScoreB+1]);

compare([HA|TA],[HB|TB],[ScoreA,ScoreB]) when HA =:= HB -> 
    compare(TA,TB,[ScoreA,ScoreB]).

