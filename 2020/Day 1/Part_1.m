
clear all

list=fopen('list.txt');
M=cell2mat(textscan(list,'%f'));
fclose(list);

sum=0;
sum2=0;
j=0;
k=0;

while sum~=2020
    j=j+1;
    for i=1:length(M)
        sum=M(i)+M(j);
        if sum==2020
            break
        end
    end
end

Answer_1=M(i)*M(j)

while sum2~=2020
    k=k+1;
    for j=1:length(M)
        for i=1:length(M)
        sum2=M(i)+M(j)+M(k);
            if sum2==2020
             break
            end
        end
        if sum2==2020
            break
        end
    end
end

Answer_2=M(i)*M(j)*M(k)