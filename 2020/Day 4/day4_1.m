clear 

list=fileread('list.txt');
list=regexprep(list,'\r\n\r\n',' - ');
list=strsplit(list,'-');
list=regexprep(list,'\r\n',' ');
list{1}=[' ',list{1}];
list{end}=[list{end},' '];

checks={' byr:',' iyr:',' eyr:',' hgt:',' hcl',' ecl:',' pid:'};
valid=0;

for i=1:length(list)
    temp=0;
    for j=1:length(checks)
        if contains(list{i},checks{j})
            temp=temp+1;
        end
    end
    if temp==length(checks)
        valid=valid+1;
    end
end

disp(['Answer part 1= ',num2str(valid)])

A(:,1)=regexp(list,'byr:(19[2-9][0-9]|200[012]) ');
A(:,2)=regexp(list,'iyr:(201[0-9]|202[0]) ');
A(:,3)=regexp(list,'eyr:(202[0-9]|203[0]) ');
A(:,4)=regexp(list,'hgt:1([5-8][0-9]|9[0-3])cm |hgt:(59|6[0-9]|7[0-6])in ');
A(:,5)=regexp(list,'hcl:#[0-9a-f]{6} ');
A(:,6)=regexp(list,'ecl:(amb|blu|brn|gry|grn|hzl|oth) ' );
A(:,7)=regexp(list,'pid:[0-9]{9} ');

valid=0;

for i=1:length(A(:,1))
    temp=0;
    for j=1:length(A(1,:))
        if ~isempty(A{i,j})
            temp=temp+1;
        end
    end    
    if temp==length(A(1,:))
        valid=valid+1;
    end
end

disp(['Answer part 2= ',num2str(valid)])