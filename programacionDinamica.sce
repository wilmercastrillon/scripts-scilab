
//tabla t con las etapas
//operacion, '+' suma, '*' multiplicar
//objetivo, 'min' minimizar, 'max' maximizar
//por defecto toma op = '+', ob = 'max'
function z = programacionDinamica(t, op, ob)
    if(exists('op') == 0)
        op = '+';
        ob = 'max';
    end
    if(exists('ob') == 0)
        ob = 'max';
    end
    
    l = size(t);
    n = l(1) - 1;
    etapas = l(2);
    
    if(op == '*')
        f = ones(n+1,1);
    else
        f = zeros(n+1,1);
    end
    for i=etapas:-1:1
        printf("\n---Etapa N°%d\n", i);
        f2 = etapa(t(:,i),f, op, ob);
        printf("f* , x* optimos:\n");
        disp(f2);
        f = f2(:,1);
    end
    
    if(ob == 'min')
        z = min(f);
    else
        z = max(f);
    end
endfunction

//columna de la tabla t, f optimo anterior etapa, operacion, objetivo
function zz = etapa(t, fAnt, op, ob)
    n = size(t)(1);
    f = zeros(n,1);
    x = zeros(n,1);
    m = zeros(n,n);
    
    if(ob == 'min')
        cmp = %inf;
    else
        cmp = -%inf;
    end
    
    for i=1:n
        valor = cmp;
        index = 0;
        for j=1:i
            if(op == '*')
                m(i,j) = fAnt(i-(j-1),1) * t(j,1)
            else
                m(i,j) = fAnt(i-(j-1),1) + t(j,1)
            end
            
            if((ob == 'min' && m(i,j) < valor) || (ob == 'max' && m(i,j) > valor) )
                valor = m(i,j);
                index = j;
            end
        end
        x(i) = index-1;
        f(i) = valor;
    end
    disp(m)
    zz = [f,x];
endfunction


