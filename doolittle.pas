{
Nombre del programador: Umbral1013.
Fecha: 2024/08/30.
Nombre del programa: Doolittle.
Descripcion del programa: Factorizacion y solucion de matrices por el
  metodo de Doolittle.
}

program Doolittle;

type
  matriz = array [1..3] of array [1..3] of real;
  matriz2x2 = array [1..2] of array [1..2] of real;
  vector = array [1..3] of real;

// Paso por referencia se precede con var.
procedure inicializarMatriz(var unaMatriz: matriz);
var
  i, j: integer;
begin
  for i := Low(unaMatriz) to High(unaMatriz) do
    for j := Low(unaMatriz[i]) to High(unaMatriz[i]) do
      unaMatriz[i, j] := 0;
end;

procedure inicializarVector(var unVector: vector);
var
  i: integer;
begin
  for i := Low(unVector) to High(unVector) do
    unVector[i] := 0;
end;

procedure mostrarMatriz(unaMatriz: matriz);
var
  i, j: integer;
begin
  for i := Low(unaMatriz) to High(unaMatriz) do
  begin
    for j := Low(unaMatriz[i]) to High(unaMatriz[i]) do
      Write(unaMatriz[i, j]:8:2); // Ocho espacios, dos decimales.

    WriteLn();
  end;
  WriteLn();
end;

procedure mostrarVector(unVector: vector);
var
  i: integer;
begin
  for i := Low(unVector) to High(unVector) do
    WriteLn(unVector[i]:8:2);
end;

procedure mostrarMatrizVector(unaMatriz: matriz; unVector: vector);
var
  i, j: integer;
begin
  for i := Low(unaMatriz) to High(unaMatriz) do
  begin
    for j := Low(unaMatriz) to High(unaMatriz) do
      Write(unaMatriz[i, j]:8:2);

    WriteLn(' | ', unVector[i]:8:2);
  end;
  WriteLn();
end;

function factorizar(unaMatriz: matriz; var matrizL: matriz; var matrizU: matriz): boolean;
var
  i, j: integer;
  exito: boolean;
begin
  exito := true;

  // No podemos dividir entre cero.
  if unaMatriz[1, 1] = 0 then
  begin
    unaMatriz[1, 1] := 1;
    exito := false;
  end;

  // L es una matriz triangular inferior.
  for i := Low(matrizL) to High(matrizL) do
    for j := Low(matrizL[i]) to High(matrizL[i]) do
    begin
      if j > i then matrizL[i, j] := 0;
      if i = j then matrizL[i, j] := 1;
    end;

  matrizU[1, 1] := unaMatriz[1, 1];
  matrizU[1, 2] := unaMatriz[1, 2];
  matrizU[1, 3] := unaMatriz[1, 3];

  // U es una matriz triangular superior.
  for i := Low(matrizU) to High(matrizU) do
    for j := Low(matrizU[i]) to High(matrizU[i]) do
      if i > j then matrizU[i, j] := 0;

  matrizL[2, 1] := unaMatriz[2, 1] / unaMatriz[1, 1];
  matrizU[2, 2] := unaMatriz[2, 2] - (matrizL[2, 1] * unaMatriz[1, 2]);

  // Mismo caso que antes, no podemos dividir entre cero.
  if matrizU[2, 2] = 0 then
  begin
    matrizU[2, 2] := 1;
    exito := false;
  end;

  matrizL[3, 1] := unaMatriz[3, 1] / unaMatriz[1, 1];
  matrizL[3, 2] := (unaMatriz[3, 2] - (matrizL[3, 1] * unaMatriz[1, 2])) / matrizU[2, 2];

  matrizU[2, 3] := unaMatriz[2, 3] - (matrizL[2, 1] * unaMatriz[1, 3]);
  matrizU[3, 3] := unaMatriz[3, 3]
                     - (matrizL[3, 1] * unaMatriz[1, 3])
                     - (matrizL[3, 2] * matrizU[2, 3]);

  { No estoy seguro, pero creo que esto indica que tenemos soluciones
  infinitas.
  }
  if matrizU[1, 1] * matrizU[2, 2] * matrizU[3, 3] = 0 then
    exito := false;

  factorizar := exito;
end;

function cofactorPosicion(unaMatriz: matriz; pos_i, pos_j: integer): real;
var
  i, j, k, l: integer;
  signo: integer;
  detCof: real; // Determinante del cofactor.
  cof: matriz2x2; // Matriz reducida de cofactores.
begin
  // Conseguimos la matriz reducida de cofactores.
  k := Low(cof); l := Low(cof[k]);
  for i := Low(unaMatriz) to High(unaMatriz) do
    for j := Low(unaMatriz[i]) to High(unaMatriz[i]) do
    begin
      { Esta es la parte importante.
      cuando la entrada ij-esima de unaMatriz sea diferente
      de sus iteradores en este bucle, guardaremos su valor en
      la matriz de cofactores, y cambiaremos de columna.
      Cuando la fila este llena, cambiaremos de fila.
      }
      if (pos_i <> i) and (pos_j <> j) then
      begin
        cof[k, l] := unaMatriz[i, j];
        Inc(l);
      end;

      if l > High(cof[k]) then
      begin
        l := Low(cof[k]);
        Inc(k);
      end;
    end;

  detCof := cof[1, 1]*cof[2, 2] - cof[1, 2]*cof[2, 1];

  // El signo cambia si la suma de pos_i y pos_j es par o impar.
  if ((pos_i + pos_j) mod 2) <> 0 then signo := -1 else signo := 1;

  cofactorPosicion := signo * detCof;
end;

function determinanteMatriz(unaMatriz: matriz): real;
begin
  determinanteMatriz := unaMatriz[1, 1]*unaMatriz[2, 2]*unaMatriz[3, 3]
           + unaMatriz[2, 1]*unaMatriz[3, 2]*unaMatriz[1, 3]
           + unaMatriz[3, 1]*unaMatriz[1, 2]*unaMatriz[2, 3]
           -1 * (unaMatriz[1, 3]*unaMatriz[2, 2]*unaMatriz[3, 1]
                  + unaMatriz[2, 3]*unaMatriz[3, 2]*unaMatriz[1, 1]
                  + unaMatriz[3, 3]*unaMatriz[2, 1]*unaMatriz[1, 2]);
end;

function matrizInversa(unaMatriz: matriz): matriz;
var
  i, j: integer;
  det: real; // Determinante de toda la matriz.
  adjunta, resultado: matriz; // Matriz adjunta.
begin
  inicializarMatriz(adjunta);

  det := determinanteMatriz(unaMatriz);

  for i := Low(adjunta) to High(adjunta) do
    for j := Low(adjunta[i]) to High(adjunta[i]) do
    begin
      { Para conseguir la matriz adjunta, se tiene que transponer la matriz de
      cofactores.
      }
      adjunta[j, i] := cofactorPosicion(unaMatriz, i, j);
    end;

  for i := Low(resultado) to High(resultado) do
    for j := Low(resultado[i]) to High(resultado[i]) do
      resultado[i, j] := (1/det) * adjunta[i, j];

  matrizInversa := resultado;
end;

function solucion(inversaL, inversaU: matriz; vectorB: vector; var vectorC: vector): vector;
var
  i, j: integer;
  vectorX: vector;
begin
  inicializarVector(vectorX);

  // Encontramos el vector c.
  for i := Low(inversaL) to High(inversaL) do
    for j := Low(inversaL[i]) to High(inversaL[i]) do
    begin
      vectorC[i] := vectorC[i] + inversaL[i, j]*vectorB[j];
    end;

  // Encontramos el vector x.
  for i := Low(inversaU) to High(inversaU) do
    for j := Low(inversaU[i]) to High(inversaU[i]) do
      vectorX[i] := vectorX[i] + inversaU[i, j]*vectorC[j];

  solucion := vectorX;
end;

function multiplicarMatrices(unaMatriz, otraMatriz: matriz): matriz;
var
  i, j, k: integer;
  suma: real;
  producto: matriz;
begin
  inicializarMatriz(producto);

  // Via: https://en.wikipedia.org/wiki/Matrix_multiplication_algorithm
  for i := Low(unaMatriz) to High(unaMatriz) do
    for j := Low(otraMatriz[i]) to High(otraMatriz[i]) do
    begin
      suma := 0;
      for k := Low(unaMatriz[i]) to High(unaMatriz[i]) do
        suma := suma + unaMatriz[i, k]*otraMatriz[k, j];

      producto[i, j] := suma;
    end;

  multiplicarMatrices := producto;
end;

procedure llenarMatriz(var unaMatriz: matriz);
var
  i, j: integer;
  entrada: string;
begin
  for i := Low(unaMatriz) to High(unaMatriz) do
    for j := Low(unaMatriz[i]) to High(unaMatriz[i]) do
    begin
      Write('>> Teclea la posicion (', i, ', ', j,  '): ');
      ReadLn(entrada);
      Val(entrada, unaMatriz[i, j]);
    end;
end;

procedure llenarVector(var unVector: vector);
var
  i: integer;
  entrada: string;
begin
  for i := Low(unVector) to High(unVector) do begin
    Write('>> Teclea la posicion (', i, '): ');
    ReadLn(entrada);
    Val(entrada, unVector[i]);
  end;
end;

procedure cambiarColumnasMatriz(var unaMatriz: matriz; unVector: vector; j: integer);
var
  i, n: integer;
  aux: real;
begin
  { Puede pasar que a_1,1 siga siendo cero; aun asi, ya no hay ningun
  movimiento que podamos hacer para remediarlo, y siendo asi, debemos
  salir.
  }
  i := Low(unaMatriz);
  if (unaMatriz[1, 1] <> 0) or (j > High(unaMatriz[i])) then exit;

  if j >= High(unaMatriz[i]) then n := Low(unaMatriz[i])
  else n := j + 1;

  // Cambiar la columna n por la columna n + 1.
  for i := Low(unaMatriz) to High(unaMatriz) do
  begin
    aux := unaMatriz[i, j];
    unaMatriz[i, j] := unaMatriz[i, n];
    unaMatriz[i, n] := aux;
  end;

  // Mostramos los cambios.
  WriteLn('(!): Se ha cambiado la columna ', j, ' por la columna ', n, '.');
  mostrarMatrizVector(unaMatriz, unVector);

  if unaMatriz[1, 1] = 0 then
    Inc(j);
    cambiarColumnasMatriz(unaMatriz, unVector, j);
end;

procedure cambiarFilasVector(var unVector: vector; i: integer);
var
  m: integer;
  aux: real;
begin
  if i = High(unVector) then m := Low(unVector)
  else m := i + 1;

  aux := unVector[i];
  unVector[i] := unVector[m];
  unVector[m] := aux;
end;

// Si quieres que funcione bien, debes llamarla con 1 como tercer parametro.
procedure cambiarFilasSistema(var unaMatriz: matriz; var unVector: vector; i: integer);
var
  m, j: integer;
  aux: real;
begin
  if (unaMatriz[1, 1] <> 0) or (i > High(unaMatriz)) then exit;

  if i = High(unaMatriz) then m := Low(unaMatriz)
  else m := i + 1;

  // Cambiar la fila i por la fila m (i+1).
  for j := Low(unaMatriz[i]) to High(unaMatriz[i]) do
  begin
    aux := unaMatriz[i, j];
    cambiarFilasVector(unVector, i);
    unaMatriz[i, j] := unaMatriz[m, j];
    unaMatriz[m, j] := aux;
  end;

  // Mostramos los cambios.
  WriteLn('(!): Se ha cambiado la fila ', i, ' por la fila ', m, '.');
  mostrarMatrizVector(unaMatriz, unVector);

  if unaMatriz[1, 1] = 0 then
    Inc(i);
    cambiarFilasSistema(unaMatriz, unVector, i);
end;

procedure programaPrincipal(var salir: boolean);
var
  a, l, u, invL, invU: matriz;
  b, c, x: vector;
  entradaUsuario: string;
begin
  salir := true;
  entradaUsuario := '';

  inicializarMatriz(a);
  inicializarMatriz(l);
  inicializarMatriz(u);
  inicializarMatriz(invL);
  inicializarMatriz(invU);
  inicializarVector(b);
  inicializarVector(c);
  inicializarVector(x);

  WriteLn();
  WriteLn('Bienvenido!, este programa soluciona sistemas de ecuaciones');
  WriteLn('por el metodo de Doolittle.');
  WriteLn('Este programa no puede trabajar con letras o expresiones!');
  WriteLn('=> p. ej: 2a, 3*15.');
  WriteLn();

  WriteLn('Primero, ingresa los valores de la matriz a.');
  llenarMatriz(a);
  WriteLn('A continuacion, ingresa los valores del vector b.');
  llenarVector(b);

  WriteLn();
  WriteLn('La matriz del sistema queda asi:');
  WriteLn('================================');
  mostrarMatrizVector(a, b);
  WriteLn('>> Presiona <enter> para ver los resultados.');
  ReadLn();

  // Tratamos de hacer que a_1,1 no sea 0.
  cambiarFilasSistema(a, b, Low(a));
  cambiarFilasSistema(a, b, Low(a));
  cambiarColumnasMatriz(a, b, Low(a));
  cambiarColumnasMatriz(a, b, Low(a));

  if factorizar(a, l, u) then
  begin
    a := multiplicarMatrices(l, u);
    invL := matrizInversa(l);
    invU := matrizInversa(u);
    x := solucion(invL, invU, b, c);

    WriteLn('Matriz L:');
    WriteLn('================================');
    mostrarMatriz(l);
    WriteLn('Matriz U:');
    WriteLn('================================');
    mostrarMatriz(u);

    WriteLn('Comprobamos que LU = A');
    WriteLn('================================');
    mostrarMatriz(a);
    WriteLn('>> Presiona <enter> para continuar.');
    ReadLn();

    WriteLn('Inversa de L:');
    WriteLn('================================');
    mostrarMatriz(invL);
    WriteLn('Inversa de U:');
    WriteLn('================================');
    mostrarMatriz(invU);
    WriteLn('>> Presiona <enter> para continuar.');
    ReadLn();

    WriteLn('Vector c = [L^(-1) * b]:');
    WriteLn('================================');
    mostrarVector(c);
    WriteLn('(:D) Vector x = [U^(-1) * c]:');
    WriteLn('================================');
    mostrarVector(x);
  end
  else
    WriteLn('(:/) El sistema no tiene solucion, o tiene soluciones infinitas.');

  Write('>> Quieres salir del programa? (S/n): ');
  ReadLn(entradaUsuario);
  if entradaUsuario = 'n' then
    salir := false;
end;

var
  salir: boolean;
begin { Main }
  salir := false;
  while not salir do
    programaPrincipal(salir);
end. { Main }
