function teoriaDeColas(lamda, s, u, n, pob, c)//n = capacidad del sistema, pob = poblacion
    if(c <> 0)
        if(s == 1)
            cn = CnServicioCambiante(lamda, u, c)
        else
            cn = CnServicioCambianteMS(lamda, s, u, c)
        end
    else
        if(n == %inf && pob == %inf)
            cn = Cn(lamda, s, u, n);
        else
            if(n <= s && pob == %inf)
                cn = Cn(lamda, s, u, n);
            else
                if(pob <> %inf)
                    cn = CnPoblacionFinita(lamda, s, u, n, pob);
                else
                    printf("Caso aun no definido\n");
                    return;
                end
            end
        end
    end
    
    pn = Pn(cn);
    printf("Eficiencia = %.7f\n", lamda/(s*u));
    printf("P0 = %.7f\n", P0(cn));
    l = sum(L(pn));
    printf("L = %.7f\n", l);
    vlq = Lq(pn, s);
    printf("Lq = %.7f\n", sum(vlq));
    printf("W = %.7f\n", l/lamda);
    printf("Wq = %.7f\n", sum(Wq(vlq,lamda)));
    printf("P{Wq > 0} = %.7f\n", 1-sum(pn(1:s)));
endfunction

function x=CnPoblacionFinita(lamda, s, u, N, pob)
    n = 0:s;
    x = (factorial(N)./(factorial(N-n).*factorial(n))).*((lamda/u).^n);
    epsilon = 1e-7;
    aux = s+1;
    
    while(%t)
        p = factorial(N)/(factorial(N-aux)*factorial(s)*(s^(aux-s)));
        p = p * ((lamda/u)^aux);
        aux = aux + 1;
        if(p < epsilon || aux > N)
            break;
        end
        x = [x,p];
        
        if(p == %nan || p == %inf || p == -%inf)
            x = [0];
            return;
        end
    end
endfunction

function x=CnServicioCambiante(lamda, u, c)//
    n = 0;
    x = [];
    epsilon = 1e-7;
    
    while(%t)
        p = ((lamda/u)^n)/(factorial(n)^c);
        if(p < epsilon)
            break;
        end
        x = [x,p];
        n = n + 1;
        
        if(p == %nan || p == %inf || p == -%inf)
            x = [0];
            return;
        end
    end
endfunction

function redesDeColas(lamdas, ss, us, p)//vector de lamdas, servidores y u, matriz de transicion
    lamdaT = sum(lamdas);
    
    for i=1:length(ss)
        lamdai = lamdas(i) + sum(p(:,i)'.*lamdas);
        printf("### Para sub-sistema %d\n", i);
        teoriaDeColas(lamdai, ss(i), us(i),%inf,%inf,0);
        printf("\n");
    end
endfunction

function x=CnServicioCambianteMS(lamda, s, u, c)
    n = 0:s;
    x = ((lamda/u).^n)./factorial(n);
    epsilon = 1e-7;
    aux = s + 1;
    
    while(%t)
        p = (lamda/u)^aux;
        p = p/(factorial(s)* ((factorial(aux)/factorial(s))^c)* (s^((1-c)*(aux-s))) );
        if(p < epsilon)
            break;
        end
        x = [x,p];
        n = n + 1;
        
        if(p == %nan || p == %inf || p == -%inf)
            x = [0];
            return;
        end
        aux = aux + 1;
    end
endfunction

function x=Cn(lamda, s, u, capacidad)//
    aux = 0:s;
    x = (lamda.^aux)./(factorial(aux).*(u.^aux))
    
    if(capacidad <= s)
        return;
    end
    n = s+1;
    epsilon = 1e-7;
    while(%t)
        p = (lamda^n)/(factorial(s).*(u^s).*((s*u)^(n-s)));
        if(p < epsilon)
            break;
        end
        x = [x,p];
        n = n + 1;
        
        if(p == %nan || p == %inf || p == -%inf)
            x = [0];
            return;
        end
    end
endfunction

function y=P0(cn)
    sumatoria = sum(cn);
    y = 1/(sumatoria);
endfunction

function z=Pn(cn)
    p0 = 1/sum(cn);
    z = p0.*cn;
endfunction

function z=L(pn)
    n = 0:length(pn)-1;
    z = pn.*n;
endfunction

function z=Lq(pn, s)
    ini = length(pn);
    pn = pn(s+1:length(pn));
    n = s:ini-1;
    z = (n-s).*pn;
endfunction

function z=Wq(lq, lamda)
    z = lq/lamda;
endfunction
