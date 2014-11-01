count=1;
num_components_iter1=size(tripcomp_2_sub,1);
tripcomp_3_sub = sparse(0,length(unique_sub));
tripcomp_3_verb =sparse(0,length(unique_verb));
tripcomp_3_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter1
    i
    [x,y,z]=find(tripcomp_2_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_2_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_2_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
%    if(length(sub)>50 || length(verb)>50 || length(obj)>50)
%        continue;
%    end
    [x,y,z] = find(tripcomp_2_sub(:,sub));
    sub_set=unique(x);
    [x,y,z] = find(tripcomp_2_verb(:,verb));
    verb_set=unique(x);
    [x,y,z] = find(tripcomp_2_obj(:,obj));
    obj_set= unique(x);
    %sub
    candidate_set_sub=[];
    common_context_set=[];
    [x,y,z] = find(tripcomp_2_sub(:,sub(1)));
    same_subject_set= x;
    if(length(sub)>1)
        for j=2:length(sub)
            [x,y,z] = find(tripcomp_2_sub(:,sub(j)));
            same_subject_set = intersect(same_subject_set,x);
        end
    end
    if(~isempty(same_subject_set))
            candidate_set_sub=union(intersect(same_subject_set,verb_set),intersect(same_subject_set,obj_set));
    end
    common_context_set = intersect(verb_set,obj_set);
    candidate_set_sub=union(candidate_set_sub,common_context_set);
    
    %verb
    candidate_set_verb=[];
    [x,y,z] = find(tripcomp_2_verb(:,verb(1)));
    same_verb_set=x;
    if(length(verb)>1)
        for j=2:length(verb)
            [x,y,z] = find(tripcomp_2_verb(:,verb(j)));
            same_verb_set = intersect(same_verb_set,x);
        end
    end
    if(~isempty(same_verb_set))
        candidate_set_verb=union(intersect(same_verb_set,sub_set),intersect(same_verb_set,obj_set));
    end
    common_context_set = intersect(sub_set,obj_set);
    candidate_set_verb=union(candidate_set_verb,common_context_set);
    
    %obj
    candidate_set_obj=[];
    [x,y,z] = find(tripcomp_2_obj(:,obj(1)));
    same_object_set=x;
    if(length(obj)>1)
        for j=2:length(obj)
            [x,y,z] = find(tripcomp_2_obj(:,obj(j)));
            same_object_set = intersect(same_object_set,x);
        end
    end
    if(~isempty(same_object_set))
        candidate_set_obj=union(intersect(same_object_set,sub_set),intersect(same_object_set,verb_set));
    end
    common_context_set = intersect(sub_set,verb_set);
    candidate_set_obj=union(candidate_set_obj,common_context_set);
    
    final_candidate_set = intersect(intersect(candidate_set_sub,candidate_set_verb),candidate_set_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
%     count = count+length(final_candidate_set);
    candidate_sub=[];
    candidate_verb=[];
    candidate_obj=[];
    
    for k =1:length(final_candidate_set)
         
        [x,y,z]=find(tripcomp_2_sub(final_candidate_set(k),:));
        candidate_sub=union(y,sub);
        candidate_sub_words = unique_sub(candidate_sub);
        
        [x,y,z]=find(tripcomp_2_verb(final_candidate_set(k),:));
        candidate_verb=union(y,verb);
        candidate_verb_words = unique_verb(candidate_verb);
        
        [x,y,z]=find(tripcomp_2_obj(final_candidate_set(k),:));
        candidate_obj=union(y,obj);
        candidate_obj_words = unique_obj(candidate_obj);
        
        %Find if the component already exists
        [x,y,z] = find(tripcomp_3_sub(:,candidate_sub(1)));
        same_subject_set= x;
        if(length(candidate_sub)>1)
            for j=2:length(candidate_sub)
                [x,y,z] = find(tripcomp_3_sub(:,candidate_sub(j)));
                same_subject_set = intersect(same_subject_set,x);
            end
        end
        [x,y,z] = find(tripcomp_3_obj(:,candidate_obj(1)));
        same_object_set= x;
        if(length(candidate_obj)>1)
            for j=2:length(candidate_obj)
                [x,y,z] = find(tripcomp_3_obj(:,candidate_obj(j)));
                same_object_set = intersect(same_object_set,x);
            end
        end
        [x,y,z] = find(tripcomp_3_verb(:,candidate_verb(1)));
        same_verb_set= x;
        if(length(candidate_verb)>1)
            for j=2:length(candidate_verb)
                [x,y,z] = find(tripcomp_3_verb(:,candidate_verb(j)));
                same_verb_set = intersect(same_verb_set,x);
            end
        end
        if(~isempty(intersect(intersect(same_subject_set,same_object_set),same_verb_set)))
            continue;
        else
             tripcomp_3_sub(count,candidate_sub)=1;
             tripcomp_3_verb(count,candidate_verb)=1;
             tripcomp_3_obj(count,candidate_obj)=1;
             count=count+1;
        end
    end
    
    
%     tripcomp_3_sub = 
%     clear candidate_set_sub candidate_set_verb candidate_set_obj common_context_set
    %Calculate cost of merge
%     
%     sub = find(tripcomp_2_sub(final_candidate_set,:));
%     verb = find(tripcomp_2_verb(final_candidate_set,:));
%     obj = find(tripcomp_2_obj(final_candidate_set,:));  
%     
%     for j=1:length(final_candidate_set)
%         
%     end
    
    
end