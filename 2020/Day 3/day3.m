%% load list
clear 

list=fopen('list.txt');
M=textscan(list,'%s');
fclose(list);

%% define variables
trees=0;
x=1;
y=1;

slopes=ones(2,5);
slopes(1,1:4)=1:2:7;
slopes(2,5)=2;

f=ones(1,length(slopes(1,:)));

%% tree collisions
for i=1:length(slopes(1,:))
    while y<=length(M{1})-slopes(2,i)
        x=mod(x+slopes(1,i)-1,length(M{1}{1}))+1;
        y=y+slopes(2,i);
        if M{1}{y}(x)=='#'
            trees=trees+1;
        end
    end
    f(i)=trees;
    
    %reset map
    trees=0;
    x=1;
    y=1;  
end

 %% answers 
disp(['Part 1 = ', num2str(f(2))])
disp(['Part 2 = ', num2str(prod(f))])
