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
list2=regexprep(list,'x,','1+');
tt2=cellfun(@str2num,regexp(list2,'((1|\s)[0-9+]+,)|([,][0-9]+[,])','match'));
diff=tt2-tt;
[diff_temp,diff_mod]=deal(zeros(size(diff)));
for i=1:length(diff)
    diff_temp(i)=sum(diff(1:i))+i-1;
    diff_mod(i)=mod(tt(i)-diff_temp(i),tt(i));
end

tt_temp=tt;
val_temp=0;
x_prev=1;
ind=1;

while length(tt_temp)>1
    x_prev=x_prev*tt_temp(ind);
    tt_temp(ind)=[];
    diff_mod(ind)=[];
    x=val_temp;
    val_temp=inf;

    for i=1:length(tt_temp)
        val=check_mod(x,x_prev,tt_temp(i),diff_mod(i));
        if val_temp>val
            val_temp=val;
            ind=i;
        end
    end
end

% Answers
answer(2)=val_temp;

fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions
function val=check_mod(x,x_prev,y,diff)
    i=0;
        while mod(x+x_prev*i,y)~=diff
            i=i+1;
        end
    val=x+x_prev*i;
end