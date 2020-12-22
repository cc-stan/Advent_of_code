function [matches,edges]=check_match(tile1,tile2)
    matches=0;
    edges1(1:4,:)=[tile1(:,1)';tile1(:,end)';tile1(1,:);tile1(end,:)];
    edges1(5:8,:)=flip(edges1(1:4,:),2);
    edges2=[tile2(:,1)';tile2(:,end)';tile2(1,:);tile2(end,:)];
    edges=zeros(8,4);
    for i=1:4
       matches=matches+sum(all(edges1==edges2(i,:),2));
       edges(:,i)=all(edges1==edges2(i,:),2);
    end        
end