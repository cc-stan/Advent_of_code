%% Main code

% Parsing
clear
input=splitlines(fileread('input.txt'));

% Part one
tiles=zeros(20,3);
for i=1:length(input)
    x=0;
    y=0;
    z=0;
    cur=input{i};
    j=0;
    while j<length(cur)
        j=j+1;
        if cur(j)=="e"
            x=x+1;
            y=y-1;
        elseif cur(j)=="w"
            x=x-1;
            y=y+1;
        else
            j=j+1;
            if cur(j-1:j)=="se"
                x=x+1;
                z=z-1;
            elseif cur(j-1:j)=="sw"
                y=y+1;
                z=z-1;
            elseif cur(j-1:j)=="nw"
                x=x-1;
                z=z+1;
            elseif cur(j-1:j)=="ne"
                y=y-1;
                z=z+1;
            end
        end
    end
    tiles(i,:)=[x,y,z];
end

[tiles_u,ia,ic]=unique(tiles,'rows','stable');
h=accumarray(ic,1);
h=mod(h,2);
answer=sum(h);

% Part two
black=tiles_u(logical(h),:);
total_tiles=zeros(1,100);
for j=1:100
    resultc=cell(length(black),1);
    parfor i=1:length(black)
        resultc{i}=[black(i,:);...
            black(i,:)+[1,-1,0];...
            black(i,:)+[1,0,-1];...
            black(i,:)+[0,1,-1];...
            black(i,:)+[-1,1,0];...
            black(i,:)+[-1,0,1];...
            black(i,:)+[0,-1,1];];
    end
    result=unique(cell2mat(resultc),'rows');
    map=ismember(result,black,'rows');
    temp_map=false(size(map));
    
    parfor i=1:length(result)
        neighbors=[result(i,:)+[1,-1,0];...
            result(i,:)+[1,0,-1];...
            result(i,:)+[0,1,-1];...
            result(i,:)+[-1,1,0];...
            result(i,:)+[-1,0,1];...
            result(i,:)+[0,-1,1];];
        total=sum(ismember(neighbors,black,'rows'));
        
        if map(i) && (total==1 || total==2)
            temp_map(i)=true;
        elseif ~map(i) && total==2
            temp_map(i)=true;
        end
    end
    map=temp_map;
    black=result(temp_map,:);
    total_tiles(j)=length(black);
end
answer(2)=total_tiles(end);

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))




