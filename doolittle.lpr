{ Nombre del programador: Umbral1013.
Fecha: 2025/10/19.
Nombre del programa: Doolittle (revisión).
Descripcion del programa: Factorizacion y solucion de matrices por el
  metodo de Doolittle.

NOTAS:
  - Seniores, lo logramos! La primera version estable se termino el 31/08/2024
  a las 1:46 a.m.
  - Falta hacer comprobaciones y reducir la complejidad de esta cosa. Tengo la
  impresion de que es demasiado grande para lo que hace.
  - A 31/08/2024 12:13 p.m. Debo decir que ya funciona como deberia, pero no me
  convence. Quiza seria bueno dejarlo asi, por lo sano.
  - A 01/09/2024, 20:05:06, puedo confirmar que si ingresas letras ya no truena.
  - Esta revisión (2025/10/20) se hizo para ver qué tanto he avanzado.
  La verdad: no mucho.
}

program doolittle;

uses
  SysUtils;

const
  N = 3;

type
  TMatriz = array [1..N] of array [1..N] of double;
  TMatriz2x2 = array [1..2] of array [1..2] of double;
  TVector = array [1..N] of double;

  procedure iniciarL(var L: TMatriz);
  { Inicializa la matriz triangular inferior. }
  var
    i, j: integer;
  begin
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        if i = j then L[i, j] := 1
        else
          L[i, j] := 0;
      end;
    end;
  end;

  procedure mostrarSistema(A: TMatriz; B: TVector);
  { Imprime el sistema de ecuaciones en la salida estándar de la consola
  usando un bonito formato. }
  var
    i, j: integer;
  begin
    WriteLn('Mostrando el sistema de ecuaciones.');
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        Write(A[i, j]: 8: 3, ' ');
      end;
      WriteLn(' | ', B[i]: 8: 3);
    end;
  end;

  procedure reducirFila(var A: TVector; B: TVector; k: double);
  { Recibe dos filas: Una, la fila que debe reducirse, y la otra es la fila que
  será multiplicada por el coeficiente k para reducir las posiciones pertinentes
  de la primera a cero. }
  var
    i: integer;
  begin
    for i := 1 to N do
    begin
      A[i] := A[i] - k * B[i];
    end;
  end;

  procedure factorizar(A: TMatriz; var L, U: TMatriz);
  { Dada una matriz A, obtiene dos matrices, L y U, tales que al multiplicarse
  entre sí se obtiene la matriz original. Produce un valor de retorno, que
  corresponde al exito de la operacion. }
  var
    i, iPivote, j, k: integer;
    eliminar, pivote: double;
  begin
    // Inicialización de variables.
    k := 0;
    pivote := 0;
    iPivote := 0;
    eliminar := 0;
    iniciarL(L);
    U := A;

    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        // Reducción de filas, por columnas.
        k := i;
        while (i > j) and (U[k, j] <> 0) and (k <= N) do
        begin
          eliminar := U[k, j] / pivote;
          reducirFila(U[k], U[iPivote], eliminar);
          L[k, j] := eliminar;
          Inc(k);
        end;
        // Conseguimos el pivote y la fila en la que está ubicado.
        if (i = j) and (U[i, j] <> 0) then
        begin
          pivote := U[i, j];
          iPivote := i;
        end
        else
          break;
      end;
    end;
  end;

  function determinante(U: TMatriz): double;
  { Recibe una matriz diagonal superior, resultado de la factorización de la
  matriz con los coeficientes del sistema de ecuaciones.
  También puede recibir una matriz diagonal inferior, solo que esto no obtendrá
  el determinante de la matriz original, sino solo el de la matriz L.}
  var
    det: double;
    i, j: integer;
  begin
    det := 1;
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        if i = j then det := det * U[i, j];
      end;
    end;
    Result := det;
  end;

  function determinante2x2(A: TMatriz2x2): double;
    { Manera sencilla de calcular el determinante de una matriz cuadrada 2*2. }
  begin
    Result := A[1, 1] * A[2, 2] - A[1, 2] * A[2, 1];
  end;

  function submatriz(A: TMatriz; fila, col: integer): TMatriz2x2;
  { Genera matrices de 2*2, adecuadas para la obtención de una matriz de
  cofactores (o adjunta). Es una de las pocas cosas que no escalaría bien.
  Recibe la matriz, la fila, y la columna en la que está el elemento del que
  queremos obtener el cofactor.
  }
  var
    submatriz_: TMatriz2x2;
    i, j, iSub, jSub: integer;
  begin
    iSub := 1;
    jSub := 1;
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        if (i <> fila) and (j <> col) then
        begin
          // Ajustamos los índices para evitar escribir en espacios
          // de memoria que no deberíamos. Solución fea.
          if jSub > High(submatriz_[iSub]) then
          begin
            jSub := 1;
            Inc(iSub);
          end;
          submatriz_[iSub, jSub] := A[i, j];
          Inc(jSub);
        end;
      end;
    end;
    Result := submatriz_;
  end;

  function matrizTranspuesta(A: TMatriz): TMatriz;
    { Toma una matriz y da como resultado la transpuesta de esta matriz. }
  var
    transpuesta: TMatriz;
    i, j: integer;
  begin
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        // Transponer es solamente cambiar las filas por columnas.
        transpuesta[i, j] := A[j, i];
      end;
    end;
    Result := transpuesta;
  end;

  function matrizAdjunta(A: TMatriz): TMatriz;
  { Matriz adjunta (o de cofactores). Toma una matriz, y devuelve la matriz de
  cofactores. Sirve para invertir una matriz. }
  var
    cofactores: TMatriz;
    submatriz_: TMatriz2x2;
    i, j, signo: integer;
  begin
    signo := -1;
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        signo := signo * -1;
        submatriz_ := submatriz(A, i, j);
        cofactores[i, j] := signo * determinante2x2(submatriz_);
      end;
    end;
    Result := cofactores;
  end;

  function matrizInversa(A: TMatriz; determinante: double): TMatriz;
  { Toma una matriz y su determinante (debemos calcularlo de antemano).
  Asegúrate de no ejecutar esto a menos que el determinante no sea cero.
  Regresa la matriz inversa de A. }
  var
    inversa: TMatriz;
    i, j: integer;
  begin
    inversa := matrizAdjunta(A);
    inversa := matrizTranspuesta(inversa);
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        inversa[i, j] := 1 / determinante * inversa[i, j];
      end;
    end;
    Result := inversa;
  end;

  procedure pedirDatos(var x: double; msg: string);
  { Le solicita los datos al usuario, asegurándonos de que lo ingresado son
  números. }
  var
    entrada: string;
  begin
    Write('>> ', msg);
    ReadLn(entrada);
    Val(entrada, x);
  end;

  procedure llenarSistema(var A: TMatriz; var b: TVector);
  { Llena el sistema de ecuaciones con la entrada del usuario, línea por línea. }
  var
    i, j: integer;
  begin
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        pedirDatos(a[i, j], Format('(Matriz) - Posicion [%d, %d]: ', [i, j]));
      end;
      pedirDatos(b[i], Format('(Vector) - Posicion [%d]: ', [i]));
    end;
  end;

  function productoMatriz(A, B: TMatriz): TMatriz;
    { Multiplica dos matrices, y da como resultado una tercera matriz. }
  var
    i, j, k: integer;
    suma: real;
    producto: TMatriz;
  begin
    // Via: https://en.wikipedia.org/wiki/Matrix_multiplication_algorithm
    for i := 1 to N do
      for j := 1 to N do
      begin
        suma := 0;
        for k := 1 to N do
          suma := suma + A[i, k] * B[k, j];

        producto[i, j] := suma;
      end;

    Result := producto;
  end;

  procedure inicializarVector(var b: TVector);
  { Inicializa el vector en ceros. }
  var
    i: integer;
  begin
    for i := 1 to N do
      b[i] := 0;
  end;

  function solucion(var c: TVector; invL, invU: TMatriz; b: TVector): TVector;
    { Soluciona el sistema de ecuaciones propuesto. }
  var
    i, j: integer;
    x: TVector;
  begin
    // Computamos el vector c.
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        c[i] := c[i] + invL[i, j] * b[j];
      end;
    end;

    // Computamos el vector x.
    inicializarVector(x);
    for i := 1 to N do
    begin
      for j := 1 to N do
      begin
        x[i] := x[i] + invU[i, j] * c[j];
      end;
    end;
    Result := x;
  end;

  procedure principal(var salir: boolean);
  { Ejecuta el programa principal, el cual se encarga de solicitarle los datos
  al usuario para llenar el sistema de ecuaciones (representado como un arreglo
  y un vector), y realizar los procesos necesarios para resolverlo, o decir que
  no se puede resolver. }
  var
    A, L, U, invL, invU: TMatriz;
    b, c, x: TVector;
    determinante_, determinanteL: double;
    respuesta: string;
  begin
    llenarSistema(A, b);
    mostrarSistema(A, b);
    factorizar(A, L, U);
    determinante_ := determinante(U);

    if determinante_ <> 0 then
    begin
      // El sistema tiene una solución posible.
      A := productoMatriz(L, U);
      determinanteL := determinante(L);
      invL := matrizInversa(L, determinanteL);
      invU := matrizInversa(U, determinante_);
      x := solucion(c, invL, invU, b);
      WriteLn('Comprobamos que LU = A.');
      WriteLn('A | x (solución)');
      mostrarSistema(A, x);
    end
    else
    begin
      // El sistema no tiene solución.
      WriteLn('El sistema no tiene solución, o tiene soluciones infinitas.');
    end;

    Write('>> ¿Quieres salir del programa? (s/N): ');
    ReadLn(respuesta);
    if respuesta = 's' then salir := True;
  end;

var
  salir: boolean;
begin { Main }
  salir := False;
  WriteLn('Doolittle, versión 2.0');
  WriteLn('Este programa soluciona sistemas de ecuaciones. Bienvenido.');
  while not salir do principal(salir);
  WriteLn('¡Hasta pronto!');
end. { Main }
