
function x=Cn(lamda, n, s, u)//lamda, n, servidores, u
    m = min(n,s);
    aux = 0:m;
    x = (lamda.^aux)./(factorial(aux).*(u.^aux))
    
    if(n>s) then
        aux2 = (s+1):n;
        p = (lamda^aux2)./(factorial(s).*(u^s).*((s*u).^(aux2-s)));
        x = [x,p]
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
    n = 0:length(cn)-1;
    z = (n-s).*pn;
endfunction


