
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


