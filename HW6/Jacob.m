function J=Jacob(varargin)

% World Transform init
n=numel(varargin)-1;
M=varargin{end};
Tw=eye(size(varargin{1}));
for i=1:n
    % Assign each of the transform matricies.
    A{i}=varargin{i};
    % Multiply out the world transform.
    Tw=Tw*A{i};
end
% Simplify world transform
Tw=simplify(Tw);

% Create the intermediate Transform matrices.
Tn=cell(1,n);
Tn{1}=eye(size(A{1}));
for i=2:n
    Tn{i}=Tn{i-1}*A{i-1};
end
Pe=Tw(1:3,4);

% Get the A and P matrices for the intermediate steps.
an=cell(1,n);
P =cell(1,n);
for i=1:n
    an{i}=Tn{i}(1:3,3);
    P{i}=(Pe-Tn{i}(1:3,4));
end


% Create Jacobian
% J=zeros(6,n);
for i=1:n
    if strcmpi(M(i),'r')
        J(:,i)=simplify([cross(an{i},P{i});an{i}]);
    elseif strcmpi(M(i),'p')
        J(:,i)=[an{i};0;0;0];
    else
        error(sprintf('Unknown robot joint: %s',M(i)));
    end
    
end
J=simplify(J);