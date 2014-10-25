%BOTTOM UP APRIORI %First Iteration

unique_triplet_annotated = zeros(length(unique_triplets),3);
for i = 1:length(unique_triplets)
    unique_triplet_annotated(i,:) = [find(ismember(unique_sub,unique_triplets(i,1))) 
                                        find(ismember(unique_verb,unique_triplets(i,2)))
                                               find(ismember(unique_obj,unique_triplets(i,3))) ];
end

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


tripcomp_1_sub =sparse(0,length(unique_sub));
tripcomp_1_verb =sparse(0,length(unique_verb));
tripcomp_1_obj =sparse(0,length(unique_obj));

count=0;
for i=1:length(relevant_unique_subverb)
    i
    tripcomp_1_sub(count+i,relevant_unique_subverb(i,1)) = 1 ;
    tripcomp_1_verb(count+i,relevant_unique_subverb(i,2)) = 1 ;
    
    %replace with loop in next iterations
    overlap_obj =  unique_triplet_annotated(intersect(find(unique_triplet_annotated(:,1)==relevant_unique_subverb(i,1)),find(unique_triplet_annotated(:,2)==relevant_unique_subverb(i,2))),3);
    tripcomp_1_obj(count+i,overlap_obj)=1;
end
count=count+i;
for i=1:length(relevant_unique_verbobj)
    i
    overlap_sub =  unique_triplet_annotated(intersect(find(unique_triplet_annotated(:,2)==relevant_unique_verbobj(i,1)),find(unique_triplet_annotated(:,3)==relevant_unique_subverb(i,2))),1);
    tripcomp_1_sub(count+i,overlap_sub)=1;
    tripcomp_1_verb(count+i,relevant_unique_verbobj(i,1)) = 1 ;
    tripcomp_1_obj(count+i,relevant_unique_verbobj(i,2)) = 1 ;
    %replace with loop in next iterations
    
end
count=count+i;
for i=1:length(relevant_unique_subobj)
    i
    tripcomp_1_sub(count+i,relevant_unique_subobj(i,1)) = 1 ;
    overlap_verb =  unique_triplet_annotated(intersect(find(unique_triplet_annotated(:,1)==relevant_unique_subobj(i,1)),find(unique_triplet_annotated(:,3)==relevant_unique_subobj(i,2))),2);
    tripcomp_1_verb(count+i,overlap_verb)=1;
    tripcomp_1_obj(count+i,relevant_unique_subobj(i,2)) = 1 ;
    %replace with loop in next iterations
    
end
count=count+i;


% 
% triplet_components_iter1=struct;
% 
% 
% 
% %sub-verb
% [unique_subverb,~,ind] = uniqueRowsCA(unique_triplets(:,[1,2]));
% freq_unique_data = histc(ind,1:size(unique_subverb,1));
% relevant_index_subverb = find(freq_unique_data>1);
% relevant_unique_subverb = unique_subverb(relevant_index_subverb,:);
% 
% for i=1:length(relevant_index_subverb)
%     i
%     triplet_components_iter1(count).sub = relevant_unique_subverb(i,1);
%     triplet_components_iter1(count).verb = relevant_unique_subverb(i,2);
%     triplet_components_iter1(count).obj = unique_triplets(find(ind == relevant_index_subverb(i)),3);
%     count=count+1;
% end
% 
% %verb-obj
% [unique_verbobj,~,ind] = uniqueRowsCA(unique_triplets(:,[2,3]));
% freq_unique_data = histc(ind,1:size(unique_verbobj,1));
% relevant_index_verbobj = find(freq_unique_data>1);
% relevant_unique_verbobj = unique_verbobj(relevant_index_verbobj,:);
% 
% 
% for i=1:length(relevant_index_verbobj)
%     i
%     triplet_components_iter1(count).sub = unique_triplets(find(ind == relevant_index_verbobj(i)),1);
%     triplet_components_iter1(count).verb = relevant_unique_verbobj(i,1);
%     triplet_components_iter1(count).obj = relevant_unique_verbobj(i,2);
%     count=count+1;
% end
% 
% %sub-obj
% [unique_subobj,~,ind] = uniqueRowsCA(unique_triplets(:,[1,3]));
% freq_unique_data = histc(ind,1:size(unique_subobj,1));
% relevant_index_subobj = find(freq_unique_data>1);
% relevant_unique_subobj = unique_subobj(relevant_index_subobj,:);
% 
% for i=1:length(relevant_index_subobj)
%     i
%     triplet_components_iter1(count).sub = relevant_unique_subobj(i,1);
%     triplet_components_iter1(count).verb = unique_triplets(find(ind == relevant_index_subobj(i)),2);
%     triplet_components_iter1(count).obj = relevant_unique_subobj(i,2);
%     count=count+1;
% end
% 
% 
