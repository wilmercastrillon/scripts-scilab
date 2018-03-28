
function y=derivacionNumerica(p, valor, h)
    y = (horner(p,valor + h) - horner(p,valor))/h;
endfunction

function x=newtonRapson(p, xi, epsilon)
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


