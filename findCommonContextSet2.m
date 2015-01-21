function [ final_candidate_set ] = findCommonContextSet(sub, verb, obj, tripcomp_sub, tripcomp_verb,tripcomp_obj )
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
    candidate_set_sub=intersect(verb_set,obj_set);
    candidate_set_verb=intersect(sub_set,obj_set);
    candidate_set_obj=intersect(sub_set,verb_set);
        final_candidate_set = union(union(intersect(candidate_set_sub,candidate_set_verb),...
                                      intersect(candidate_set_obj,candidate_set_verb)),...
                                intersect(candidate_set_sub,candidate_set_obj));
%     final_candidate_set = union(union(candidate_set_sub,candidate_set_verb),candidate_set_obj);

end

