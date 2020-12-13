clear

list=fileread('list.txt');
list(list=='.')=[];
list=regexp(list,'\r\n','split');
list=regexprep(list,'bags','bag');
list=regexprep(list,',', ',+');
list=regexprep(list,'no other bag', ' no other bag');
list=regexp(list,' contain |,','split');
bag={'shiny gold bag'};
subbag={'shiny gold bag'};
prevbag={'shiny gold bag'};

%% part one
while isempty(subbag)~=1
    for i=1:length(subbag)
        for j=1:length(list)
            if sum(contains(list{j},subbag))~=0
                if sum(contains(bag,list{j}{1}))==0
                    bag(end+1)=list{j}(1);
                end                
            end
        end
        if sum(contains(prevbag,subbag{i}))==0
            prevbag(end+1)=subbag(i);
        end            
    end
    subbag=bag(~contains(bag,prevbag));
end

%% part two
for i=1:length(list)
    bags(i).color=list{i}{1};
    bags(i).sub=[list{i}{2:end}];
end
bags(end+1).color='no other bag';
bags(end).sub='0';
str=' shiny gold bag';

while isempty(regexprep(str,'[0-9*+() ]',''))~=1
    for i=1:length(bags)
        str=regexprep(str,[' ',bags(i).color],['*(1+',bags(contains({bags.color},bags(i).color)).sub,')+']);
    end
end
str=str(5:end);
str=regexprep(str,')[+]',')');
str=regexprep(str,'[+][*]','*');
str(end)=[];

disp(['Answer part one= ',num2str(length(bag)-1),newline,'Answer part two= ',num2str(eval(str))])

