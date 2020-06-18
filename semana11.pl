%metodo para aplanar una lista
aplanar([],[]).
aplanar([H|T], [H|Tflat]):-
    not(is_list(H)),
    aplanar(T,Tflat).
aplanar([H|T], Res):-
    aplanar(H,Hflat)
    aplanar(T,Tflat)
    append(Hflat, Tflat,Res).


%grafo
% se declara conectado dinamico
:-  dynamic conectado/2.
conectado(i,a,20).
conectado(i,b,10).
conectado(a,i,20).
conectado(a,c,4).
conectado(a,d,7).
conectado(b,i,10).
conectado(b,c,2).
conectado(b,d,5).
conectado(c,a,4).
conectado(c,b,2).
conectado(c,x,10).
conectado(d,a,7).
conectado(d,b,5).
conectado(d,f,10).
conectado(x,c,10).
conectado(f,d,10).


% Sumar los valores de una lista
sumar_lista([], 0).
sumar_lista([Cabeza|Cola], Suma):-
          sumar_lista(Cola, Valor),
          Suma is Valor + Cabeza.

% Para encontrar todas las rutas
% findall([X,Lista_Distancia],ruta(i,c,Ruta,Lista_Distancia),Resultados).

ruta(Ini,Fin, Res, Suma):- ruta_temp(Ini,Fin,[],Res,[],Suma, 0).
ruta_temp(Fin,Fin,Lista,Res,Lista2,Suma,Total):-
    reverse([Fin|Lista],Res),
    reverse(Lista2, Suma).
    %sumar_lista(Lista2, Suma),
    %write(Suma),
   % write(" = "),
    %write( Total ),nl.
ruta_temp(Ini, Fin, Vecinos, Res,ListaPeso, Sum, Total) :-
    conectado(Ini,Vecino,Distancia),
    not(member(Vecino, Vecinos)),
    Suma is Total  + Distancia,
    ruta_temp(Vecino,Fin, [Ini|Vecinos], Res,[Distancia|ListaPeso], Sum, Suma).

%Para obtener el segundo valor de una lista
segundo_elemento([_|X], X).

%Para obtener el primer valor de una lista
primer_elemento([X|_],X).

menor(Lista, Menor) :-
      select(Menor, Lista, Rest), \+ (member(E, Rest), E < Menor).


recorrer_lista([],Lista,_) :-
    menor(Lista, Maximo),
    write("La distancia mas cercana es: "),
    write(Maximo).
recorrer_lista([X|Xs],Lista,Rutas):-
    segundo_elemento(X,C),
    primer_elemento(X,E),
    primer_elemento(C,D),
    write(E),
    write(" = "),
    write(D),
    write(" = "),
    sumar_lista(D,Total),
    write(Total),nl,
    recorrer_lista(Xs,[Total|Lista],[E|Rutas]).


ruta_corta(Inicio, Final) :-
    findall([X,Peso],ruta(Inicio,Final,X,Peso),Resultados),
    recorrer_lista(Resultados,[],[]).


% Para ver los datos
% listing(conectado).
%
% Para agregar valores cuando es dinamico
%   assert(conectado(x,d)).
%
% Para eliminar 1 conocimiento
% retract(conectado(i,c)).
%
% Para eliminar todas las ocurrencias
% retractall(conectado(_,_)).



% Ejercicios
% 1) Poner peso y devolver la suma de los pesos de la ruta
% ruta(i,c,Ruta, Lista_Distancia).


% 2) Hacer laberinto y montarlo en un grafo y imprimir la solucion y
% cuando se encuentra la solucion, mostrarla ya que es solo una
%
% 3) Averiguar la ruta mas
% corta con : findall([X,Peso],ruta(i,c,X,Peso),Resultados)




