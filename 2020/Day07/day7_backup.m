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

for i=1:length(list)
    bags(i).color=list{i}{1};
    bags(i).sub=[list{i}{2:end}];
end
bags(end+1).color='no other bag';
bags(end).sub='1';
str='1 shiny gold bag';

while isempty(regexprep(str,'[0-9x+() ]',''))~=1
    for i=1:length(bags)
        str=regexprep(str,[' ',bags(i).color],['x(',bags(contains({bags.color},bags(i).color)).sub,')']);
    end
end
str=regexprep(str,' ','');
str=regexprep(str,'x(x','x(');
str=regexprep(str,'x','*');
eval(str)

% str=regexprep(str,'(*(','((');

% 
% c=1;
% amount={'1'};
% colors={'shiny gold'};
% 
% for i=1:length(list)
%     if contains(list{i}{1}, 'shiny gold bags')
%         break
%     end
% end
% for j=1:length(list{i})-1
%     if contains(list{i}{2},'no other bags')==0
%     amount(j)={list{i}{j+1}(1)};
%     colors(j)={extractBetween(list{i}{j+1},2,' bag')};
%     end
% end