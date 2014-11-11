count=1;
num_components_iter1=size(tripcomp_1_sub,1);
tripcomp_2_sub = sparse(0,length(unique_sub));
tripcomp_2_verb =sparse(0,length(unique_verb));
tripcomp_2_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter1
    i
    
    % Find sub-verb-objs in a component
    [x,y,z]=find(tripcomp_1_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_1_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_1_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    
    %Get all the components where any of these subject, verb or object are
    %present and find unique
    [x,y,z] = find(tripcomp_1_sub(:,sub));
    sub_set=unique(x);
    [x,y,z] = find(tripcomp_1_verb(:,verb));
    verb_set=unique(x);
    [x,y,z] = find(tripcomp_1_obj(:,obj));
    obj_set= unique(x);
    
    % Find those components where all the subject and common verb/object is
    % present
    %sub
    candidate_set_sub=[];
    common_context_set=[];
    
    
    
    [x,y,z] = find(tripcomp_1_sub(:,sub(1)));
    same_subject_set= x;
    if(length(sub)>1)
        for j=2:length(sub)
            [x,y,z] = find(tripcomp_1_sub(:,sub(j)));
            same_subject_set = intersect(same_subject_set,x);
        end
    end
    if(~isempty(same_subject_set))
        for k=1:length(same_subject_set)
            [x,y,z] = find(tripcomp_1_sub(same_subject_set(k),:));
            if(length(sub)~=length(y))
                continue;
            else
                candidate_set_sub=union(candidate_set_sub,union(intersect(same_subject_set(k),verb_set),intersect(same_subject_set(k),obj_set)));
            end
        end
        
    end
    common_context_set = intersect(verb_set,obj_set);
    candidate_set_sub=union(candidate_set_sub,common_context_set);
    
    %verb
    candidate_set_verb=[];
    
    
    
    
    [x,y,z] = find(tripcomp_1_verb(:,verb(1)));
    same_verb_set=x;
    if(length(verb)>1)
        for j=2:length(verb)
            [x,y,z] = find(tripcomp_1_verb(:,verb(j)));
            same_verb_set = intersect(same_verb_set,x);
        end
    end
    if(~isempty(same_verb_set))
        for k=1:length(same_verb_set)
            [x,y,z] = find(tripcomp_1_verb(same_verb_set(k),:));
            if(length(verb)~=length(y))
                continue;
            else
                candidate_set_verb=union(candidate_set_verb,union(intersect(same_verb_set(k),sub_set),intersect(same_verb_set(k),obj_set)));
            end
        end
        
    end
    common_context_set = intersect(sub_set,obj_set);
    candidate_set_verb=union(candidate_set_verb,common_context_set);
    
    %obj
    candidate_set_obj=[];
    
    
    
    [x,y,z] = find(tripcomp_1_obj(:,obj(1)));
    same_object_set=x;
    if(length(obj)>1)
        for j=2:length(obj)
            [x,y,z] = find(tripcomp_1_obj(:,obj(j)));
            same_object_set = intersect(same_object_set,x);
        end
    end
    if(~isempty(same_object_set))
        for k=1:length(same_object_set)
            [x,y,z] = find(tripcomp_1_obj(same_object_set(k),:));
            if(length(obj)~=length(y))
                continue;
            else
                candidate_set_obj=union(candidate_set_obj,union(intersect(same_object_set(k),sub_set),intersect(same_object_set(k),verb_set)));
            end
        end
        
    end
    common_context_set = intersect(sub_set,verb_set);
    candidate_set_obj=union(candidate_set_obj,common_context_set);
    
    final_candidate_set = intersect(intersect(candidate_set_sub,candidate_set_verb),candidate_set_obj);
    
    %Not counting already encountered components
    final_candidate_set = setdiff(final_candidate_set,1:i);
    %   count = count+length(final_candidate_set);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    
    %Creating components
    for k =1:length(final_candidate_set)
        
        [x,y,z]=find(tripcomp_1_sub(final_candidate_set(k),:));
        candidate_sub=y;
        candidate_sub_words = unique_sub(y);
        
        [x,y,z]=find(tripcomp_1_verb(final_candidate_set(k),:));
        candidate_verb=y;
        candidate_verb_words = unique_verb(y);
        
        [x,y,z]=find(tripcomp_1_obj(final_candidate_set(k),:));
        candidate_obj=y;
        candidate_obj_words = unique_obj(y);
        
        %New Code (Cost Function)
        %Get the intersection
        
        sub_intersection = intersect(sub,candidate_sub);
        verb_intersection = intersect(verb,candidate_verb);
        obj_intersection = intersect(obj,candidate_obj);
        current_subs = unique_sub(sub_intersection);
        current_verb = unique_verb(verb_intersection);
        current_objs = unique_obj(obj_intersection);
        
        
        %Get The union
        
        
        sub_union = union(sub,candidate_sub);
        verb_union = union(verb,candidate_verb);
        obj_union = union(obj,candidate_obj);
        current_subs = unique_sub(sub_union);
        current_verb = unique_verb(verb_union);
        current_objs = unique_obj(obj_union);
        %get the difference of union and intersection
        if(isempty(sub_intersection))
            sub_intersection = sub;
        end
        if(isempty(verb_intersection))
            verb_intersection = verb;
        end
        if(isempty(obj_intersection))
            obj_intersection = obj;
        end
        sub_diff = setdiff(sub_union,sub_intersection);
        verb_diff = setdiff(verb_union,verb_intersection);
        obj_diff = setdiff(obj_union,obj_intersection);
        final_sub_intersection = sub_intersection;
        final_verb_intersection = verb_intersection;
        final_obj_intersection = obj_intersection;
        if(length(sub_diff)~=0)
            for m =1:length(sub_diff)
                
                if(isempty(find(final_sub_intersection==sub_diff(m))))
                    for l=1:length(sub_intersection)
                        test = [sub_similarity_verb_overlap(sub_intersection(l),:)];
                        [xsorted is] = sort(test,'descend');
                        if(~isempty(find(is(1:50)==sub_diff(m))))
                            final_sub_intersection = union(final_sub_intersection,sub_diff(m));
                            current_subs = unique_sub(final_sub_intersection);
                        end
                    end
                end
                end
        end
        
        
        
        if(length(verb_diff)~=0)
            for m =1:length(verb_diff)
                if(isempty(find(final_verb_intersection==verb_diff(m))))
                    for l=1:length(verb_intersection)
                        test = [verb_similarity_subobj_overlap(verb_intersection(l),:)];
                        [xsorted is] = sort(test,'descend');
                        if(~isempty(find(is(1:50)==verb_diff(m))))
                            final_verb_intersection = union(final_verb_intersection,verb_diff(m));
                            current_verb = unique_verb(final_verb_intersection);
                        end
                    end
                end
            end
        end
        if(length(obj_diff)~=0)
            for m =1:length(obj_diff)
                if(isempty(find(final_obj_intersection==obj_diff(m))))
                    for l=1:length(obj_intersection)
                        test = [obj_similarity_verb_overlap(obj_intersection(l),:)];
                        [xsorted is] = sort(test,'descend');
                        if(~isempty(find(is(1:50)==obj_diff(m))))
                            final_obj_intersection = union(final_obj_intersection,obj_diff(m));
                            current_objs = unique_obj(final_obj_intersection);
                        end
                    end
                end
            end
        end
        
        %Do not create a new component if this is a subset of already
        %existing one
        [x,y,z] = find(tripcomp_2_sub(:,final_sub_intersection(1)));
        same_subject_set= x;
        if(length(final_sub_intersection)>1)
            for j=2:length(final_sub_intersection)
                [x,y,z] = find(tripcomp_2_sub(:,final_sub_intersection(j)));
                same_subject_set = intersect(same_subject_set,x);
            end
        end
        [x,y,z] = find(tripcomp_2_verb(:,final_verb_intersection(1)));
        same_verb_set= x;
        if(length(final_verb_intersection)>1)
            for j=2:length(final_verb_intersection)
                [x,y,z] = find(tripcomp_2_verb(:,final_verb_intersection(j)));
                same_verb_set = intersect(same_verb_set,x);
            end
        end
        [x,y,z] = find(tripcomp_2_obj(:,final_obj_intersection(1)));
        same_obj_set= x;
        if(length(final_obj_intersection)>1)
            for j=2:length(final_obj_intersection)
                [x,y,z] = find(tripcomp_2_obj(:,final_obj_intersection(j)));
                same_obj_set = intersect(same_obj_set,x);
            end
        end
        if(~isempty(intersect(intersect(same_subject_set,same_obj_set),same_verb_set)))
            continue;
        else
            tripcomp_2_sub(count,final_sub_intersection)=1;
            tripcomp_2_verb(count,final_verb_intersection)=1;
            tripcomp_2_obj(count,final_obj_intersection)=1;
            count=count+1;
        end
    end
end

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
        new_tripcomp_2_sub(k,sub) = 1;
        new_tripcomp_2_verb(k,verb) = 1;
        new_tripcomp_2_obj(k,obj) = 1;
        k=k+1;
    end
end

tripcomp_2_sub=new_tripcomp_2_sub;
tripcomp_2_verb=new_tripcomp_2_verb;
tripcomp_2_obj=new_tripcomp_2_obj;


%Make the GTs view-able
tripcom2={};
for i=1:length(tripcomp_2_sub)
    [x,y,z]=find(tripcomp_2_sub(i,:));
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_2_verb(i,:));
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_2_obj(i,:));
    obj_words = unique_obj(y);
    tripcom2{i,1} = sub_words;
    tripcom2{i,2} = verb_words;
    tripcom2{i,3} = obj_words;
    
end

% Serialise the GTs
secondlevelGT = cell(length(tripcom2),3);
for i = 1 : length(tripcom2)
    for j = 1 : 3
        if (length(tripcom2{i,j}) > 1)
            str = strjoin(tripcom2{i,j}',';');
            secondlevelGT{i,j} = str;
        else
            secondlevelGT{i,j} = tripcom2{i,j};
        end
    end
end

bottomup_3