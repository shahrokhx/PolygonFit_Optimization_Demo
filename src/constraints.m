function [c,ceq] = constraints(x)
    n=length(x)/2;
    c=[];
    ceq = zeros(n,1);  
    coordinates = reshape(x,n,2);
    for i = 1 : n
       ceq(i) = ellipse_equation(coordinates(i,1),coordinates(i,2));
    end
end