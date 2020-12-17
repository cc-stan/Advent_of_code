%% Main code

% Parsing
clear
input=fileread('input.txt');
input=regexp(splitlines(regexprep(regexprep(input,'#','1,'),'[.]','0,')),',','split');
input=str2double(vertcat(input{:}));
input=input(:,1:end-1);

% Part one
map3d=padarray(input,[1,1,1]);
for c=1:6
    map3d=newmap3d(map3d);
end
answer=sum(map3d,'all');

% Part two
map4d=padarray(input,[1,1,1,1]);
for c=1:6
    map4d=newmap4d(map4d);
end
answer(2)=sum(map4d,'all');

% Answers
fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% Function to create a new 3d map
function map=newmap3d(input)
    input=padarray(input,[1,1,1]);
    sz=size(input);
    N=length(sz);
    [c1{1:N}]=ndgrid(1:3);
    c2(1:N)={2};
    offsets=sub2ind(sz,c1{:})-sub2ind(sz,c2{:});
    map=false(size(input));
    for i=2:size(input,1)-1
        for j=2:size(input,2)-1
            for k=2:size(input,3)-1
                ngh=sum(input(sub2ind(sz,i,j,k)+offsets),'all');
                if (input(i,j,k)==0) && (ngh==3)
                    map(i,j,k)=1;
                elseif (input(i,j,k)==1) && (~all([3,4]~=ngh))
                    map(i,j,k)=1;
                end  
            end
        end
    end
end

% Function to create a new 4d map
function map=newmap4d(input)
    input=padarray(input,[1,1,1,1]);
    sz=size(input);
    N=length(sz);
    [c1{1:N}]=ndgrid(1:3);
    c2(1:N)={2};
    offsets=sub2ind(sz,c1{:})-sub2ind(sz,c2{:});
    map=false(size(input));
    for i=2:size(input,1)-1
        for j=2:size(input,2)-1
            for k=2:size(input,3)-1
                for l=2:size(input,4)-1
                    ngh=sum(input(sub2ind(sz,i,j,k,l)+offsets),'all');
                    if (input(i,j,k,l)==0) && (ngh==3)
                        map(i,j,k,l)=1;
                    elseif (input(i,j,k,l)==1) && (~all([3,4]~=ngh))
                        map(i,j,k,l)=1;
                    end  
                end
            end
        end
    end
end

