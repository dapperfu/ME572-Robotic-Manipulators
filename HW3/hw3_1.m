syms a b c d e


A01=[-1 0 0 0;
    0 0 -1 c+e;
    0 -1 0 a-d;
    0 0 0 1];

A12=[0 -1 0 b;
    0 0 -1 a-d;
    1 0 0 0
    0 0 0 1;];

A23=[0 0 1 e;
    0 1 0 0;
    -1 0 0 a;
    0 0 0 1];

A34=[0 0 -1 d;
    1 0 0 0;
    0 -1 0 c;
    0 0 0 1];

A45=[0 0 -1 b;
    1 0 0 0;
    0 -1 0 d;
    0 0 0 1];

A50=[0 1 0 0;
    0 0 -1 a;
    -1 0 0 0;
    0 0 0 1];

A02=A01*A12;
A03=A01*A12*A23;
A04=A01*A12*A23*A34;
A05=A01*A12*A23*A34*A45;
A00=A01*A12*A23*A34*A45*A50;

mat2latex(A01,'^0A_1')
mat2latex(A12,'^1A_2')
mat2latex(A23,'^2A_3')
mat2latex(A34,'^3A_4')
mat2latex(A45,'^4A_5')
mat2latex(A50,'^5A_0')
fprintf('\n\n');
mat2latex(A02,'^0A_2')
mat2latex(A03,'^0A_3')
mat2latex(A04,'^0A_4')
mat2latex(A05,'^0A_5')
mat2latex(A00,'^0A_0')
