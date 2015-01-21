function [ feature ] = findFeaturesForClassifier( tripcomp_sub,tripcomp_verb,tripcomp_obj,unique_sub,unique_verb,unique_obj,unique_triplet_annotated,sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,pmi_subverb,pmi_verbobj)


    
    
    %NUM of subject verb and objects
    ls = length(tripcomp_sub);lv = length(tripcomp_verb);lo = length(tripcomp_obj);
%     feature(1) = ls/(ls+lv+lo);
%    feature(2)= lv/(ls+lv+lo);
%      feature(3) = lo/(ls+lv+lo);
    
    %Precision
    [X,Y,Z] = meshgrid(tripcomp_sub,tripcomp_verb,tripcomp_obj);
    cartezianGT = [X(:) Y(:) Z(:)];
    count=0;
    for j=1:size(cartezianGT,1)
        a=find(ismember(unique_triplet_annotated(:,1),cartezianGT(j,1)));
        b=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,2)));
        c=find(ismember(unique_triplet_annotated(:,3),cartezianGT(j,3)));
        if(~isempty(intersect(a,intersect(b,c))))
            count=count+1;
        end
    end
   feature(1)=count/size(cartezianGT,1);
    
    [X,Y] = meshgrid(tripcomp_sub,tripcomp_verb);
    cartezianGT = [X(:) Y(:)];
    average_pmi_sv = 0;
    count=0;
    for j=1:size(cartezianGT,1)
%         a=find(ismember(unique_triplet_annotated(:,1),cartezianGT(j,1)));
%         b=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,2)));
%         if(~isempty(intersect(a,b)))
%             count=count+1;
%         end
        average_pmi_sv = average_pmi_sv + pmi_subverb(cartezianGT(j,1),cartezianGT(j,2));
    end
    feature(2) = average_pmi_sv/size(cartezianGT,1);
%      feature(5)=count/size(cartezianGT,1);
    
    [X,Y] = meshgrid(tripcomp_verb,tripcomp_obj);
    cartezianGT = [X(:) Y(:)];
    average_pmi_vo = 0;
    count=0;
    for j=1:size(cartezianGT,1)
%         a=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,1)));
%         b=find(ismember(unique_triplet_annotated(:,3),cartezianGT(j,2)));
%         if(~isempty(intersect(a,b)))
%             count=count+1;
%         end
        average_pmi_vo = average_pmi_vo + pmi_verbobj(cartezianGT(j,1),cartezianGT(j,2));
    end
    feature(3) = average_pmi_sv/size(cartezianGT,1);
%      feature(6)=count/size(cartezianGT,1);
    
    %Average Similarty Sub verb obj
    avg_similarity= sub_similarity_verb_overlap(tripcomp_sub,tripcomp_sub);
     avg_similarity_s = mean(avg_similarity(:));
    avg_similarity = verb_similarity_subobj_overlap(tripcomp_verb,tripcomp_verb);
     avg_similarity_v = mean(avg_similarity(:));
    avg_similarity = obj_similarity_verb_overlap(tripcomp_obj,tripcomp_obj);
     avg_similarity_o = mean(avg_similarity(:));
    
    %Weighted Similarity
    feature(4)= ls*avg_similarity_s + lv*avg_similarity_v + lv*avg_similarity_o;    
end


