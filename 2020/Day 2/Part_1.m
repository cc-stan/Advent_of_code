clear all

list=fopen('list.txt');
M=textscan(list,'%f %*c %f %c %*c %s');
fclose(list);

M1=M{1};
M2=M{2};
M3=M{3};
M4=M{4};
M5=zeros(1000,1);

pol=zeros(1000,1);
pol2=zeros(1000,1);

temp=0;

for i=1:length(M4)
    M5(i,1)=count(M4(i),M3(i));
    pol(i)=(M5(i)<=M2(i)) && (M5(i)>=M1(i));    
end

for i=1:length(M4)
    pol2(i)=(M4{i}(M1(i))==M3(i))+(M4{i}(M2(i))==M3(i))==1;    
end

disp(sum(pol))
disp(sum(pol2))