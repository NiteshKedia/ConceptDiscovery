% Maximlaity: Remove subsets

new_tripcomp_2_sub = sparse(0,length(unique_sub));
new_tripcomp_2_verb =sparse(0,length(unique_verb));
new_tripcomp_2_obj =sparse(0,length(unique_obj));


num_components_iter2=size(tripcomp_2_sub,1);
k=1;
for i=1:num_components_iter2
    [x,y,z]=find(tripcomp_2_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_2_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_2_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    
    %Do not create a new component if this is a subset of already
    %existing one
    [x,y,z] = find(tripcomp_2_sub(:,sub(1)));
    same_subject_set= x;
    if(length(sub)>1)
        for j=2:length(sub)
            [x,y,z] = find(tripcomp_2_sub(:,sub(j)));
            same_subject_set = intersect(same_subject_set,x);
        end
    end
    [x,y,z] = find(tripcomp_2_verb(:,verb(1)));
    same_verb_set= x;
    if(length(verb)>1)
        for j=2:length(verb)
            [x,y,z] = find(tripcomp_2_verb(:,verb(j)));
            same_verb_set = intersect(same_verb_set,x);
        end
    end
    [x,y,z] = find(tripcomp_2_obj(:,obj(1)));
    same_obj_set= x;
    if(length(obj)>1)
        for j=2:length(obj)
            [x,y,z] = find(tripcomp_2_obj(:,obj(j)));
            same_obj_set = intersect(same_obj_set,x);
        end
    end
    intersection = intersect(intersect(same_subject_set,same_obj_set),same_verb_set);
    if(~isempty(setdiff(intersection,[i])))
        continue;
    else
        k
        new_tripcomp_2_sub(k,sub) = 1;
        new_tripcomp_2_verb(k,verb) = 1;
        new_tripcomp_2_obj(k,obj) = 1;
        k=k+1;
    end
end




tripcom2={};
for i=1:length(new_tripcomp_2_sub)
    [x,y,z]=find(new_tripcomp_2_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(new_tripcomp_2_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(new_tripcomp_2_obj(i,:));
    obj_words = unique_obj(y);
    tripcom2{i,1} = sub_words;
    tripcom2{i,2} = verb_words;
    tripcom2{i,3} = obj_words;
    
end

newsecondlevelGT = cell(length(tripcom2),3);
for i = 1 : length(tripcom2)
    for j = 1 : 3
        if (length(tripcom2{i,j}) > 1)
            str = strjoin(tripcom2{i,j}',';');
            newsecondlevelGT{i,j} = str;
        else
            newsecondlevelGT{i,j} = tripcom2{i,j};
        end
    end
end