%BOTTOM UP APRIORI %First Iteration

[unique_subverb,~,ind] = unique(unique_triplet_annotated(:,[1,2]),'rows');
freq_unique_data = histc(ind,1:size(unique_subverb,1));
relevant_index = find(freq_unique_data>1);
relevant_unique_subverb = unique_subverb(relevant_index,:);

[unique_verbobj,~,ind] = unique(unique_triplet_annotated(:,[2,3]),'rows');
freq_unique_data = histc(ind,1:size(unique_verbobj,1));
relevant_index = find(freq_unique_data>1);
relevant_unique_verbobj = unique_verbobj(relevant_index,:);

[unique_subobj,~,ind] = unique(unique_triplet_annotated(:,[1,3]),'rows');
freq_unique_data = histc(ind,1:size(unique_subobj,1));
relevant_index = find(freq_unique_data>1);
relevant_unique_subobj = unique_subobj(relevant_index,:);


tripcomp_sub_1 =sparse(0,length(unique_sub));
tripcomp_verb_1 =sparse(0,length(unique_verb));
tripcomp_obj_1 =sparse(0,length(unique_obj));

count=0;
for i=1:length(relevant_unique_subverb)
    i
    tripcomp_sub_1(count+i,relevant_unique_subverb(i,1)) = 1 ;
    tripcomp_verb_1(count+i,relevant_unique_subverb(i,2)) = 1 ;
    
    %replace with loop in next iterations
    overlap_obj =  unique_triplet_annotated(intersect(find(unique_triplet_annotated(:,1)==relevant_unique_subverb(i,1)),find(unique_triplet_annotated(:,2)==relevant_unique_subverb(i,2))),3);
    tripcomp_obj_1(count+i,overlap_obj)=1;
end
count=count+i;
for i=1:length(relevant_unique_verbobj)
    i
    overlap_sub =  unique_triplet_annotated(intersect(find(unique_triplet_annotated(:,2)==relevant_unique_verbobj(i,1)),find(unique_triplet_annotated(:,3)==relevant_unique_verbobj(i,2))),1);
    tripcomp_sub_1(count+i,overlap_sub)=1;
    tripcomp_verb_1(count+i,relevant_unique_verbobj(i,1)) = 1 ;
    tripcomp_obj_1(count+i,relevant_unique_verbobj(i,2)) = 1 ;
    %replace with loop in next iterations
    
end
count=count+i;
for i=1:length(relevant_unique_subobj)
    i
    tripcomp_sub_1(count+i,relevant_unique_subobj(i,1)) = 1 ;
    overlap_verb =  unique_triplet_annotated(intersect(find(unique_triplet_annotated(:,1)==relevant_unique_subobj(i,1)),find(unique_triplet_annotated(:,3)==relevant_unique_subobj(i,2))),2);
    tripcomp_verb_1(count+i,overlap_verb)=1;
    tripcomp_obj_1(count+i,relevant_unique_subobj(i,2)) = 1 ;
    %replace with loop in next iterations
    
end
% count=count+i;
% % 
% for i=1:length(tripcomp_sub_1)
%     [x,y,z]=find(tripcomp_sub_1(i,:));
%     sub_words = unique_sub(y);
%     [x,y,z]=find(tripcomp_verb_1(i,:));
%     verb_words= unique_verb(y);
%     [x,y,z]=find(tripcomp_obj_1(i,:));
%     obj_words = unique_obj(y);
%     tripcom1{i,1} = sub_words;
%     tripcom1{i,2} = verb_words;
%     tripcom1{i,3} = obj_words;
%     
% end
% 
% 
% % serialize cell array into string
%     firstlevelGT = cell(length(tripcom1),3);
%     for i = 1 : length(tripcom1)
%         for j = 1 : 3
%             if (length(tripcom1{i,j}) > 1)
%                 str = strjoin(tripcom1{i,j}',';');
%                 firstlevelGT{i,j} = str;
%             else
%                 firstlevelGT{i,j} = tripcom1{i,j};
%             end
%         end
%     end
% 
% %     bottomup_2

final_bottomup