function objective_generator(f,n)
    f_string = char(f);
    fid = fopen ('objective_function.m','w');
    fprintf(fid,'function f = objective_function(x) \n');
    fprintf(fid,['func=inline(''',f_string,''');\n']);
    eval_string = 'f=func(';
    for i = 1 : n
       eval_string = [eval_string,'x(',num2str(i),'),']; 
    end
    eval_string (end)=[];
    eval_string = [eval_string,'); \n'];
    fprintf(fid,eval_string);
    fprintf(fid,'end \n');
    fclose (fid);
end