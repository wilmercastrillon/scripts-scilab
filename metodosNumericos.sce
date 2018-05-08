
function y=derivacionNumerica(p, valor, h)
    y = (horner(p,valor + h) - horner(p,valor))/h;
endfunction

function x=newtonRapson(p, xi, epsilon)//polinomio, xi inicial, epsilon opcional
    printf('### Newton Rapson:\n');
    if (exists("epsilon") == 0)
        epsilon = 1e-7;
    end
    con = 0;
    h = 0.00001;
    while(abs(horner(p, xi)) > epsilon)
        con = con + 1;
        fx = horner(p, xi);
        fpx = derivacionNumerica(p,xi,h);
        xi2 = xi - (fx / fpx);
        printf('iteraccion = %d | xi = %.7f | f(xi) = %.7f | xi+1 = %.7f | f,(xi + 1) = %.7f |error = %.7f\n',con, xi, fx, xi2, fpx, (xi2 - xi) / xi2);
        xi = xi2;
    end
    x = xi;
endfunction

function z=diferenciasDivididasNewton(x,y)//coordenadas en x, coordenadas en y
    printf("### Diferencias divididas de newton:\n");
    s = length(x);
    dif = zeros(1,s);
    aux2 = y;
    con = 1;
    
    for i=1:s-1
        aux = aux2;
        aux2 = zeros(1,length(aux)-1);
        dif(i) = aux(1);
        
        for j=1:length(aux2)
            
            aux2(j) = (aux(j+1) - aux(j))/(x(j+con) - x(j));
        end
        printf("\n%d° diferencia dividida:\n", con);
        disp(aux2');
        con = con+1;
    end
    
    dif(s) = aux2(1);
    printf("\nVector b:\n");
    disp(dif);
    
    printf("\nPolinomios:\n");//pn
    polis = [];
    pn = poly([0],'x','c');//0
    for i=1:s
        //printf("-------------------------\n");
        p1 = poly([dif(i)], 'x', 'c');
        p2 = poly([0,1],'x','c');//x
        p3 = poly([1],'x','c');//1
        for j=2:i
            //disp(p2 - x(j-1));
            p3 = p3 * (p2 - x(j-1));
        end
        printf("grado %d\n", i-1);
        disp(p1*p3);
        polis = [polis,p1*p3];
        pn = pn + (p1*p3);
    end
    printf("total polinomios:\n");
    disp(polis);
    printf("\nPolinomio interpolador:\n");
    disp(pn);
    z=pn;
endfunction

function cf = polyfit(x,y,n)//fuente san google
    if (exists("n") == 0)
        n = 1;
    end
    A = ones(length(x),n+1)
    for i=1:n
        A(:,i+1) = x(:).^i
    end
    l = lsq(A,y(:))
    p = poly(l', 'x', 'coeff');
    cf = p
endfunction

function xy=minimosCuadrados(x, y, g)//proceso paso a paso
    if (exists("g") == 0)
        g = 1;
    end
    printf("### Regresion por minimos cuadrados, grado %d\n", g);
    aux = g*2;
    aux2 = g + 1;
    s = aux+1;
    A = zeros(aux2, aux2);
    B = zeros(aux2, 1);
    sumatoria = 1:s;
    sumatoria(1) = length(x);
    for i=2:s
        sumatoria(i) = sum(x^(i-1));
    end
    
    for i=1:aux2
        aux3 = i;
        for j=1:aux2
            A(i,j) = sumatoria(aux3);
            aux3 = aux3 + 1;
        end
        B(i,1) = sum(y.*(x^(i-1)));
    end
    
    printf("Sistema a solucionar\n");
    printf("A:\n");
    disp(A);
    printf("B\n");
    disp(B);
    printf("Solucion del sistema:\n");
    X = (A^-1)*B;
    disp(X);
    
    printf("Polinomio:");
    p = poly(X'(1,:) , 'x', 'coeff');
    disp(p);
    xy = p;
endfunction


