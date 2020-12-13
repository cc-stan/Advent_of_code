%% Main code

% Load list
clear
list=[fileread('list.txt'),','];
ts=str2double(regexp(list,'\d+[\r\n]','match'));
tt=cellfun(@str2double,regexp(list,'\d+[,]','match'));

% Part one
wt=arrayfun(@(x) mod(ts,x),tt);
wt=tt-wt;
answer=min(wt)*tt(wt==min(wt));

% Part two
tt2=cellfun(@str2num,regexp(regexprep(list,'x,','1+'),'((1|\s)[0-9+]+,)|([,][0-9]+[,])','match'));
diff=tt2-tt;
[diff_temp,diff_mod]=deal(zeros(size(diff)));
for i=1:length(diff)
    diff_temp(i)=sum(diff(1:i))+i-1;
    diff_mod(i)=mod(tt(i)-diff_temp(i),tt(i));
end

x_prev=tt(1);
x=0;
for i=2:length(tt)
    x=check_mod(x,x_prev,tt(i),diff_mod(i));
    x_prev=x_prev*tt(i);
end
answer(2)=x;

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions
function val=check_mod(x,x_prev,y,diff)
    i=0;
        while mod(x+x_prev*i,y)~=diff
            i=i+1;
        end
    val=x+x_prev*i;
end