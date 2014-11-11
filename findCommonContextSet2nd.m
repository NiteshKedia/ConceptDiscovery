function [ final_candidate_set ] = findCommonContextSet2nd(sub, verb, obj, tripcomp_sub, tripcomp_verb,tripcomp_obj )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
 %Get all the components where any of these subject, verb or object are
    %present and find unique
    [x,y,z] = find(tripcomp_sub(:,sub));
    sub_set=unique(x);
    [x,y,z] = find(tripcomp_verb(:,verb));
    verb_set=unique(x);
    [x,y,z] = find(tripcomp_obj(:,obj));
    obj_set= unique(x);
    
    % Find those components where all the subject and common verb/object is
    % present
    %sub
    candidate_set_sub=[];
    common_context_set=[];
    
    
    
    [x,y,z] = find(tripcomp_sub(:,sub(1)));
    same_subject_set= x;
    if(length(sub)>1)
        for j=2:length(sub)
            [x,y,z] = find(tripcomp_sub(:,sub(j)));
            same_subject_set = intersect(same_subject_set,x);
        end
    end
    if(~isempty(same_subject_set))
        for k=1:length(same_subject_set)
            [x,y,z] = find(tripcomp_sub(same_subject_set(k),:));
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
    
    
    
    
    [x,y,z] = find(tripcomp_verb(:,verb(1)));
    same_verb_set=x;
    if(length(verb)>1)
        for j=2:length(verb)
            [x,y,z] = find(tripcomp_verb(:,verb(j)));
            same_verb_set = intersect(same_verb_set,x);
        end
    end
    if(~isempty(same_verb_set))
        for k=1:length(same_verb_set)
            [x,y,z] = find(tripcomp_verb(same_verb_set(k),:));
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
    
    
    
    [x,y,z] = find(tripcomp_obj(:,obj(1)));
    same_object_set=x;
    if(length(obj)>1)
        for j=2:length(obj)
            [x,y,z] = find(tripcomp_obj(:,obj(j)));
            same_object_set = intersect(same_object_set,x);
        end
    end
    if(~isempty(same_object_set))
        for k=1:length(same_object_set)
            [x,y,z] = find(tripcomp_obj(same_object_set(k),:));
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

end

