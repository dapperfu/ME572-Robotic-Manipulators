tic
n=50000;
a=rand(1,n);
b=rand(1,n);
t(1)=toc;


clear c;
% Matrix Math: The way the truth the light.
tic
c=a.*b;
t(8)=toc;

% For loop, outputting each individual result.
clear c;
c=zeros(size(a));
tic
for i=1:length(a)
    c_tmp=a(i)*b(i)
    c(i)=c_tmp;
end
t(2)=toc;
% For loop, outputting each full matrix.
% Do not run this. It's so slow I killed it at 90 seconds because it dumps
% the full 1xn each time.
% tic
% for i=1:length(a)
%     c_tmp=a(i)*b(i)
%     c(i)=c_tmp;
% end
% t(2)=toc;

% For loop, supressing each result.
clear c;
c=zeros(size(a));
tic
for i=1:length(a)
    c_tmp=a(i)*b(i);
    c(i)=c_tmp;
end
t(3)=toc;

clear c;
c=zeros(size(a));
tic
parfor i=1:length(a)
    c_tmp=a(i)*b(i);
    c(i)=c_tmp;
end
t(4)=toc;
% For loop, outputting each individual result.
clear c;
tic
for i=1:length(a)
    c_tmp=a(i)*b(i)
    c(i)=c_tmp;
end
t(5)=toc;
% For loop, outputting each full matrix.
% Do not run this. It's so slow I killed it at 90 seconds because it dumps
% the full 1xn each time.
% tic
% for i=1:length(a)
%     c_tmp=a(i)*b(i)
%     c(i)=c_tmp;
% end
% t(2)=toc;

% For loop, supressing each result.
clear c;
tic
for i=1:length(a)
    c_tmp=a(i)*b(i);
    c(i)=c_tmp;
end
t(6)=toc;

clear c;
tic
parfor i=1:length(a)
    c_tmp=a(i)*b(i);
    c(i)=c_tmp;
end
t(7)=toc;
clc
fprintf('Generate %d random numbers\n\t\t%fs\n',n,t(1));
fprintf('\t\t-----Variable pre-allocation----\n');
fprintf('Multiply in loop, not supressing output\n\t\t%fs\n',t(2));
fprintf('Multiply in loop, supressing output\n\t\t%fs\n',t(3));
fprintf('Multiply in parallel loop, supressing output\n\t\t%fs\n',t(4));
fprintf('\t\t----No variable pre-allocation----\n');
fprintf('Multiply in loop, not supressing output\n\t\t%fs\n',t(5));
fprintf('Multiply in loop, supressing output\n\t\t%fs\n',t(6));
fprintf('Multiply in parallel loop, supressing output\n\t\t%fs\n',t(7));
fprintf('Multiply in matrix math\n\t\t%fs\n',t(8));