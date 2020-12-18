%% Main code

% Parsing
clear
input1=splitlines(regexprep(fileread('input.txt'),' ',''));
input2=input1;

% Part one
for i=1:length(input1)
    while ~isempty(regexp(input1{i},'[()]','once'))
        [math_temp,ims,ime]=regexp(input1{i},'[(][0-9*+]+[)]','match');
        for j=flip(1:length(math_temp))
            while ~isempty(regexprep(math_temp{j},'[0-9()]',''))
                [sum_temp,is,ie]=regexp(math_temp{j},'\d+[+*]\d+','match','once');
                math_temp{j}=replaceBetween(math_temp{j},is,ie,num2str(eval(sum_temp)));
            end
            math_temp(j)={regexprep(math_temp{j},'[()]','')};
            input1{i}=replaceBetween(input1{i},ims(j),ime(j),math_temp{j});
        end
    end
end

for i=1:length(input1)
    while ~isempty(regexprep(input1{i},'[0-9]',''))
        [sum_temp,is,ie]=regexp(input1{i},'\d+[+*]\d+','match','once');
        input1{i}=replaceBetween(input1{i},is,ie,num2str(eval(sum_temp)));
    end
end
answer=sum(str2double(input1),'all');

% Part two
for i=1:length(input2)
    while ~isempty(regexp(input2{i},'[()]','once'))
        [math_temp,ims,ime]=regexp(input2{i},'[(][0-9*+]+[)]','match');
        for j=flip(1:length(math_temp))
            while ~isempty(regexprep(math_temp{j},'[0-9()*]',''))
                [sum_temp,is,ie]=regexp(math_temp{j},'\d+[+]\d+','match','once');
                math_temp{j}=replaceBetween(math_temp{j},is,ie,num2str(eval(sum_temp)));
            end
            while ~isempty(regexprep(math_temp{j},'[0-9()]',''))
                [sum_temp,is,ie]=regexp(math_temp{j},'\d+[*]\d+','match','once');
                math_temp{j}=replaceBetween(math_temp{j},is,ie,num2str(eval(sum_temp)));
            end
            math_temp(j)={regexprep(math_temp{j},'[()]','')};
            input2{i}=replaceBetween(input2{i},ims(j),ime(j),math_temp{j});
        end
    end
end

for i=1:length(input2)
    while ~isempty(regexprep(input2{i},'[0-9*]',''))
        [sum_temp,is,ie]=regexp(input2{i},'\d+[+]\d+','match','once');
        input2{i}=replaceBetween(input2{i},is,ie,num2str(eval(sum_temp)));
    end
    while ~isempty(regexprep(input2{i},'[0-9]',''))
        [sum_temp,is,ie]=regexp(input2{i},'\d+[*]\d+','match','once');
        input2{i}=replaceBetween(input2{i},is,ie,num2str(eval(sum_temp)));
    end
end
answer(2)=sum(str2double(input2),'all');

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))