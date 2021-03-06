%% Main code

% Parsing
clear 
input=fileread('input.txt');
input=regexp(input,'\s\n\s','split')';
ranges=regexp(regexp(input{1},'\d+[-]\d+','match'),'-','split');
ranges=str2double(vertcat(ranges{:}));
others=regexp(splitlines(regexp(input{3},'(?<=nearby tickets:\r\n).*','match')),',','split');
others=str2double(vertcat(others{:}));
classes=regexp(input{1},'[a-z]+[ ][a-z]+(?=\:)|[a-z]+(?=\:)','match');
yours=regexp(splitlines(regexp(input{2},'(?<=your ticket:\r\n).*','match')),',','split');
yours=str2double(vertcat(yours{:}));

% Part one
check=false(1,1000);
for i=1:length(ranges)
    check(ranges(i,1)+1:ranges(i,2)+1)=true;
end

answer=0;
[im,jm]=size(others);
invalid=false(im,1);
for i=1:im
    temp=0;
    for j=1:jm
        if check(others(i,j)+1)==false
            answer=answer+others(i,j);
            temp=1;
        end
    end
    if temp==1
        invalid(i)=true;
    end
end

% Part two
valid=others(~invalid,:)';
check=false(length(ranges)/2,1000);
for i=1:2:length(ranges)
    for j=0:1
        check(ceil(i/2),ranges(i+j,1)+1:ranges(i+j,2)+1)=true;
    end    
end

check_class=false(20,20);
[im,jm]=size(valid);
for i=1:im
    for j=1:im
    temp=true;
        for k=1:jm
            if check(j,valid(i,k)+1)==false
                temp=false;
                break
            end
        end
        if temp==true
            check_class(i,j)=true;
        end
    end
end

new_order=strings(im,1);
for i=1:im
    for j=1:im
        if sum(check_class(j,:))==1
            new_order(j)=classes(check_class(j,:)==1);
            check_class(:,check_class(j,:)==1)=false;
            break
        end
    end
end
answer(2)=prod(yours(contains(new_order,'departure')));

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))