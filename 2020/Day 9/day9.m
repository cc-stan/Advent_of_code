%% Main code

% Load list
clear
V=str2double(splitlines(fileread('list.txt')));

% Part one
[answer(1),i]=part1(V,25,1);

% Part two
tic
answer(2)=part2(V,i,1,0);
toc
% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% Part one
function [answer,i]=part1(V,i,check)
    while check==1
    i=i+1;
    M=bsxfun(@plus,V(i-25:i-1),V(i-25:i-1)').*~(eye(25));
    check=any(ismember(M,V(i)),'all');
    end
    answer=V(i);
end

% Part two
function answer=part2(V,i,k,check)
    while check~=1
        k=k+1;
        sums=conv(V,ones(k,1));
        check=any(ismember(sums(k:end-k+1),V(i)));
    end
       i=find(sums(k:end-k+1)==V(i));  
       answer=min(V(i:i+k-1))+max(V(i:i+k-1));
end