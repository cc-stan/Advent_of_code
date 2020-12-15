clear
input=str2double(regexp(fileread('input.txt'),',','split'));
answer=mem_game(input,30000000);

function answer=mem_game(input,wn)
ind=1:length(input)+1;
val=[input,0];
    for i=length(ind):wn-1
         if all((val(1:end-1)==val(end))==0)
             val(end+1)=0;
             ind(end+1)=i+1;
         else
             ind_temp=find(val==val(end));
             val(end+1)=diff(ind(ind_temp));
             ind(end+1)=i+1;
             val(ind_temp(1))=[];
             ind(ind_temp(1))=[];             
         end             
    end
    answer=val(end);
end