function [ cost ] = checkCost( t1,t2,unique_triplets )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    cost =0;
    temp_iter2=struct;
    temp_iter2.sub = union(t1.sub,t2.sub);
    temp_iter2.verb = union(t1.verb,t2.verb);
    temp_iter2.obj = union(t1.obj,t2.obj);
    
    total_count = length(temp_iter2.sub)*length(temp_iter2.verb)*length(temp_iter2.obj);
    temp_count=0;
    
    for i=1:length(temp_iter2.sub)
        for j= 1:length(temp_iter2.verb)
            for k = 1:length(temp_iter2.obj)
               if(intersect(intersect(find(ismember(unique_triplets(:,1), temp_iter2.sub(i))),find(ismember(unique_triplets(:,2), temp_iter2.verb(j)))),find(ismember(unique_triplets(:,3), temp_iter2.obj(k)))))
                   temp_count = temp_count+1;
               end 
            end
        end
    end
    if(temp_count/total_count > .8)
        cost = 1;
    end

end

