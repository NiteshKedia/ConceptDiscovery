num_components_iter=size(tripcomp_sub_4Copy,1);
tripcomp_sub_4 = sparse(0,length(unique_sub));
tripcomp_verb_4 =sparse(0,length(unique_verb));
tripcomp_obj_4 =sparse(0,length(unique_obj));
iterations=4;
count=1;
for i=1:num_components_iter
    i
    [x,y,z]=find(tripcomp_sub_4Copy(i,:));
    sub=y;
    sub_words = unique_sub(sub);
    [x,y,z]=find(tripcomp_verb_4Copy(i,:));
    verb=y;
    verb_words= unique_verb(verb);
    [x,y,z]=find(tripcomp_obj_4Copy(i,:));
    obj=y;
    obj_words = unique_obj(obj);
    if(size(sub,2)>7 || size(verb,2)>7 || size(obj,2)>7)
        continue;
    else
        tripcomp_sub_4(count,sub) = 1;
        tripcomp_verb_4(count,verb) = 1;
        tripcomp_obj_4(count,obj) = 1;
        count=count+1;
    end
   
end
GT_4_new={};
 eval(['GT_' num2str(iterations) '_new = calcStatistics(tripcomp_sub_4,tripcomp_verb_4,tripcomp_obj_4,unique_sub,unique_verb,unique_obj,unique_triplet_annotated,sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj);']);
