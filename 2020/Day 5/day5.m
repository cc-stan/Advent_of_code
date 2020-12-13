clear

list=fileread('list.txt');
list=splitlines(list);
list(end)=[];
list=regexprep(list,'F|L','0');
list=regexprep(list,'B|R','1');

id=sort(bin2dec(list));
check(:,1)=id(1):1:id(end-1);

disp(['Answer part 1= ',num2str(id(end))])
disp(['Answer part 2= ',num2str(id(find(id~=check,1,'first'))-1)])