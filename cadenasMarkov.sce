
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


