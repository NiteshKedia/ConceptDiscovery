clear VVO;
num_verbs = length(V);
VVO = cell(num_verbs,num_verbs);

for i=1:2
	display(i)
    for j=i:num_verbs
        VVO{i,j}=intersect(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(i))),3),unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(j))),3));
        VVO{j,i}=intersect(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(i))),3),unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(j))),3));
    end
end
