function mat2latex(m,n,f);
if nargin<1||isempty(m)
    m=rand(2);
end
if nargin<2||isempty(n)
    n='A';
end
if nargin<3||isempty(f)
    f='%.2f';
end


fprintf('%s=',n);
fprintf('\\begin{bmatrix}\n');
for i=1:size(m,1)
    for j=1:size(m,2)-1
        if strcmp(class(m(i,j)),'sym')
            fprintf('%c',char(m(i,j)));
        else
            fprintf(f,(m(i,j)));
        end
        fprintf('&');
    end
    if strcmp(class(m(i,j)),'sym')
        fprintf('%c',char(m(i,j+1)));
    else
        fprintf(f,(m(i,j+1)));
    end
    fprintf('\\\\ \n');
end
fprintf('\\end{bmatrix}\n');
