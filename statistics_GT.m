num_components_iter=size(tripcomp_7_sub,1);

tripcom7={};
for i=1:num_components_iter
    [x,y,z]=find(tripcomp_7_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_7_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_7_obj(i,:));
    obj_words = unique_obj(y);
    tripcom7{i,1} = sub_words;
    tripcom7{i,2} = verb_words;
    tripcom7{i,3} = obj_words;
    
end

for i=1:num_components_iter
    i
    % Find sub-verb-objs in a component
    [x,y,z]=find(tripcomp_7_sub(i,:));
    sub=y;
    [x,y,z]=find(tripcomp_7_verb(i,:));
    verb=y;
    [x,y,z]=find(tripcomp_7_obj(i,:));
    obj=y;
    
    sub_words = unique_sub(sub);
    obj_words = unique_obj(obj);
    verb_words= unique_verb(verb);
    
    %subject verb and object
    for j = 1 : 3
        if (length(tripcom7{i,j}) > 1)
            str = strjoin(tripcom7{i,j}',';');
            seventhlevelGT{i,j} = str;
        else
            seventhlevelGT{i,j} = tripcom7{i,j};
        end
    end
        %NUM of subject verb and objects
    seventhlevelGT{i,4} = length(sub);
    seventhlevelGT{i,5} = length(verb);
    seventhlevelGT{i,6} = length(obj);

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
    seventhlevelGT{i,7}=count/size(cartezianGT,1);

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
    seventhlevelGT{i,8}=count/size(cartezianGT,1);

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
    seventhlevelGT{i,9}=count/size(cartezianGT,1);
       
avg_similarity= sub_similarity_verb_overlap(sub,sub);
seventhlevelGT{i,10} = mean(avg_similarity(:));
avg_similarity = verb_similarity_subobj_overlap(verb,verb);
seventhlevelGT{i,11} = mean(avg_similarity(:));
avg_similarity = obj_similarity_verb_overlap(obj,obj);
seventhlevelGT{i,12} = mean(avg_similarity(:));
     
end