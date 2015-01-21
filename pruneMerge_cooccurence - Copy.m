function [ final_sub_intersection2,final_verb_intersection,final_obj_intersection2 ] = pruneMerge_cooccurence( unique_sub,unique_verb,unique_obj,sub1,sub2,verb1,verb2,obj1,obj2,sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj )

current_sub1 = unique_sub(sub1);
current_ver1 = unique_verb(verb1);
current_obj1 = unique_obj(obj1);

current_sub2 = unique_sub(sub2);
current_ver2 = unique_verb(verb2);
current_obj2 = unique_obj(obj2);


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
                if(~isempty(find(is(1:150)==sub_diff(m))))
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
                if(~isempty(find(is(1:150)==verb_diff(m))))
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
                if(~isempty(find(is(1:150)==obj_diff(m))))
                    final_obj_intersection = union(final_obj_intersection,obj_diff(m));
                    current_objs = unique_obj(final_obj_intersection);
                end
            end
        end
    end
end
final_obj_intersection2=[];
for i=1:length(final_obj_intersection)
    [xsorted is] = sort(pmi_verbobj(:,final_obj_intersection(i)),'descend');
    xsorted(xsorted==0) = [];
    is = is(1:length(xsorted));
    matched = find(ismember(final_verb_intersection,is));
    if(length(matched)/length(final_verb_intersection)>.4)
        final_obj_intersection2 = union(final_obj_intersection2,final_obj_intersection(i));
    end
end

final_sub_intersection2=[];
for i=1:length(final_sub_intersection)
    [xsorted is] = sort(pmi_subverb(final_sub_intersection(i),:),'descend');
    xsorted(xsorted==0) = [];
    is = is(1:length(xsorted));
    matched = find(ismember(final_verb_intersection,is));
    if(length(matched)/length(final_verb_intersection)>.4)
        final_sub_intersection2 = union(final_sub_intersection2,final_sub_intersection(i));
    end
end


end

