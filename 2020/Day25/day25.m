%% Main code

% Parsing
clear
input=str2double(regexp(fileread('input.txt'),'\d+','match'));
rem_val=20201227;

% Part one
val=7;
loop=1;

card_check=false;
door_check=false;

while true
    val=val*7;
    val=mod(val,rem_val);
    loop=loop+1;
    
    if val==input(1)
        card_loop=loop;        
        card_check=true;
        card_val=val;
    elseif val==input(2)
        door_loop=loop;  
        door_check=true;
        door_val=val;
    end
    if card_check && door_check
        break
    end
end

part1 = 1;
for i = 1:door_loop
    part1 = part1*card_val;
    part1 = mod(part1, 20201227);
end

% Answer
fprintf('Answer to part one= %d\n',part1)