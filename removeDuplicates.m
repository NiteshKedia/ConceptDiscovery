function [ tripcompSub,tripcompVerb,tripcompObj,count ] = removeDuplicates( unique_sub,unique_verb,unique_obj,...
    sub_similarity,verb_similarity,obj_similarity,...
    final_sub_intersection,final_verb_intersection,final_obj_intersection,unique_triplet_annotated,...
    tripcompSub,tripcompVerb,tripcompObj,pmi_subverb,pmi_verbobj,count,H1 )
%             [x,y,z] = find(tripcompSub(:,final_sub_intersection));
%             final_sub_set=unique(x);
%             [x,y,z] = find(tripcompVerb(:,final_verb_intersection));
%             final_verb_set=unique(x);
%             [x,y,z] = find(tripcompObj(:,final_obj_intersection));
%             final_obj_set= unique(x);
%             final_candidate_set2 = intersect(intersect(final_sub_set,final_verb_set),final_obj_set);
final_candidate_set2 = findCommonContextSet(final_sub_intersection,final_verb_intersection,final_obj_intersection,tripcompSub,tripcompVerb,tripcompObj,unique_sub,unique_verb,unique_obj);
if(length(final_candidate_set2)~=0)
    for l=1:length(final_candidate_set2)
        [x,y,z]=find(tripcompSub(final_candidate_set2(l),:));
        final_candidate_sub=y;
        final_candidate_sub_words = unique_sub(y);
        
        [x,y,z]=find(tripcompVerb(final_candidate_set2(l),:));
        final_candidate_verb=y;
        final_candidate_verb_words = unique_verb(y);
        
        [x,y,z]=find(tripcompObj(final_candidate_set2(l),:));
        final_candidate_obj=y;
        final_candidate_obj_words = unique_obj(y);
        
        
        %Prune while merging
        [final_sub_intersection2,final_verb_intersection2,final_obj_intersection2] ...
            = pruneMerge_cooccurence(unique_sub,unique_verb,unique_obj,final_sub_intersection,final_candidate_sub,final_verb_intersection,final_candidate_verb,final_obj_intersection,final_candidate_obj,...
            sub_similarity,verb_similarity,obj_similarity,pmi_subverb,pmi_verbobj);
        
        if((length(final_sub_intersection2)==0 || length(final_verb_intersection2)==0 || length(final_obj_intersection2)==0)||...
                (length(final_sub_intersection)==1 && length(final_verb_intersection)==1 && length(final_obj_intersection)==1))
            continue;
        else
            
            %Classifier
            %                         feature = findFeaturesForClassifier(final_sub_intersection2,final_verb_intersection2,final_obj_intersection2,...
            %                                         unique_sub,unique_verb,unique_obj,unique_triplet_annotated,...
            %                                         sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,...
            %                                         pmi_subverb,pmi_verbobj);
            %                         [predict_label1, accuracy1, dec_values1] = svmpredict(1, feature, H1);
            %                         if(predict_label1==1)
            tripcompSub(final_candidate_set2(l),:) = 0;
            tripcompVerb(final_candidate_set2(l),:) = 0;
            tripcompObj(final_candidate_set2(l),:) = 0;
            tripcompSub(final_candidate_set2(l),final_sub_intersection2) = 1;
            tripcompVerb(final_candidate_set2(l),final_verb_intersection2) = 1;
            tripcompObj(final_candidate_set2(l),final_obj_intersection2) = 1;
            
            display(['Sub  :',strjoin(unique_sub(final_sub_intersection2)',';')]);
            display(['Verb  :',strjoin(unique_verb(final_verb_intersection2)',';')]);
            display(['Obj  :',strjoin(unique_obj(final_obj_intersection2)',';')]);
            display('*****************************************************');
            %                         end
            
        end
    end
else
    %Classifier
    %                 feature = findFeaturesForClassifier(final_sub_intersection,final_verb_intersection,final_obj_intersection,...
    %                                         unique_sub,unique_verb,unique_obj,unique_triplet_annotated,...
    %                                         sub_similarity_verb_overlap,verb_similarity_subobj_overlap,obj_similarity_verb_overlap,...
    %                                         pmi_subverb,pmi_verbobj);
    %                 [predict_label1, accuracy1, dec_values1] = svmpredict(1, feature, H1);
    %                 if(predict_label1==1)
    tripcompSub(count,final_sub_intersection) = 1;
    tripcompVerb(count,final_verb_intersection) = 1;
    tripcompObj(count,final_obj_intersection) = 1;
    display(['Sub  :',strjoin(unique_sub(final_sub_intersection)',';')]);
    display(['Verb  :',strjoin(unique_verb(final_verb_intersection)',';')]);
    display(['Obj  :',strjoin(unique_obj(final_obj_intersection)',';')]);
    display('*****************************************************');
    count=count+1;
    %                 end
end
end

