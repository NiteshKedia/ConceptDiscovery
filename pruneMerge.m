function [ final_sub_intersection,final_verb_intersection,final_obj_intersection ] = pruneMerge( unique_sub,unique_verb,unique_obj,sub1,sub2,verb1,verb2,obj1,obj2,sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
        sub_intersection = intersect(sub1,sub2);
        verb_intersection = intersect(verb1,verb2);
        obj_intersection = intersect(obj1,obj2);
        current_subs = unique_sub(sub_intersection);
        current_verb = unique_verb(verb_intersection);
        current_objs = unique_obj(obj_intersection);
        
        
        %Get The union
        
        
        sub_union = union(sub1,sub2);
        verb_union = union(verb1,verb2);
        obj_union = union(obj1,obj2);
        current_subs = unique_sub(sub_union);
        current_verb = unique_verb(verb_union);
        current_objs = unique_obj(obj_union);
        %get the difference of union and intersection
        if(isempty(sub_intersection))
            sub_intersection = sub_union;
        end
        if(isempty(verb_intersection))
            verb_intersection = verb_union;
        end
        if(isempty(obj_intersection))
            obj_intersection = obj_union;
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
                        if(~isempty(find(is(1:100)==sub_diff(m))))
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
                        if(~isempty(find(is(1:100)==verb_diff(m))))
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
                        if(~isempty(find(is(1:100)==obj_diff(m))))
                            final_obj_intersection = union(final_obj_intersection,obj_diff(m));
                            current_objs = unique_obj(final_obj_intersection);
                        end
                    end
                end
            end
        end

end

