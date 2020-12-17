clear
input=fileread('input.txt');
input=regexp(splitlines(regexprep(regexprep(input,'#','1,'),'[.]','0,')),',','split');
input=str2double(vertcat(input{:}));
input=input(:,1:end-1);

cyc=6;
b=2;
input_temp=input;
input=zeros(size(input)+2*cyc+b);
input(cyc+1+b/2:cyc+b/2+size(input_temp,1),cyc+b/2+1:cyc+b/2+size(input_temp,2))=input_temp;
input_temp=input;
input=zeros(size(input,1),size(input,2),2*cyc+b+size(input,3));
input(:,:,ceil(size(input,3)/2))=input_temp;

for c=1:cyc
    map=false(size(input));
    for i=2:size(input,1)-1
        for j=2:size(input,2)-1
            for k=2:size(input,3)-1
                ngh=num_ngh(i,j,k,input);
                if (input(i,j,k)==0) && (ngh==3)
                    map(i,j,k)=1;
                elseif (input(i,j,k)==1) && (~all([2,3]~=ngh))
                    map(i,j,k)=1;
                else
                    map(i,j,k)=0;
                end                   
            end
        end
    end
    input=map;
end
answer=sum(map,'all');

function ngh=num_ngh(x,y,z,input)
point=false(size(input));
point(x,y,z)=true;
mask=imdilate(point,ones(3,3,3));
ngh=reshape(input(mask),3,3,3);
ngh(2,2,2)=0;
ngh=sum(ngh,'all');
end
