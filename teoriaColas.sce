function teoriaDeColas(lamda, s, u, n, pob)//n = capacidad del sistema, pob = poblacion
    c = [];
    if(n == %inf && pob == %inf)
        c = Cn(lamda, s, u, n);
    else if(n <= s && pob == %inf)
        c = Cn(lamda, s, u, n);
    else
        printf("Caso aun no definido\n");
        return;
    end
    end
    printf("Eficiencia = %.7f\n", lamda/(s*u));
    printf("P0 = %.7f\n", P0(c));
    l = sum(L(c));
    printf("L = %.7f\n", l);
    vlq = Lq(c, s);
    printf("Lq = %.7f\n", sum(vlq));
    printf("W = %.7f\n", l/lamda);
    printf("Wq = %.7f\n", sum(Wq(vlq,lamda)));
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
            x = [];
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

function z=L(cn)
    pn = Pn(cn);
    n = 0:length(cn)-1;
    z = pn.*n;
endfunction

function z=Lq(cn, s)
    pn = Pn(cn);
    pn = pn(s+1:length(pn));
    n = s:length(cn)-1;
    z = (n-s).*pn;
endfunction

function z=Wq(lq, lamda)
    z = lq/lamda;
endfunction
