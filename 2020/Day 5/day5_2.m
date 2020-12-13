%% load list
clear

list=fileread('list.txt');
list=splitlines(list);
list(end)=[];

r_l=7;
c_l=3;
id=zeros(length(list),1);
seat=zeros(length(list),2);

%% part one

for i=1:length(list)
    temp_rh=127;
    temp_rl=0;
    temp_ch=7;
    temp_cl=0;
    
    for j=1:r_l
        if list{i}(j)=='F'
            temp_rh=floor((temp_rh+temp_rl)/2);
        else
            temp_rl=ceil((temp_rh+temp_rl)/2);
        end
    end
    
    for j=1:c_l
        if list{i}(j+r_l)=='L'
            temp_ch=floor((temp_ch+temp_cl)/2);
        else
            temp_cl=ceil((temp_ch+temp_cl)/2);
        end
    end

    seat(i,1:2)=[temp_rh,temp_ch];
    id(i)=8*temp_rh+temp_ch;    
end

%% part two

seat=sortrows(seat);
seat_mr=sortrows(seat);
seat_mr(seat_mr(:,1)==seat_mr(end,1),:)=[];
seat_mr(seat_mr(:,1)==seat_mr(1,1),:)=[];

for i=1:(length(seat)+1)/8
    check((i-1)*8+1:i*8)=0:1:7;
end

for i=1:length(check)
    if seat_mr(i,2)~=check(i)
        break
    end
end

i=i+sum(seat_mr(:,1)==seat_mr(1,1));

if seat(i,1)==seat(i-1,1)
    id_y=8*seat(i,1)+(seat(i,2)+seat(i-1,2))/2;
elseif seat(i,2)==0
    id_y=8*seat(i,1)-1;    
else
    id_y=8*seat(i,1);    
end

%% answers

disp(['Answer part 1= ',num2str(max(id))])
disp(['Answer part 2= ',num2str(id_y)])











