test=9;
valid=0;
invalid=0;
for i=1:2^(test+1)
    ind=[];
    V_test=[0,(1:test+1)+2];
    bin=dec2bin(i-1,test+1);
    
    for j=1:length(bin)
        if bin(j)=='1'
            ind=[ind,j];
        end
    end
    V_test(ind+1)=[];
    V2_test=[V_test(2:end),test+6];
    Diff_2=V2_test-V_test;
    if any(Diff_2>3)
        invalid=invalid+1;
    else 
        valid=valid+1;
    end    
end
