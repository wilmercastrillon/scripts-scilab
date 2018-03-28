
function x=probabilidadEstadoEstable(m)
    s = size(m)(1);
    printf("### Probabilidades de estado estable\n\n");
    a = m';
    b = 1:s;
    
    for i = 1:s-1
        a(i,i) = a(i,i)-1;
        a(s,i) = 1
        b(i) = 0
    end
    a(s,s) = 1;
    b(s) = 1;
    b = b';
    printf("Sistema a solucionar:\nMatriz A\n");
    disp(a)
    printf("Matriz B:\n");
    disp(b)
    
    x = (a^-1)*b
    //printf("solucion del sistema:\n");
endfunction

function y=primerPasaje(p)
    s = size(p)(1);
    x = probabilidadEstadoEstable(p); b = 1:s*(s-1);
    printf("\n### Tiempos de primer pasaje\n\n");
    m = zeros(s*(s-1),s*(s-1));
    ind = zeros(s,s);
    con = 1; con2 = 0;
    for i =1:s
        for j=1:s
            if(i == j) continue;
            end 
            ind(i,j) = con;
            b(con) = 1;
            con = con+1;
        end
    end
    
    for i=1:s
        for j=1:s
            if(i == j)
                continue;
            end
            con2 = con2 + 1;
            
            for k=1:s
                if(k == j) continue;
                end
                m(con2,ind(k,j)) = p(i,k)*-1;
                if(con2 == ind(k,j)) m(con2,con2) = m(con2,con2)+1;
                end
            end
        end
    end
    
    printf("Sistema a solucionar (omitiendo cuando i=j):\n");
    disp(m)
    disp(b')
    
    y = (m^-1)*b';
    con2 = 0;
    printf("\nsolucion completa del sistema:\n");
    for i=1:s
        for j=1:s
            if(i == j)
                printf("M%d%d = %.8f\n", i,i, 1/x(i,1));
            else 
                con2 = con2 + 1;
                printf("M%d%d = %.8f\n", i,j, y(con2,1));
            end
        end
    end
endfunction

function z=simplex(p)
    z = p;
    s = size(p);//s(0) = filas; s(1) = columnas;
    con = 0;
    
    while (%t)
        con = con + 1;
        fin = %t;
        for i = 2:s(1)
            if (z(1,i) < 0)
                fin = %f;
                break;
            end
        end
        if(con > 50 || fin == %t)
            break;
        end
        
        printf("----------------iteraccion: %d------------------------\n", con);
        columna = -1;
        fila = -1;
        menor = %inf; //disp(z(1,:))
        for j=2:s(2)-1
            //printf("probamos %d\n", z(1,j));
            if (menor > z(1,j))
                menor = z(1,j);
                columna = j;
                //printf("menor col = %d , j = %d\n", columna, j);
            end
        end
        printf("pivote que entra: columna %d\n", columna);

        menor = %inf;
        for i=2:s(1)
            aux2 = z(i,s(2)) / z(i,columna);
            if (aux2 < menor && aux2 >= 0 && z(i, columna) <> 0 && aux2 <> 0)
                menor = aux2;
                fila = i;
            end
        end
        printf("pivote que sale: fila %d\n", fila);

        if(z(fila,columna) <> 1)
            z(fila,:) = z(fila,:)/z(fila,columna);
        end
        for i=1:s(1)
            if(i <> fila)
                z(i,:) = z(i,:) + z(fila,:)*z(i,columna)*-1;
            end
        end
        disp(z)
    end
    
    if(con > 50)
        printf("Demasiadas iteracciones!!!\n");
    end
endfunction


