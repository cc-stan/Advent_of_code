clear
input=fileread('input.txt');
ids=str2double(regexp(input,'\d+','match'));
tiles_str=regexprep(input,{'[ Tile0-9:]|\r|\n','[.]','#'},{'',char(0),char(1)});
sz=sqrt(length(tiles_str)/length(ids));

temp=zeros(sz);

tiles=cell(1,length(ids));
j=0;
k=0;
for i=1:length(tiles_str)
    j=j+1;
    
    temp(j)=tiles_str(i);
    if j==sz^2
        j=0;
        k=k+1;
        tiles(k)={temp};
    end
end

match=zeros(1,length(ids));
edges=cell(528,1);
id_match=zeros(528,2);
k=0;
for i=1:length(ids)
    for j=1:length(ids)
        match_temp=check_match(tiles{i},tiles{j});
        if match_temp>0 && i~=j
            k=k+1;
            [~,edges{k}]=check_match(tiles{i},tiles{j});
            match(i)=match(i)+match_temp;
            id_match(k,:)=[i,j];
        end
    end
end
answer=prod(ids(match==2));
corner_ind=1:length(ids);
corner_ind=corner_ind(match==2);

grid_sz=sqrt(length(ids));
puzzle=cell(grid_sz);

x=grid_sz;
y=1;
id=9;
%id=2;
puzzle{y,x}=tiles{id};
puz_id=zeros(grid_sz);
check_id=true(1,length(ids));
puz_id(y,x)=id;
for x=flip(1:grid_sz)
    for y=1:grid_sz
        id=puz_id(y,x);
        match_temp=id_match(id_match(:,1)==id,2);       
        for i=1:length(match_temp)
            c=match_temp(i);
            if check_id(c)
                k=0;
                while k<4
                [~,edge]=check_match(tiles{id},tiles{c});
                    switch num2str([edge(1,:),edge(4,:)])
                        case "1  0  0  0  0  0  0  0"
                            tiles{c}=flip(tiles{c},2);
                            puzzle{y,x-1}=flip(tiles{c},2);
                            puz_id(y,x-1)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  1  0  0  0  0  0  0"
                            puzzle{y,x-1}=tiles{c};
                            puz_id(y,x-1)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  1  0  0  0  0  0"
                            tiles{c}=rot90(tiles{c},3);
                            puzzle{y,x-1}=tiles{c};
                            puz_id(y,x-1)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  0  1  0  0  0  0"
                            tiles{c}=flip(rot90(tiles{c}));
                            puzzle{y,x-1}=tiles{c};
                            puz_id(y,x-1)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  0  0  1  0  0  0"
                            tiles{c}=rot90(flip(tiles{c}),3);
                            puzzle{y+1,x}=tiles{c};
                            puz_id(y+1,x)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  0  0  0  1  0  0"
                            tiles{c}=rot90(tiles{c});
                            puzzle{y+1,x}=tiles{c};
                            puz_id(y+1,x)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  0  0  0  0  1  0"
                            puzzle{y+1,x}=tiles{c};
                            puz_id(y+1,x)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  0  0  0  0  0  1"
                            tiles{c}=flip(tiles{c});
                            puzzle{y+1,x}=tiles{c};    
                            puz_id(y+1,x)=c;
                            k=4;
                            check_id(c)=false;
                        case "0  0  0  0  0  0  0  0"
                                if k<1
                                k=k+1;
                                tiles{c}=flip(tiles{c});
                                elseif k<2
                                k=k+1;
                                tiles{c}=flip(tiles{c},2);
                                else
                                k=k+1;
                                tiles{c}=flip(tiles{c});
                                end
                    end
                end
            end
        end
    end
end

puzzle_copy=puzzle;
for i=1:grid_sz
    for j=1:grid_sz
        puzzle_copy{i,j}(1,:)=2;
        puzzle_copy{i,j}(end,:)=2;
        puzzle_copy{i,j}(:,1)=2;
        puzzle_copy{i,j}(:,end)=2;        
    end
end
puzzle_full=cell2mat(puzzle_copy);
for i=1:grid_sz
    for j=1:grid_sz
        puzzle{i,j}=tiles{puz_id(i,j)};
    end
end

for i=1:grid_sz
    for j=1:grid_sz
        puzzle{i,j}=puzzle{i,j}(2:end-1,2:end-1);
    end
end
puzzle=cell2mat(puzzle);

monster=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0;...
        1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,1;...
        0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0];
    
%     [~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,1,~;...
%         1,~,~,~,~,1,1,~,~,~,~,1,1,~,~,~,~,1,1,1;...
%         ~,1,~,~,1,~,~,1,~,~,1,~,~,1,~,~,1,~,~,~];
sum_mon=sum(monster,'all');
puzzle=flip(rot90(puzzle,3),2);
%puzzle=flip(flip(puzzle),2);
monster=flip(monster,2);

figure(1)
imagesc(flip(puzzle),[0,2]);
hold on; 
for i=1:length(puzzle)
   plot([.5,length(puzzle)+.5],[i-.5,i-.5],'k-');
   plot([i-.5,i-.5],[.5,length(puzzle)+.5],'k-');
end
axis equal;

monster_conv=conv2(puzzle,monster);
monsters_total=sum(monster_conv==15,'all');

[monx,mony]=find(monster==1);
[xm,ym]=find(monster_conv==15);

for i=1:length(xm)
    for j=1:length(monx)
        puzzle(xm(i)-monx(j)+1,ym(i)-mony(j)+1)=2;
    end
end

figure(2)
imagesc(flip(puzzle),[0,2]);
hold on; 
for i=1:length(puzzle)
   plot([.5,length(puzzle)+.5],[i-.5,i-.5],'k-');
   plot([i-.5,i-.5],[.5,length(puzzle)+.5],'k-');
end
axis equal;

answer(2)=sum(puzzle==1,'all');
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2));


