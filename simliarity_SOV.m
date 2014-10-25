display('started')
ns = length(unique_sub);
nv = length(unique_verb);
no = length(unique_obj);


%Subject verb object pairwise similarity
sub_similarity_euclidean = zeros(ns,ns);
verb_similarity_euclidean = zeros(nv,nv);
obj_similarity_euclidean = zeros(no,no);

sub_similarity_cosine = zeros(ns,ns);
verb_similarity_cosine = zeros(nv,nv);
obj_similarity_cosine = zeros(no,no);

for i = 1:ns 
    for j = 1:ns
        sub_similarity_euclidean(i,j) = pdist([S(i,:);S(j,:)],'euclidean');
        sub_similarity_cosine(i,j) = pdist([S(i,:);S(j,:)],'cosine');
    end
end
display('Subject similarity computed')


for i= 1:nv
 for j= 1:nv
      verb_similarity_euclidean(i,j) = pdist([V(i,:);V(j,:)],'euclidean');
      verb_similarity_cosine(i,j) = pdist([V(i,:);V(j,:)],'cosine');
      verb_similarity_cityblock(i,j) = pdist([V(i,:);V(j,:)],'cityblock');
 end
end
display('Verb similarity computed')


for i = 1:no
   for j = i+1:no
        obj_similarity_euclidean(i,j) = pdist([O(i,:);O(j,:)],'euclidean');
        obj_similarity_euclidean(j,i) = pdist([O(i,:);O(j,:)],'euclidean');
    end
end
display('Object similarity computed')

% index = find(ismember(unique_verb,'kill'));
% unique_verb(find(verb_similarity_euclidean(index,:)<mean(verb_similarity_euclidean(index,:)-std(verb_similarity_euclidean(index,:)))))

%Find top similar subject verb objects
index = find(ismember(unique_sub,'allah'))
test = [sub_similarity_verb_overlap(1:index,index)'  sub_similarity_verb_overlap(index,index+1:end)];
[xsorted is] = sort(test,'ascend');
unique_sub(is(1:10))

index = find(ismember(unique_verb,'kill'))
test = [verb_similarity_subobj_overlap(1:index,index)'  verb_similarity_subobj_overlap(index,index+1:end)];
[xsorted is] = sort(test,'ascend');
unique_verb(is(1:10))


index = find(ismember(unique_obj,'convoy'))
test = [obj_similarity_euclidean(1:index,index)'  obj_similarity_euclidean(index,index+1:end)];
[xsorted is] = sort(test,'ascend');
unique_obj(is(1:40))

%Strongly connected components
sub_similarity_euclidean_scc = zeros(ns);
for i= 1:ns
    [xsorted is] = sort(sub_similarity_euclidean(i,:),'ascend');
    sub_similarity_euclidean_scc(i,is(1:2))=1;
end
 [nComponents,sizes,scc_subjects] = networkComponents(sub_similarity_euclidean_scc);

 obj_similarity_euclidean_scc = zeros(no);
for i= 1:no
    [xsorted is] = sort(obj_similarity_euclidean(i,:),'ascend');
    obj_similarity_euclidean_scc(i,is(1:2))=1;
end
 [nComponents,sizes,scc_objects] = networkComponents(obj_similarity_euclidean_scc);
 
 
 
 verb_similarity_euclidean_scc = zeros(nv);
for i= 1:nv
    [xsorted is] = sort(verb_similarity_euclidean(i,:),'ascend');
    verb_similarity_euclidean_scc(i,is(1:2))=1;
end
 [nComponents,sizes,scc_verbs] = networkComponents(verb_similarity_euclidean_scc);
 
  
 
%Main Algorithm 
count=1;
% freq_verbs = unique_verb(frequent_verbs(1:30,1));
% for j = 1:length(freq_verbs)
%     word=freq_verbs{j}; 
    for i = 1:length(scc_verbs)
%         if(~isempty(find(scc_verbs{i}==find(ismember(unique_verb,word)))))
            display('inside verb')
            scc_v = unique_verb(scc_verbs{i});
            scc_s = unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_v{1}))),1));
            for k=2:length(scc_verb)
                scc_s = intersect(scc_s,unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_v{k}))),1)));
            end
            scc_o = unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_v{1}))),3));
            for k=2:length(scc_verb)
                scc_o = intersect(scc_o,unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_v{k}))),1)));
            end
            
            for k=1:length(scc_subjects)
                display('inside subject')
                intersect_verb_sub = intersect(unique_sub(scc_subjects{k}),scc_s);
               if(numel(intersect_verb_sub)>5)
                   
                   for l=1:length(scc_objects)
                       display('inside objects')
                       intersect_verb_obj = intersect(unique_obj(scc_objects{l}),scc_o);
                       interect_sub_obj = intersect(unique(unique_triplets(find(ismember(unique_triplets(:,1),intersect_verb_sub)),3)),intersect_verb_obj);
                       if(numel(interect_sub_obj)>2)
                           xlswrite('generalised_triplets.xls', intersect_verb_sub , count, 'A1');
                            xlswrite('generalised_triplets.xls', scc_v , count, 'B1');
                            xlswrite('generalised_triplets.xls', interect_sub_obj , count, 'C1');
                            scc_o = setdiff(scc_o,interect_sub_obj);
                            
                    count=count+1;
                       end
                   end
                   scc_s = setdiff(scc_s,intersect_verb_sub);
%                    xlswrite('generalised_triplets.xls', intersect(unique_sub(scc_subjects{k}),scc_s) , count, 'A1');
%                    xlswrite('generalised_triplets.xls', scc_v , count, 'B1');
%                    scc_s = setdiff(scc_s,intersect(unique_sub(scc_subjects{k}),scc_s));
%                    count=count+1;
               end
            end
    end
%             scc_sub = unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_verb{1}))),1));
%             scc_obj = unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_verb{1}))),3));
%             for k=2:length(scc_verb)
%                 scc_sub = intersect(scc_sub, unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_verb{k}))),1)));
%                 scc_obj = intersect(scc_obj, unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(scc_verb{k}))),3)));
%             end
            
%             [unique_data,junk,ind] = unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(members{i}))),1));
%             freq_unique_data = histc(ind,1:numel(unique_data));
%             [xsorted is] = sort(freq_unique_data,'descend');
%             scc_sub = unique_data(is(1:10));
% 
%             
% 
%             [unique_data,junk,ind] = unique(unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(members{i}))),3));
%             freq_unique_data = histc(ind,1:numel(unique_data));
%             [xsorted is] = sort(freq_unique_data,'descend');
%             scc_obj = unique_data(is(1:10));
% 
%             xlswrite('generalised_triplets.xls', scc_sub , word, 'A1');
%             xlswrite('generalised_triplets.xls', scc_verb , word, 'B1');
%             xlswrite('generalised_triplets.xls', scc_obj , word, 'C1');
        end
%     end
% end

word='kill';
for i = 1:length(members)
    if(~isempty(find(members{i}==find(ismember(unique_verb,word)))))
        scc_triplets = unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(members{i}))),:);
            [scc_sub,junk,ind] = unique(scc_triplets(:,1));
            [scc_verb,junk,ind] = unique(scc_triplets(:,2));
            [scc_obj,junk,ind] = unique(scc_triplets(:,3));
    end
end

%Triplets from strongly connected components with threshold as single topmost similar
%word

freq_verbs = unique_verb(frequent_verbs(1:20,1));
for j = 1:length(freq_verbs)
    word=freq_verbs{j};
    for i = 1:length(members)
        if(~isempty(find(members{i}==find(ismember(unique_verb,word))))) 
            scc_triplets = unique_triplets(find(ismember(unique_triplets(:,2),unique_verb(members{i}))),:);
            [scc_sub,junk,ind] = unique(scc_triplets(:,1));
            [scc_verb,junk,ind] = unique(scc_triplets(:,2));
            [scc_obj,junk,ind] = unique(scc_triplets(:,3));
        end
    end
end