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
    
    
    final_candidate_set = intersect(intersect(sub_set,verb_set),obj_set);

end

