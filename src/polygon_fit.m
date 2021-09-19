%%                        Optimization Package
%                  Fitting a polygon inside an ellipse
%  _______________________________________________________________________
%                            Developed by
%                           SHAHROKH SHAHI
%  -----------------------------------------------------------------------
%  Homepage: www.sshahi.com
%  Email: shahi@gatech.edu
%  _______________________________________________________________________

function [coordinates,max_area,lambda_nl] = polygon_fit(f,n)
    %% Initialization

    warning('off','all')
    format short g
    format
    
    %% Symbolic Operations
    x=sym('x',[1,n]);
    y=sym('y',[1,n]);
    coords = [x;y];
    coords = [coords,coords(:,1)];
    s = 0;
    
    for i = 1 : n
        sub_coords=coords(:,i:i+1);
        s=s+det(sub_coords);
    end
    area = (s)/2;
    disp('---------------------------------------------------------------')
    disp('The Symbolic Objective Function, AREA = ');
    pretty(area)

    % The function to minimize
    area_min = -area;
    
    % Displaying Constraints
    disp('Equality Constraints:');
    g = sym('g',[1,n]);
    for i = 1:n
        g(i) = subs(f   ,'x',x(i));
        g(i) = subs(g(i),'y',y(i));
        disp(['g(',num2str(i),')=']);
        disp(g(i))
    end

    %% Numerical Solution
    objective_generator(area_min,2*n);
    options = optimoptions(@fmincon,'Display','off');

    x0 = zeros(1,2*n);

    need_search = true;
    clear x y;
    syms x y real

%   y_explicit = solve(f,'y');
    y_explicit = solve(f,y);
    y_function = inline(y_explicit(1));
%   max_x = solve(subs(f,'y',0),'x');
    max_x = solve(subs(f,y,0),x);
    max_x = double(abs(max_x(1)));
    try_counter = 0;
    while (need_search)
        x0(1:n) = rand(1,n)*max_x;
        x0(n+1:2*n)= abs(y_function(x0(1:n)));
        for i = 1 : 2*n     
            x0(i)=x0(i)*(-1)^n;
        end
        x0;
        lambda = [];
        [X,FVAL,EXITFLAG,output,lambda] = fmincon(@objective_function,x0,...
                                [],[],[],[],[],[],@constraints,options);
        coordinates = reshape(X,n,2);
        max_area = abs(FVAL);
        % Searching for valid solutions:
        need_search = false;
        for i = 1 : n
            for j = 1 : n
                if (i~=j) & distance(coordinates(i,:),coordinates(j,:))<1e-3
                    need_search = true;
                    break;
                end
            end
        end
        
        try_counter = try_counter + 1;
        if try_counter > 10
            clear
            coordinates = [];
            max_area = 0;
            break;
        end
    end
    lambda_nl = lambda.eqnonlin;
%     disp('Lagrange Multipliers:')
%     disp(lambda_nl)


    %% Plotting
%     syms x y;
%     f1 = f;
%    
%     figure(2);
%     
%     cla;
% %     axis equal;
% %     axis([-max_x max_x -max_x max_x]);
%     hold on;
%     grid on;
%     h0=ezplot(f1);
%     set(h0,'LineWidth',5,'Color','k');
%     
%     h=fill (coordinates(:,1),coordinates(:,2),'g');
%     set(h,'FaceAlpha',0.8);
    
end
