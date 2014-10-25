count=1;
num_components_iter1=size(tripcomp_1_sub,1);
tripcomp_2_sub = sparse(0,length(unique_sub));
tripcomp_2_verb =sparse(0,length(unique_verb));
tripcomp_2_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter1
    i
    [x,y,z]=find(tripcomp_1_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_1_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_1_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
   
    [x,y,z] = find(tripcomp_1_sub(:,sub));
    sub_set=x;
    [x,y,z] = find(tripcomp_1_verb(:,verb));
    verb_set=x;
    [x,y,z] = find(tripcomp_1_obj(:,obj));
    obj_set= x;
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
            candidate_set_sub=union(intersect(same_subject_set,verb_set),intersect(same_subject_set,obj_set));
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
        candidate_set_verb=union(intersect(same_verb_set,sub_set),intersect(same_verb_set,obj_set));
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
        candidate_set_obj=union(intersect(same_object_set,sub_set),intersect(same_object_set,verb_set));
    end
    common_context_set = intersect(sub_set,verb_set);
    candidate_set_obj=union(candidate_set_obj,common_context_set);
    
    final_candidate_set = intersect(intersect(candidate_set_sub,candidate_set_verb),candidate_set_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
%     count = count+length(final_candidate_set);
    candidate_subs=[];
    candidate_verb=[];
    candidate_obj=[];
    for k =1:length(final_candidate_set)
        [x,y,z]=find(tripcomp_1_sub(final_candidate_set(k),:));
        candidate_sub=union(y,sub);
        candidate_sub_words = unique_sub(candidate_sub);
        tripcomp_2_sub(count,candidate_subs)=1;
        [x,y,z]=find(tripcomp_1_verb(final_candidate_set(k),:));
        candidate_verb=union(y,verb);
        candidate_verb_words = unique_verb(candidate_verb);
        tripcomp_2_verb(count,candidate_verb)=1;
        [x,y,z]=find(tripcomp_1_obj(final_candidate_set(k),:));
        candidate_obj=union(y,obj);
        candidate_obj_words = unique_obj(candidate_obj);
        tripcomp_2_obj(count,candidate_obj)=1;
        count=count+1;
    end
    
    
%     tripcomp_2_sub = 
%     clear candidate_set_sub candidate_set_verb candidate_set_obj common_context_set
    %Calculate cost of merge
%     
%     sub = find(tripcomp_1_sub(final_candidate_set,:));
%     verb = find(tripcomp_1_verb(final_candidate_set,:));
%     obj = find(tripcomp_1_obj(final_candidate_set,:));  
%     
%     for j=1:length(final_candidate_set)
%         
%     end
    
    
end