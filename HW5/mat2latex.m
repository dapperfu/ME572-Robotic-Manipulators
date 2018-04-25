function M=mat2latex(m,f)
if nargin<1||isempty(m)
    m=rand(2);
end
if nargin<2||isempty(f)
    f='%.2f';
end
M=sprintf('\\begin{bmatrix}\n');
for i=1:size(m,1)
    for j=1:size(m,2)-1
        if strcmp(class(m(i,j)),'sym')
            M=sprintf('%s%c',M,char(m(i,j)));
        else
            M=sprintf(['%s' f],M,(m(i,j)));
        end
        M=sprintf('%s&',M);
    end
    if strcmp(class(m(i,j)),'sym')
        M=sprintf('%s%c',M,char(m(i,j+1)));
    else
        M=sprintf(['%s' f],M,m(i,j+1));
    end
    M=sprintf('%s\\\\ \n',M);
end
M=sprintf('%s\\end{bmatrix}',M);
srch={'cos','sin','theta','alpha','*'};
repl={'\cos','\sin','\theta','\alpha','\cdot'};
for i=1:numel(srch)
    M=strrep(M,srch{i},repl{i});
end
