%% Main code

% Parsing
clear
input=fileread('input.txt');
input=str2double(regexp(input,'\d','match'));

% Part one
point_part1=game(input,100);
cur=1;
part1=zeros(0,8);
for i=1:8
    part1(i)=point_part1(cur);
    cur=point_part1(cur);
end
answer=eval(join(string(part1),''));

% Part two
input(end+1:1000000)=10:1000000;
point_part2=game(input,10000000);
answer(2)=point_part2(1)*point_part2(point_part2(1));

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% function to play the game
function point_clk=game(input,r)
len=length(input);
point_clk=zeros(0,len);
for i=1:len
    point_clk(input(i))=input(wrap_it(i+1,len));
end
cur=input(1);

for i=1:r
    pickup=[point_clk(cur),point_clk(point_clk(cur)),point_clk(point_clk(point_clk(cur)))];
    point_clk(cur)=point_clk(pickup(end));
    dest=wrap_it(cur-1,len);
    while any(pickup==dest)
        dest=wrap_it(dest-1,len);
    end
    temp=point_clk(dest);
    point_clk(dest)=pickup(1);
    point_clk(pickup(end))=temp;
    cur=point_clk(cur);
end
end

% function to wrap vector
function wrapped=wrap_it(x,len)
wrapped=mod(x-1,len)+1;
end