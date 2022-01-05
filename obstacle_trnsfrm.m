map = zeros(15,15);
map(1,1:15) = 999;
map(1:15,1) = 999;
map(15,1:15) = 999;
map(1:15,15) = 999;
map(5,5:10) = 999;
for i = 1:15
    for j = 1:15
        if map(i,j) == 0
            if map(i+1,j)==999 || map(i+1,j+1)==999 || map(i,j+1)==999||map(i-1,j+1)==999||map(i+1,j-1)==999||map(i-1,j)==999||map(i,j-1)==999||map(i-1,j-1)==999
                map(i,j)=-1;
                continue;
            end           
        end
    end
end
for h = 1:1
    for i = 1:15
        for j = 1:15
            if map(i,j) == 0
                if map(i+1,j)==-h || map(i+1,j+1)==-h || map(i,j+1)==-h||map(i-1,j+1)==-h||map(i+1,j-1)==-h||map(i-1,j)==-h||map(i,j-1)==-h||map(i-1,j-1)==-h
                    map(i,j)=-h-8;
                    continue;
                end           
            end
        end
    end
end
for h = 9:14
    for i = 1:15
        for j = 1:15
            if map(i,j) == 0
                if map(i+1,j)==-h || map(i+1,j+1)==-h || map(i,j+1)==-h||map(i-1,j+1)==-h||map(i+1,j-1)==-h||map(i-1,j)==-h||map(i,j-1)==-h||map(i-1,j-1)==-h
                    map(i,j)=-h-1;
                    continue;
                end           
            end
        end
    end
end

