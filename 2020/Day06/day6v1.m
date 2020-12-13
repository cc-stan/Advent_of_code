%% load list
tic
clear
list=fileread('list.txt');
list=strsplit(list,'\r\n\r\n');
yes1=day6_1(list);
yes2=day6_2(list);

disp(['Answer part one= ',num2str(yes1)])
disp(['Answer part one= ',num2str(yes2)])
toc

%% part one

function yes=day6_1(list)
    list=regexprep(list,'\r\n','');
    yes=0;
    
    for i=1:length(list)
        yes=yes+length(unique(list{i}));
    end
end

%% part two

function yes=day6_2(list)
    list=regexp(list,'\r\n','split');
    yes=0;

    for i=1:length(list)
        for j=1:length(list{i})-1
            if isempty(list{i}{1})~=1
                list{i}{1}(~ismember(list{i}{1},list{i}{j+1}))='';           
            end
        end
        yes=yes+length(list{i}{1});
    end
end