% Load list
clear
list=regexp(splitlines(fileread('list.txt')),' ','split');
list = mat2cell(vertcat(list{:}),size(list,1),[1 1]);
[action,value] = deal(list{:});
value=str2double(value);

% Initialize variables and constants
i_prev=[];
i_cur=1;
acc=0;

% Part one
[answer(1),i_prev_error]=run_game(i_prev,i_cur,acc,action,value);

% Part two
i_error=i_prev_error(contains(action(i_prev_error),["jmp","nop"]));
k=1;
while i_cur<length(action)+1
    action{i_error(k)}=flip(action{i_error(k)});
    [answer(2),~,i_cur]=run_game(i_prev,1,acc,action,value);
    action{i_error(k)}=flip(action{i_error(k)});
    
    k=k+1;
end

% Answers
disp(['Answer part one= ',num2str(answer(1)),newline,'Answer part two= ',num2str(answer(2))])

% Function to run a game
function [acc_final,i_prev_final,i_cur_final]=run_game(i_prev,i_cur,acc,action,value)
    while ~any(i_prev==i_cur) && (i_cur<length(action)+1)
        i_prev=[i_prev;i_cur];
        switch action{i_cur}
            case "acc"
            acc=acc+value(i_cur);
            i_cur=i_cur+1;
            case "jmp" 
            i_cur=i_cur+value(i_cur);
            otherwise
            i_cur=i_cur+1;
        end
    end
    acc_final=acc;
    i_prev_final=i_prev;
    i_cur_final=i_cur;
end

% Function to flip 'jmp' and 'nop'
function str_flipped=flip(str)
str_flipped=erase('jmpnop',str);
end

