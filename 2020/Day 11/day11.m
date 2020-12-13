%% Main code

% Load list
clear
M=regexp(splitlines(regexprep(regexprep(fileread('list.txt'),'L','0 '),'[.]','NaN ')),' ','split');
M=vertcat(M{:});
M(:,end)=[];
M=str2double(M);

M_2=zeros(size(M)+2);
M_2(2:end-1,2:end-1)=M;

%% Part one

% Create a transformation matrix to transform the map (M) to a matrix where
% each row contains the values of the neighbors
n=size(M);
[I,J,dI,dJ]=ndgrid(1:n(1),1:n(2),-1:1,-1:1);
I=reshape(I+dI,[],9); clear dI
J=reshape(J+dJ,[],9); clear dJ
valid=(I>=1 & I<=n(1)) &  (J>=1 & J<=n(2));
I(~valid)=nan;
J(~valid)=nan;
lookup=sub2ind([n(1),n(2)],I,J);
lookup(~valid)=1;
lookup(:,5)=[];
valid(:,5)=[];
mask=double(valid); mask(~valid)=nan;
neighbors=M(lookup).*mask;

% Update the map till no changes happen anymore
check=false;
check_new=0;

filename='seats.gif';
n=1;
h=figure;

colormap([0,1,0;1,0,0])
while check==false
    
    
    check_prev=check_new;
    M=newmap(M,lookup,mask);
    check_new=nansum(M,'all');
    check=check_new==check_prev;
    
    pcolor(M)
    caption=sprintf('Occupied seats=%d',check_new);
    caption_2=sprintf('Free seats=%d',7179-check_new);
    text(15, -7, caption,'Color',[1,0,0], 'FontSize', 10);
    text(53, -7, caption_2,'Color',[0,1,0], 'FontSize', 10);
    frame=getframe(h);
    im=frame2im(frame);
    [imind,cm]=rgb2ind(im,256);

    
    if n==1 
        imwrite(imind,cm,filename,'gif','DelayTime',0.1,'Loopcount',inf);
    elseif mod(n+1,2)==0
        imwrite(imind,cm,filename,'gif','DelayTime',0.1,'WriteMode','append');
    end
    n=n+1;
end
answer=check_new;

%% Part two

% Update the map till no changes happen anymore
check=false;
check_new=0;

while check==false
    check_prev=check_new;
    mask_next_occ=false(size(M)+2);
    mask_next_emp=false(size(M)+2);
    for i=1:size(M,1)
        for j=1:size(M,2)
            mask_next_occ(i+1,j+1)=(M_2(i+1,j+1)==0) && (neighbors_total(M_2,i+1,j+1)==0);
            mask_next_emp(i+1,j+1)=(M_2(i+1,j+1)==1) && (neighbors_total(M_2,i+1,j+1)>4);
        end
    end
    M_2(mask_next_occ)=1;
    M_2(mask_next_emp)=0;
    check_new=nansum(M_2,'all');
    check=check_new==check_prev;
end
answer(2)=check_new;

%% Answers

fprintf('Answer to part one= %d\nAnswer to part two= %d\n',answer(1),answer(2))

%% Functions

% function to update the map for part one
function M=newmap(M,lookup,mask)
    neighbors=reshape(nansum(M(lookup).*mask,2),[],94);
    mask_next_occ=false(size(M));
    mask_next_emp=false(size(M));
    for i=1:size(M,1)
        for j=1:size(M,2)
            mask_next_occ(i,j)=(M(i,j)==0) && (neighbors(i,j)==0);
            mask_next_emp(i,j)=(M(i,j)==1) && (neighbors(i,j)>3);
        end
    end
    M(mask_next_occ)=1;
    M(mask_next_emp)=0;
end

% function to find the amount of occupied seats within all lines of sight
function neighbors_2=neighbors_total(M,i,j)
    neighbors_2=0;
    for k=1:8
        switch k
            case 1
                neighbors_2=neighbor_los(M,i,j,0,1,0,0,false,neighbors_2);
            case 2
                neighbors_2=neighbor_los(M,i,j,1,1,0,0,false,neighbors_2);
            case 3
                neighbors_2=neighbor_los(M,i,j,1,0,0,0,false,neighbors_2);
            case 4
                neighbors_2=neighbor_los(M,i,j,1,-1,0,0,false,neighbors_2);
            case 5
                neighbors_2=neighbor_los(M,i,j,0,-1,0,0,false,neighbors_2);
            case 6
                neighbors_2=neighbor_los(M,i,j,-1,-1,0,0,false,neighbors_2);
            case 7
                neighbors_2=neighbor_los(M,i,j,-1,0,0,0,false,neighbors_2);
            case 8
                neighbors_2=neighbor_los(M,i,j,-1,1,0,0,false,neighbors_2);
        end
    end
end

% function to find the amount of occupied seats within line of sight
function neighbors=neighbor_los(M,i,j,x,y,x_temp,y_temp,check,neighbors)
    while check==false
        x_temp=x_temp+x;
        y_temp=y_temp+y;
        if M(i+x_temp,j+y_temp)==0
            check=true;
        elseif M(i+x_temp,j+y_temp)==1
            check=true;
            neighbors=neighbors+1;
        end
    end
end

