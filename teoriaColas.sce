
function x=cn(lamda, n, s, u)//lamda, n, servidores, u
    m = min(n,s);
    aux = 0:m;
    x = (lamda.^aux)./(factorial(aux).*(u.^aux))
    
    if(n>s) then
        aux2 = (s+1):n;
        p = (l^aux2)./(factorial(s).*(aux2^s).*((s*u).^(aux2-s)));
        x = [x,p]
    end
endfunction


