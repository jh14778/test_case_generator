% test(L,state(C,S),X).
%
% L is the length of X.
% C is 0 or 1, if connected.
% S is the set of topics which the application is subscribed to.
% X is a sequence of state transitions.
test(0, state(0, []), []).
test(L, state(0, []), [connect       |Tail]) :- dec(L, L1),                                           test(L1, state(1, []), Tail).
test(L, state(1, []), [disconnect    |Tail]) :- dec(L, L1),                                           test(L1, state(0, []), Tail).
test(L, state(1,  S), [subscribe(T,Q)|Tail]) :- dec(L, L1), qos(Q), topic(sub, T), union(S, [T], S1), test(L1, state(1, S1), Tail).
test(L, state(1,  S), [unsubscribe(T)|Tail]) :- dec(L, L1), member(T, S), subtract(S, [T], S1),       test(L1, state(1, S1), Tail).
test(L, state(1,  S), [recieve(M,T)  |Tail]) :- dec(L, L1), message(M), member(T, S),                 test(L1, state(1,  S), Tail).
test(L, state(1,  S), [publish(M,T,Q)|Tail]) :- dec(L, L1), qos(Q), message(M), topic(pub, T),        test(L1, state(1,  S), Tail).

topic(sub, '"test_topic/subs1"').
topic(sub, '"test_topic/subs2"').
topic(pub, '"test_topic/pubs"').

message('"test_message_1"').

qos(qos1).
qos(qos2).
qos(qos3).

dec(A, B) :- A > 0, B is A - 1.
