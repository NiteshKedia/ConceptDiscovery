function [ final_sub_intersection,final_verb_intersection,final_obj_intersection] = pruneMerge_cooccurence( unique_sub,unique_verb,unique_obj,sub1,sub2,verb1,verb2,obj1,obj2,sub_similarity,verb_similarity,obj_similarity,pmi_subverb,pmi_verbobj )


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

if(~isempty(sub_intersection))
    for i=1:length(sub_intersection)
        [xsorted is] = sort(pmi_subverb(sub_intersection(i),:),'descend');
        xsorted(xsorted==0) = [];
        is = is(1:min(1,length(xsorted)));
        verb_intersection = union(verb_intersection, intersect(verb_union,is));
    end
end

if(~isempty(obj_intersection))
    for i=1:length(obj_intersection)
        [xsorted is] = sort(pmi_verbobj(:,obj_intersection(i)),'descend');
        xsorted(xsorted==0) = [];
        is = is(1:min(1,length(xsorted)));
        verb_intersection = union(verb_intersection, intersect(verb_union,is));
    end
end

if(~isempty(verb_intersection))
    for i=1:length(verb_intersection)
        [xsorted is] = sort(pmi_subverb(:,verb_intersection(i)),'descend');
        xsorted(xsorted==0) = [];
        is = is(1:min(1,length(xsorted)));
        sub_intersection = union(sub_intersection, intersect(sub_union,is));
    end
end



%     obj_intersection = obj_union;
if(~isempty(verb_intersection))
    for i=1:length(verb_intersection)
        [xsorted is] = sort(pmi_verbobj(verb_intersection(i),:),'descend');
        xsorted(xsorted==0) = [];
        is = is(1:min(1,length(xsorted)));
        obj_intersection = union(obj_intersection, intersect(obj_union,is));
    end
end


current_subs = unique_sub(sub_intersection);
current_verb = unique_verb(verb_intersection);
current_objs = unique_obj(obj_intersection);


sub_diff = setdiff(sub_union,sub_intersection);
verb_diff = setdiff(verb_union,verb_intersection);
obj_diff = setdiff(obj_union,obj_intersection);

current_subs = unique_sub(sub_diff);
current_verb = unique_verb(verb_diff);
current_objs = unique_obj(obj_diff);

final_sub_intersection = sub_intersection;
final_verb_intersection = verb_intersection;
final_obj_intersection = obj_intersection;

if((length(sub1)-length(sub2)>7 && length(obj1)-length(obj2)>7) ||...
        ( length(verb1)-length(verb2)>7 && length(obj1)-length(obj2)>7) ||...
        (length(sub1)-length(sub2)>7 &&  length(verb1)-length(verb2)>7));
    final_sub_intersection=sub1;
    sub_diff=sub2;
    final_verb_intersection = verb1;
    verb_diff = verb2;
    final_obj_intersection = obj1;
    obj_diff = obj2;
elseif((length(sub2)-length(sub1)>7 && length(obj2)-length(obj1)>7) ||...
        ( length(verb2)-length(verb1)>7 && length(obj2)-length(obj1)>7) ||...
        (length(sub2)-length(sub1)>7 &&  length(verb2)-length(verb1)>7));
    final_sub_intersection=sub2;
    sub_diff=sub1;
    final_verb_intersection = verb2;
    verb_diff = verb1;
    final_obj_intersection = obj2;
    obj_diff = obj1;
end
if(length(sub_diff)~=0)
    for m =1:length(sub_diff)
        
        if(isempty(find(final_sub_intersection==sub_diff(m))))
            for l=1:length(final_sub_intersection)
                %                 test = [sub_similarity_verb_overlap(final_sub_intersection(l),:)];
                test = [sub_similarity(final_sub_intersection(l),:)];
                [xsorted is] = sort(test,'descend');
                xsorted(xsorted==0) = [];
                if(~isempty(find(is(1:min(3,length(xsorted)))==sub_diff(m))))
                    final_sub_intersection = union(final_sub_intersection,sub_diff(m));
                    %                     current_subs = unique_sub(final_sub_intersection);
                    break;
                end
            end
        end
    end
end



if(length(verb_diff)~=0)
    for m =1:length(verb_diff)
        if(isempty(find(final_verb_intersection==verb_diff(m))))
            for l=1:length(final_verb_intersection)
                test = [verb_similarity(final_verb_intersection(l),:)];
                [xsorted is] = sort(test,'descend');
                if(~isempty(find(is(1:min(3,length(xsorted)))==verb_diff(m))))
                    final_verb_intersection = union(final_verb_intersection,verb_diff(m));
                    current_verb = unique_verb(final_verb_intersection);
                    break;
                end
            end
        end
    end
end
if(length(obj_diff)~=0)
    for m =1:length(obj_diff)
        if(isempty(find(final_obj_intersection==obj_diff(m))))
            for l=1:length(final_obj_intersection)
                test = [obj_similarity(final_obj_intersection(l),:)];
                [xsorted is] = sort(test,'descend');
                if(~isempty(find(is(1:min(3,length(xsorted)))==obj_diff(m))))
                    final_obj_intersection = union(final_obj_intersection,obj_diff(m));
                    current_objs = unique_obj(final_obj_intersection);
                    break;
                end
            end
        end
    end
end

current_subs = unique_sub(final_sub_intersection);
current_verb = unique_verb(final_verb_intersection);
current_objs = unique_obj(final_obj_intersection);

% final_obj_intersection2=[];
% for i=1:length(final_obj_intersection)
%     [xsorted is] = sort(pmi_verbobj(:,final_obj_intersection(i)),'descend');
%     xsorted(xsorted==0) = [];
%     is = is(1:length(xsorted));
%     matched = find(ismember(final_verb_intersection,is));
%     if(length(matched)/length(final_verb_intersection)>.1)
%         final_obj_intersection2 = union(final_obj_intersection2,final_obj_intersection(i));
%     end
% end
%
% final_sub_intersection2=[];
% for i=1:length(final_sub_intersection)
%     [xsorted is] = sort(pmi_subverb(final_sub_intersection(i),:),'descend');
%     xsorted(xsorted==0) = [];
%     is = is(1:length(xsorted));
%     matched = find(ismember(final_verb_intersection,is));
%     if(length(matched)/length(final_verb_intersection)>.1)
%         final_sub_intersection2 = union(final_sub_intersection2,final_sub_intersection(i));
%     end
% end


end

