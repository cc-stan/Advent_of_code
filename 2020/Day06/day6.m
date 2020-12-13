clear
[u,v,w,x]=deal(0,0,char(97:122),regexp(strsplit(fileread('list.txt'),'\r\n\r\n'),'\r\n','split'));
for i=1:length(x)
    [u,v]=deal(u+length(unique([x{i}{:}])),v+sum(sum(bsxfun(@eq,[x{i}{:}].',w))==length(x{i})));
end
disp(['Answer part one= ',num2str(u),newline,'Answer part one= ',num2str(v)])