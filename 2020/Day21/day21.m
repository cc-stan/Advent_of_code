clear
input=fileread('input.txt');
input=splitlines(input);
algs=regexp(input,'(?<=contains )[a-z]+|(?<=, )[a-z]+','match');
ing=regexp(input,'\<(?!contains\>)[a-z]+ ','match');
all_ing=unique([ing{:}]);
all_algs=unique([algs{:}]);

al.algs=all_algs;
al.pos=cell(size(al.algs));

for i=1:length(ing)
    for j=1:length(algs{i})
        ind=ismember(al.algs,algs{i}{j});
        if isempty(al.pos{ind})
            al.pos(ind)=ing(i);
        else
            al.pos{ind}=al.pos{ind}(ismember(al.pos{ind},ing{i}));
        end
    end
end

wrong=all_ing(~ismember(all_ing,unique([al.pos{:}])));
answer=sum(ismember([ing{:}],wrong));

for i=1:length(ing)
    ing{i}=ing{i}(~cellfun(@isempty,regexprep(ing{i},wrong,'')));
end

part2.ing=unique([ing{:}]);
part2.count=cell(1,8);
part2.count(:)={zeros(1,8)};

for i=1:length(ing)
    for j=1:length(algs{i})
        ind=ismember(al.algs,algs{i}{j});
        for k=find(ismember(part2.ing,ing{i}))
           part2.count{k}(ind)= part2.count{k}(ind)+1;
        end
    end
end

total=zeros(1,length(al.algs));
for i=1:length(al.algs)
    total(i)=sum(ismember([algs{:}],all_algs{i}));
end
check=false(length(al.algs));
for i=1:length(al.algs)
    check(i,:)=part2.count{i}==total;
end

check_temp=cell(length(al.algs),1);
i=0;
while sum(check,'all')>0
    i=mod(i,8)+1;
    if sum(check(:,i))==1
        check_temp{i}=part2.ing(check(:,i));
        check(check(:,i),:)=false;        
    end
end
answer2=regexprep(join([check_temp{:}],','),' ','');
fprintf('Answer to part one= %d\nAnswer to part two= ',answer(1))
fprintf([answer2{1} '\n']);
