count=0;
num_components_iter1=size(tripcomp_1_sub,1);
tripcomp_2_sub = sparse(0,length(unique_sub));
tripcomp_2_verb =sparse(0,length(unique_verb));
tripcomp_2_obj =sparse(0,length(unique_obj));


for i=1:num_components_iter1
    i
    sub=find(tripcomp_1_sub(i,:));
    verb=find(tripcomp_1_verb(i,:));
    obj=find(tripcomp_1_obj(i,:));
   
    sub_set = find(tripcomp_1_sub(:,sub));
    verb_set = find(tripcomp_1_verb(:,verb));
    obj_set  = find(tripcomp_1_obj(:,obj));
    %sub
    candidate_set_sub=[];
    common_context_set=[];
    same_subject_set=find(tripcomp_1_sub(:,sub(1)));
    if(length(sub)>1)
        for j=2:length(sub)
        same_subject_set = intersect(same_subject_set,find(tripcomp_1_sub(:,sub(j))));
        end
    end
    if(~isempty(same_subject_set))
            candidate_set_sub=union(intersect(same_subject_set,verb_set),intersect(same_subject_set,obj_set));
    end
    common_context_set = intersect(verb_set,obj_set);
    candidate_set_sub=union(candidate_set_sub,common_context_set);
    
    %verb
    candidate_set_verb=[];
    same_verb_set=find(tripcomp_1_verb(:,verb(1)));
    if(length(verb)>1)
        for j=2:length(verb)
        same_verb_set = intersect(same_verb_set,find(tripcomp_1_verb(:,verb(j))));
        end
    end
    if(~isempty(same_verb_set))
        candidate_set_verb=union(intersect(same_verb_set,sub_set),intersect(same_verb_set,obj_set));
    end
    common_context_set = intersect(sub_set,obj_set);
    candidate_set_verb=union(candidate_set_verb,common_context_set);
    
    %obj
    candidate_set_obj=[];
    same_object_set=find(tripcomp_1_obj(:,obj(1)));
    if(length(obj)>1)
        for j=2:length(obj)
        same_object_set = intersect(same_object_set,find(tripcomp_1_obj(:,obj(j))));
        end
    end
    if(~isempty(same_object_set))
        candidate_set_obj=union(intersect(same_object_set,sub_set),intersect(same_object_set,verb_set));
    end
    common_context_set = intersect(sub_set,verb_set);
    candidate_set_obj=union(candidate_set_obj,common_context_set);
    
    final_candidate_set = intersect(intersect(candidate_set_sub,candidate_set_verb),candidate_set_obj);
    final_candidate_set = setdiff(final_candidate_set,1:i);
    count = count+length(final_candidate_set);
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