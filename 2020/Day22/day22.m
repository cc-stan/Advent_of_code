clear
input=fileread('input.txt');
players=regexp(input,'\r\n\r\n','split');
deck1=splitlines(players{1});
deck2=splitlines(players{2});
deck1=str2double(deck1(2:end));
deck2=str2double(deck2(2:end));
deck_sz=length(deck1)+length(deck2);
[~,winner]=combat(deck1,deck2);
x=1:length(winner);
answer=sum(flip(winner).*x');
[~,winner2]=recur_combat(deck1,deck2);
y=1:length(winner2);
answer(2)=sum(flip(winner2).*y');
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

function [winner,deck]=combat(deck1,deck2)
while ~isempty(deck1)&&~isempty(deck2)
    if deck1(1)>deck2(1)
        deck1(end+1:end+2)=[deck1(1);deck2(1)];
        deck1(1)=[];
        deck2(1)=[];
    else
        deck2(end+1:end+2)=[deck2(1);deck1(1)];
        deck1(1)=[];
        deck2(1)=[];
    end
end
if isempty(deck1)
    winner=2;
    deck=deck2;
else
    winner=1;
    deck=deck1;
end
end

function [winner,deck]=recur_combat(deck1,deck2)
deck_temp1={};
deck_temp2={};
deck1_check=false;
deck2_check=false;
while ~isempty(deck1)&&~isempty(deck2)
    deck_temp1(end+1,:)={mat2str(deck1)};
    deck_temp2(end+1,:)={mat2str(deck2)};
    if sum(ismember(deck_temp1,deck_temp1{end}))>1
        deck1_check=true;
    end
    if sum(ismember(deck_temp2,deck_temp2{end}))>1
        deck2_check=true;
    end
    
    if deck1_check || deck2_check
        winner=1;
        deck=deck1;
        return
    elseif deck1(1)>length(deck1)-1 || deck2(1)>length(deck2)-1
        if deck1(1)>deck2(1)
            deck1(end+1:end+2)=[deck1(1);deck2(1)];
            deck1(1)=[];
            deck2(1)=[];
        else
            deck2(end+1:end+2)=[deck2(1);deck1(1)];
            deck1(1)=[];
            deck2(1)=[];
        end
    else
        subdeck1=deck1(2:deck1(1)+1);
        subdeck2=deck2(2:deck2(1)+1);
        winner_temp=recur_combat(subdeck1,subdeck2);
        switch winner_temp
            case 1
                deck1(end+1:end+2)=[deck1(1);deck2(1)];
                deck1(1)=[];
                deck2(1)=[];
            case 2
                deck2(end+1:end+2)=[deck2(1);deck1(1)];
                deck1(1)=[];
                deck2(1)=[];
        end
    end
end
if isempty(deck1)
    winner=2;
    deck=deck2;
else
    winner=1;
    deck=deck1;
end
end

