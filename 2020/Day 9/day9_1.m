%% Main code

% Load list
clear
V=str2double(splitlines(fileread('list.txt')));

% Part one
i=25;
check=1;
while check==1
    i=i+1;
    check=sumofprev25(V,i);
end

% Part two
k=1;
check=0;
while check~=1
    k=k+1;
    [weakness,check]=sumofcont(V,i,k);
end

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',V(i),weakness)

%% Functions

% Function to check if a number is a combination of two previous numbers
function check=sumofprev25(V,i)
   M=bsxfun(@plus,V(i-25:i-1),V(i-25:i-1)').*~(eye(25));
   check=any(ismember(M,V(i)),'all');
end

% Function to check if it is part of the sum of a contiguous number set
function [weakness,check]=sumofcont(V,i,k)
   weakness=0;
   sums=conv(V,ones(k,1));
   check=any(ismember(sums(k:end-k+1),V(i)));
   
   if check==1
       i=find(sums(k:end-k+1)==V(i));  
       weakness=min(V(i:i+k-1))+max(V(i:i+k-1));
   end
end



