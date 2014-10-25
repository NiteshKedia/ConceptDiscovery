% clear object_verb
% object_verb = cell(length(unique_obj),1)
% 
% for i=1:length(object_verb)
%     display(i)
%     overlap_verbs = unique_triplets(find(ismember(unique_triplets(:,3),unique_obj(i))),2);
%     object_verb{i} = overlap_verbs;
% end

clear verbsimverb_subject;
verbsimverb_subject = zeros(length(unique_verb));

for i= 1:length(unique_verb)
    display(i)
    for j=i+1:length(unique_verb)
        overlap=numel(intersect(verb_subject{i},verb_subject{j}));
        verbsimverb_subject(i,j) = ((overlap/numel(verb_subject{i}) + overlap/numel(verb_subject{j}))/verb_similarity_euclidean(i,j));
        verbsimverb_subject(j,i) = verbsimverb_subject(i,j); 
    end
end




