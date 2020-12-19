%% Main code

% Parsing
clear
input=fileread('input.txt');
rules=regexp(input,'(?<num>\d+(?=\:)):(?<act>[" ab0-9|]+(?=\s))','names');
mes=regexp(input,'[ab][ab]+','match')';

% Sort the rules
rulest=struct2table(rules);
rulest.num=str2double(rulest.num);
rulest=sortrows(rulest);
rulest.num=num2str(rulest.num);
rules=table2struct(rulest);

% Part one
trans=string(0:length(rules)-1)';
trans(contains({rules.act},'a'))='"a"';
trans(contains({rules.act},'b'))='"b"';

while  ~(regexprep(trans(1),'\D','')=="")
    for i=1:length(rules)
        [temp,is,ie]=regexp(rules(i).act,'\d+','match');
        for j=flip(1:length(temp))
            if regexprep(trans(eval(temp{j})+1),'\D','')==""
                rules(i).act=replaceBetween(rules(i).act,is(j),ie(j),'+('+trans(eval(temp{j})+1)+')');
            end
        end        
    end
    ind=logical(cellfun(@isempty,regexprep({rules.act},'\D',''))-cellfun(@isempty,cellfun(@str2num,trans,'UniformOutput',false))');
    trans(ind)={rules(ind).act};
end

rule0=trans_rule(rules(1));
answer=sum(matches(mes,rule0));

% Part two
rule42=trans_rule(rules(43));
rule31=trans_rule(rules(32));

check=false(length(mes),1);
[rulex,ruley_1,ruley_2]=deal(string());
[xm,ym]=deal(5);
for x=1:xm
    rulex=rulex+rule42;                 % rule8=' 42 | 42 8';
    for y=1:ym
        ruley_1=ruley_1+rule42;         % rule11=' 42 31 | 42 11 31';
        ruley_2=ruley_2+rule31;
        rule0_2=rulex+ruley_1+ruley_2;  % rule0=x*rule42+y*rule42+y*rule31
        
        check(~check)=matches(mes(~check),rule0_2);
    end
    [ruley_1,ruley_2]=deal(string());
end
answer(2)=sum(check);

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% Function to translate a string in the rules set to a proper pattern.
function rule=trans_rule(rule)
    rule=regexprep(rule.act,{' ','[(]["]a["][)]','[(]"b"[)]'},{'','"a"','"b"'});
    rule=regexprep(rule,{'"[+]"','[)][+][(]','"[+][(]','[)][+]"'},{'',')-(','"-(',')-"'});
    rule=regexprep(rule,{'[+]','-'},{'','+'});
    rule=eval(rule);
end