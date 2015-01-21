num_components_iter=size(tripcomp_sub_2,1);

tripcom={};
for i=1:num_components_iter
    i
    [x,y,z]=find(tripcomp_sub_2(i,:));
    sub=y;
    sub_words = unique_sub(y);
    [x,y,z]=find(tripcomp_verb_2(i,:));
    verb=y;
    verb_words= unique_verb(y);
    [x,y,z]=find(tripcomp_obj_2(i,:));
    obj=y;
    obj_words = unique_obj(y);
    tripcom{1} = sub_words;
    tripcom{2} = verb_words;
    tripcom{3} = obj_words;
    
    
    
    %subject verb and object
    for j = 1 : 3
        if (length(tripcom{j}) > 1)
            str = strjoin(tripcom{j}',';');
            GT2Stories{i,j} = str;
        else
            GT2Stories{i,j} = tripcom{j};
        end
    end
    %NUM of subject verb and objects
    ls = length(sub);lv = length(verb);lo = length(obj);
    GT2Stories{i,4} = ls;
    GT2Stories{i,5} = lv;
    GT2Stories{i,6} = lo;
    %
    %     %Precision
    %     [X,Y,Z] = meshgrid(sub,verb,obj);
    %     cartezianGT = [X(:) Y(:) Z(:)];
    %     count=0;
    %     for j=1:size(cartezianGT,1)
    %         a=find(ismember(unique_triplet_annotated(:,1),cartezianGT(j,1)));
    %         b=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,2)));
    %         c=find(ismember(unique_triplet_annotated(:,3),cartezianGT(j,3)));
    %         if(~isempty(intersect(a,intersect(b,c))))
    %             count=count+1;
    %         end
    %     end
    %     GT1_new{i,7}=count/size(cartezianGT,1);
    %
    %     [X,Y] = meshgrid(sub,verb);
    %     cartezianGT = [X(:) Y(:)];
    %     average_pmi_sv = 0;
    %     count=0;
    %     for j=1:size(cartezianGT,1)
    %         a=find(ismember(unique_triplet_annotated(:,1),cartezianGT(j,1)));
    %         b=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,2)));
    %         if(~isempty(intersect(a,b)))
    %             count=count+1;
    %         end
    %         average_pmi_sv = average_pmi_sv + pmi_subverb(cartezianGT(j,1),cartezianGT(j,2));
    %     end
    %     GT1_new{i,14} = average_pmi_sv/size(cartezianGT,1);
    %     GT1_new{i,8}=count/size(cartezianGT,1);
    %
    %     [X,Y] = meshgrid(verb,obj);
    %     cartezianGT = [X(:) Y(:)];
    %     average_pmi_vo = 0;
    %     count=0;
    %     for j=1:size(cartezianGT,1)
    %         a=find(ismember(unique_triplet_annotated(:,2),cartezianGT(j,1)));
    %         b=find(ismember(unique_triplet_annotated(:,3),cartezianGT(j,2)));
    %         if(~isempty(intersect(a,b)))
    %             count=count+1;
    %         end
    %         average_pmi_vo = average_pmi_vo + pmi_verbobj(cartezianGT(j,1),cartezianGT(j,2));
    %     end
    %     GT1_new{i,15} = average_pmi_sv/size(cartezianGT,1);
    %     GT1_new{i,9}=count/size(cartezianGT,1);
    %
    %     %Average Similarty Sub verb obj
    %     avg_similarity= sub_similarity_verb_overlap(sub,sub);
    %     GT1_new{i,10} = mean(avg_similarity(:));
    %     avg_similarity = verb_similarity_subobj_overlap(verb,verb);
    %     GT1_new{i,11} = mean(avg_similarity(:));
    %     avg_similarity = obj_similarity_verb_overlap(obj,obj);
    %     GT1_new{i,12} = mean(avg_similarity(:));
    %
    %     %Weighted Similarity
    %     GT1_new{i,13}= GT1_new{i,4}*GT1_new{i,10} + GT1_new{i,5}*GT1_new{i,11} + GT1_new{i,6}*GT1_new{i,12};
    %
end