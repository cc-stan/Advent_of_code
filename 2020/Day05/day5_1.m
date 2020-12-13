clear

list=fileread('list.txt');
list=splitlines(list);
list(end)=[];

r_l=7;
c_l=3;
idh=0;
seat=zeros(length(list),2);

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

    if idh<8*temp_rh+temp_ch
        idh=8*temp_rh+temp_ch;
    end
end

disp(['Answer part 1= ',num2str(idh)])