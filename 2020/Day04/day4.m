%% load list 
clear 

str=fileread('list.txt');
str=[str,' '];
str=regexprep(str,'\r\n',' ');
str=regexprep(str,'  ',' \n');
ids=splitlines(str);

check={'byr:','iyr:','eyr:','hgt:','hcl:','ecl:','pid:'};

valid=zeros(1,length(ids));
temp=0;

%% part one

for i=1:length(ids)
    for j=1:length(check)
        if contains(ids{i},check{j})
            temp=temp+1;
        end
    end
    if sum(temp)==length(check)
        valid(i)=1;
    end
    temp=0;
end

ids_v=ids(valid==1);

%% part 2

data=cell(length(ids_v),length(check));
valid2=zeros(length(ids_v),length(check));

for i=1:length(ids_v)
    for j=1:length(check)
        data{i,j}=extractBetween(ids_v{i},check{j},' ');
    end
end

for i=1:length(ids_v)
    temp=str2double(data{i,1});
    if (temp>=1920) && (temp<=2002)
        valid2(i,1)=1;
    end
    
    temp=str2double(data{i,2});
    if (temp>=2010) && (temp<=2020)
        valid2(i,2)=1;
    end
   
    temp=str2double(data{i,3});
    if (temp>=2020) && (temp<=2030)
        valid2(i,3)=1;
    end

    if contains(data{i,4}{1},'cm')
        temp=str2double(extractBetween(data{i,4}{1},1,'cm'));
        if (temp>=150) && (temp<=193)
            valid2(i,4)=1;
        end
    elseif contains(data{i,4}{1},'in')
        temp=str2double(extractBetween(data{i,4}{1},1,'in'));
        if (temp>=59) && (temp<=76)
            valid2(i,4)=1;
        end
    end
    
    if (data{i,5}{1}(1)=='#') && (length(data{i,5}{1})==7) && (length(regexprep(data{i,5}{1},'[a-f0-9]',''))== 1)
        valid2(i,5)=1;
    end
    
    eye_check={'amb','blu','brn', 'gry', 'grn', 'hzl', 'oth'};
    
    if (length(data{i,6}{1})==3) && (contains(data{i,6}{1},eye_check))
        valid2(i,6)=1;
    end
    
    if (length(data{i,7}{1})==9) && isempty(regexprep(data{i,7}{1},'[0-9]',''))
        valid2(i,7)=1;
    end
end

%% answers

disp(['Part 1 = ', num2str(sum(valid))])
disp(['Part 2 = ', num2str(sum(sum(valid2,2)==7))])
