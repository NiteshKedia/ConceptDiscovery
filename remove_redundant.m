new_tripcomp_3_sub = sparse(0,length(unique_sub));
new_tripcomp_3_verb =sparse(0,length(unique_verb));
new_tripcomp_3_obj =sparse(0,length(unique_obj));
num_components_iter3=size(tripcomp_3_sub,1);
k=1;
found = 0;
for i=1:num_components_iter3
    i
    [x,y,z]=find(tripcomp_3_sub(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_3_verb(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_3_obj(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    for j=1:size(new_tripcomp_3_sub,1)
        [x,y,z]=find(new_tripcomp_3_sub(j,:));
        new_sub=y;
        new_sub_words = unique_sub(new_sub);
        [x,y,z]=find(new_tripcomp_3_verb(j,:));
        new_verb=y;
        new_verb_words= unique_verb(new_verb);
        [x,y,z]=find(new_tripcomp_3_obj(j,:));
        new_obj=y;
        new_obj_words = unique_obj(new_obj);
        jaccSim = nnz(intersect(sub,new_sub))/nnz(union(sub,new_sub)) + nnz(intersect(verb,new_verb))/nnz(union(verb,new_verb))+nnz(intersect(obj,new_obj))/nnz(union(obj,new_obj));
        found=0;
        if(jaccSim>1)
            found = 1;
            %New Code (Cost Function)
            %Get the intersection
            
            sub_intersection = intersect(sub,new_sub);
            verb_intersection = intersect(verb,new_verb);
            obj_intersection = intersect(obj,new_obj);
            current_subs = unique_sub(sub_intersection);
            current_verb = unique_verb(verb_intersection);
            current_objs = unique_obj(obj_intersection);
            
            
            %Get The union
            
            
            sub_union = union(sub,new_sub);
            verb_union = union(verb,new_verb);
            obj_union = union(obj,new_obj);
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
            new_tripcomp_3_sub(j,new_sub)=0;
            new_tripcomp_3_verb(j,new_verb)=0;
            new_tripcomp_3_obj(j,new_obj)=0 ;
            new_tripcomp_3_sub(j,final_sub_intersection)=1;
            new_tripcomp_3_verb(j,final_verb_intersection)=1;
            new_tripcomp_3_obj(j,final_obj_intersection)=1;
            
            
            
        end
    end
    if(found==0)
        new_tripcomp_3_sub(k,sub) = 1;
        new_tripcomp_3_verb(k,verb) = 1;
        new_tripcomp_3_obj(k,obj) = 1;
        k=k+1;
        
    end
end


