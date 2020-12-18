clear
input1=splitlines(regexprep(fileread('input.txt'),{' ','+','*'},{'','/','\'}));
input2=splitlines(regexprep(fileread('input.txt'),{' ','+','*'},{'','/','-'}));

answer=[sum(cellfun(@eval,input1),'all'),sum(cellfun(@eval,input2),'all')];
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

function c=mrdivide(a,b)
c=a+b;
end
function c=mldivide(a,b)
c=a*b;
end
function c=minus(a,b)
c=a*b;
end