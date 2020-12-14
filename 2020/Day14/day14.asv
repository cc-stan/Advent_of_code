%% Main code

% Parsing
clear
list=splitlines(fileread('input.txt'));
bl=regexp(list{1},'[01X]+','match');
bl=length(bl{1});

% Part one
[mem.ind,mem.val]=part1(bl,list);
answer=sum_mem(mem.ind,mem.val);

% Part two
[mem2.ind,mem2.val]=part2(bl,list);
answer(2)=sum_mem(mem2.ind,mem2.val);

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% Function to solve part one
function [indexes,values]=part1(bl,list)
indexes=[];
values=[];
    for i=1:length(list)
        switch list{i}(2)
            case 'a'
                bit_mask=regexp(list{i},'[01X]+','match');
                bit_map=bit_mask{1}~='X';
            case 'e'
                ind=str2double(regexp(list{i},'(?<=\[).*(?=\])','match'));
                bin=dec2bin(str2double(regexp(list{i},'(?<=\ )\d+','match')),bl);
                bin(bit_map)=bit_mask{1}(bit_map);
                indexes(end+1)=ind;
                values(end+1)=bin2dec(bin);
        end
    end
end

% Function to solve part two
function [indexes,values]=part2(bl,list)
indexes=[];
values=[];
    for i=1:length(list)
        switch list{i}(2)
            case 'a'
                bit_mask=regexp(list{i},'[01X]+','match');
                bit_map_1=bit_mask{1}=='1';
                bit_map_X=bit_mask{1}=='X';
            case 'e'
                ind=str2double(regexp(list{i},'(?<=\[).*(?=\])','match'));
                mem_ind=dec2bin(ind,bl);
                mem_ind(bit_map_1)='1';
                for j=0:2^sum(bit_map_X)-1
                    mem_ind(bit_map_X)=dec2bin(j,sum(bit_map_X));
                    indexes(end+1)=bin2dec(mem_ind);
                    values(end+1)=str2double(regexp(list{i},'(?<=\ )\d+','match'));
                end
        end
    end
end

% Function to get the sum of values in the memory
function total=sum_mem(ind,val)
    ind_u=unique(ind);
    total=0;

    for i=1:length(ind_u)
        ind_t=find(ind==ind_u(i),1,'last');
        total=total+val(ind_t);
    end
end