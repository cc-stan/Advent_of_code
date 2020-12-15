%% Main code

% Parsing
clear
input=str2double(regexp(fileread('input.txt'),',','split'));

% Part one
answer=mem_game(input,2020);

% Part two
answer(2)=mem_game(input,30000000);

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% Function to find the n-th number from a certain input sequence
function answer=mem_game(input,wn)
    seq=1:wn;
    seq(2:length(input)+1)=input;
    last=zeros(size(seq));
    nxt=0;
    for i=1:length(input)
    last(input(i)+1)=i;
    end
    
    for i=length(input)+1:wn
        prev=last(nxt+1);
        seq(i)=nxt;
        last(nxt+1)=i;
        nxt=0;
        if prev>0
            nxt=i-prev;
        end
    end
    answer=seq(end);
end