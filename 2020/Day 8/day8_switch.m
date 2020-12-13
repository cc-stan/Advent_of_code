%% Load list
clear
list=regexp(splitlines(fileread('list.txt')),' ','split');
list = mat2cell(vertcat(list{:}),size(list,1),[1 1]);
[action,value] = deal(list{:});
value=str2double(value);

%% initialize values
ind_p=[];
ind_c=1;
acc=0;

%% part one
[answer(1),ind_p_error]=run_game(ind_p,ind_c,acc,action,value);

%% part two

ind_error=ind_p_error(contains(action(ind_p_error),["jmp","nop"]));

k=1;

while ind_c<length(action)+1
    action(ind_error(k))={regexprep([action{ind_error(k)},'jmpnop'],action{ind_error(k)},'')};
    
    [answer(2),~,ind_c]=run_game(ind_p,1,acc,action,value);
    
    action(ind_error(k))={regexprep([action{ind_error(k)},'jmpnop'],action{ind_error(k)},'')};
    
    k=k+1;
end
%% Answers
disp(['Answer part one= ',num2str(answer(1)),newline,'Answer part two= ',num2str(answer(2))])

%% Function to run a game
function [acc_finished,ind_p_final,ind_c_final]=run_game(ind_p,ind_c,acc,action,value)
    while (sum(ind_p==ind_c)==0) && (ind_c<length(action)+1)
        ind_p(end+1)=ind_c;
        switch action{ind_c}
            case "acc"
                acc=acc+value(ind_c);
                ind_c=ind_c+1;
            case "jmp"
                ind_c=ind_c+value(ind_c);
            otherwise
                ind_c=ind_c+1;
        end
    end
    acc_finished=acc;
    ind_p_final=ind_p;
    ind_c_final=ind_c;
end