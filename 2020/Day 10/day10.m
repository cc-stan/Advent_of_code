%% Main code

% Load list
clear 
V=[0;str2double(splitlines(fileread('list.txt')))];

% Part one
V=sort(V);
V2=[V(2:end);V(end)+3];
Diff=V2-V;
answer(1)=sum(Diff==1)*sum(Diff==3);

% Part two
n_cons_1=regexp(regexprep(regexprep(mat2str(Diff),'[[];]',''),'1','+1'),'3','split');
n_cons_1=cellfun(@str2num,n_cons_1(~cellfun('isempty',n_cons_1)));
V_pats=patterns(max(n_cons_1));

total=1;
for i=1:length(n_cons_1)
    total=total*V_pats(n_cons_1(i));
end
answer(2)=total;

% % Answers
% fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% Function to calculate the amount of patterns for a certain number of consecutive ones
function V=patterns(k)
    V=[1,2,4];
    if k>3
        V=[V,zeros(1,k-3)];
        for i=1:k-3
            V(i+3)=sum(V(i:i+2));
        end
    end
end