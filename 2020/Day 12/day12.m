%% Main code

% Load list
clear
list=[fileread('list.txt'),' '];
pattern='(?<act>\w)(?<val>\d+)[\s+]';
boat=regexp(list,pattern,'names');

% Part one
[x,y]=deal(0);
dir=90;
for i=1:length(boat)
    switch boat(i).act
        case 'N'
            y=y+str2double(boat(i).val);
        case 'E'
            x=x+str2double(boat(i).val);
        case 'S'
            y=y-str2double(boat(i).val);
        case 'W'
            x=x-str2double(boat(i).val);
        case 'L'
            dir=mod(dir-str2double(boat(i).val),360);
        case 'R'
            dir=mod(dir+str2double(boat(i).val),360);
        case 'F'
            switch dir
                case 0
                    y=y+str2double(boat(i).val);
                case 90
                    x=x+str2double(boat(i).val);
                case 180
                    y=y-str2double(boat(i).val);
                case 270
                    x=x-str2double(boat(i).val);
            end
    end            
end
answer=abs(x)+abs(y);

% Part two
way_x=10;
way_y=1;
[x,y]=deal(0);
for i=1:length(boat)
    switch boat(i).act
        case 'N'
            way_y=way_y+str2double(boat(i).val);
        case 'E'
            way_x=way_x+str2double(boat(i).val);
        case 'S'
            way_y=way_y-str2double(boat(i).val);
        case 'W'
            way_x=way_x-str2double(boat(i).val);
        case 'L'
            [way_x,way_y]=rot_way(way_x,way_y,1,boat(i).val);
        case 'R'
            [way_x,way_y]=rot_way(way_x,way_y,-1,boat(i).val);
        case 'F'
            x=x+str2double(boat(i).val)*way_x;
            y=y+str2double(boat(i).val)*way_y;
    end            
end
answer(2)=abs(x)+abs(y);

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

function [x,y]=rot_way(x,y,act,val)
    switch val
        case "90"
            x_temp=act*x;
            y_temp=act*y;
            x=-y_temp;
            y=x_temp;
        case "180"
            x_temp=x;
            y_temp=y;
            x=-x_temp;
            y=-y_temp;                  
        case "270"
            x_temp=act*x;
            y_temp=act*y;
            x=y_temp;
            y=-x_temp;  
    end
end