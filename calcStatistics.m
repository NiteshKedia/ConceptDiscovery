function [ GT ] = calcStatistics( tripcomp_sub,tripcomp_verb,tripcomp_obj,unique_sub,unique_verb,unique_obj,unique_triplet_annotated,sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
display('Calculating Statistics......');

num_components_iter=size(tripcomp_sub,1);

tripcom={};
for i=1:num_components_iter
    [x,y,z]=find(tripcomp_sub(i,:));
    sub=y;
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_verb(i,:));
    verb=y;
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_obj(i,:));
    obj=y;
    obj_words = unique_obj(y);
    tripcom{1} = sub_words;
    tripcom{2} = verb_words;
    tripcom{3} = obj_words;
    
    
    
    %subject verb and object
    for j = 1 : 3
        if (length(tripcom{j}) > 1)
            str = strjoin(tripcom{j}',';');
            GT{i,j} = str;
        else
            GT{i,j} = tripcom{j};
        end
    end
    %NUM of subject verb and objects
    GT{i,4} = length(sub);
    GT{i,5} = length(verb);
    GT{i,6} = length(obj);
    
    %Precision
    [X,Y,Z] = meshgrid(sub,verb,obj);
    cartezianGT = [X(:) Y(:) Z(:)];
    count=0;
    for j=1:size(cartezianGT,1)
        a=find(ismember(unique_triplet_annotated(:,1),cartezianGT(j,1)));
        b=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,2)));
        c=find(ismember(unique_triplet_annotated(:,3),cartezianGT(j,3)));
        if(~isempty(intersect(a,intersect(b,c))))
            count=count+1;
        end
    end
    GT{i,7}=count/size(cartezianGT,1);
    
    [X,Y] = meshgrid(sub,verb);
    cartezianGT = [X(:) Y(:)];
    count=0;
    for j=1:size(cartezianGT,1)
        a=find(ismember(unique_triplet_annotated(:,1),cartezianGT(j,1)));
        b=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,2)));
        if(~isempty(intersect(a,b)))
            count=count+1;
        end
    end
    GT{i,8}=count/size(cartezianGT,1);
    
    [X,Y] = meshgrid(verb,obj);
    cartezianGT = [X(:) Y(:)];
    count=0;
    for j=1:size(cartezianGT,1)
        a=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,1)));
        b=find(ismember(unique_triplet_annotated(:,3),cartezianGT(j,2)));
        if(~isempty(intersect(a,b)))
            count=count+1;
        end
    end
    GT{i,9}=count/size(cartezianGT,1);
    
    avg_similarity= sub_similarity_verb_overlap(sub,sub);
    GT{i,10} = mean(avg_similarity(:));
    avg_similarity = verb_similarity_subobj_overlap(verb,verb);
    GT{i,11} = mean(avg_similarity(:));
    avg_similarity = obj_similarity_verb_overlap(obj,obj);
    GT{i,12} = mean(avg_similarity(:));
    
end

end

