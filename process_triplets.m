load triplets_full.mat
sub=triplets_full(:,1);
verb=triplets_full(:,2);
obj=triplets_full(:,3);
%Handle Prepositions in sub,obj
subject_indices_prepositions=find(ismember(sub,prepositions));
object_indices_prepositions=find(ismember(obj,prepositions));
sub_preposition = zeros(513592,1);
obj_preposition = zeros(513592,1);
sub_preposition(subject_indices_prepositions)=1;
obj_preposition(object_indices_prepositions)=1;
nonemptycells_sub_pobj = ~cellfun(@isempty,sub_pobj);
nonemptycells_obj_pobj = ~cellfun(@isempty,obj_pobj);
preposition_nonempty_subpobj = sub_preposition.*nonemptycells_sub_pobj;
preposition_nonempty_objpobj = obj_preposition.*nonemptycells_obj_pobj;
index_pns = find(preposition_nonempty_subpobj==1);
index_pno = find(preposition_nonempty_objpobj==1);
for i = 1:length(index_pns)
   t = sub_pobj{index_pns(i)};
   C = textscan(t,'%s');
   new_subject = C{1}{length(C{1})};
   sub(index_pns(i)) = cellstr(new_subject);
end
for i = 1:length(index_pno)
   t = obj_pobj{index_pno(i)};
   C = textscan(t,'%s');
   new_object = C{1}{length(C{1})};
   obj(index_pno(i)) = cellstr(new_object);
end

triplets={};
triplets(:,1) = sub;triplets(:,2) = verb;triplets(:,3) = obj;
triplets(union(setdiff(subject_indices_prepositions,index_pns),setdiff(object_indices_prepositions,index_pno)),:)=[];
index_sub_pronouns = find(ismember(triplets(:,1),pronouns));
index_obj_pronouns = find(ismember(triplets(:,3),pronouns));
triplets(union(index_sub_pronouns,index_obj_pronouns),:)=[];



%subjects
% unique_sub = uniqueRowsCA(triplets(:,1));
[unique_s,junk,ind] = unique(triplets(:,1));
freq_unique_data = histc(ind,1:numel(unique_s));
[xsorted is] = sort(freq_unique_data,'descend');
frequent_subs = [is,xsorted];

%Verbs
[unique_v,junk,ind] = unique(triplets(:,2));
freq_unique_data = histc(ind,1:numel(unique_v));
[xsorted is] = sort(freq_unique_data,'descend');
frequent_verbs = [is,xsorted];

%object
[unique_o,junk,ind] = unique(triplets(:,3));
freq_unique_data = histc(ind,1:numel(unique_o));
[xsorted is] = sort(freq_unique_data,'descend');
frequent_objs = [is,xsorted];

%remove junk subs verb obj

junk_subs = unique_s(frequent_subs(frequent_subs(:,2)<10,1));
junk_subs=[junk_subs ;unique_s(frequent_subs(1:30,1))];
index_junk_subs = find(ismember(triplets(:,1),junk_subs));

junk_verbs = unique_v(frequent_verbs(frequent_verbs(:,2)<10,1));
junk_verbs=[junk_verbs ;unique_v(frequent_verbs(1:30,1))];
index_junk_verbs = find(ismember(triplets(:,2),junk_verbs));

junk_objs = unique_o(frequent_objs(frequent_objs(:,2)<10,1));
junk_objs=[junk_objs ;unique_o(frequent_objs(1:30,1))];
index_junk_objs = find(ismember(triplets(:,3),junk_objs));

final_index_junk = unique([index_junk_subs ;index_junk_verbs;index_junk_objs]);
triplets(final_index_junk,:)=[];

unique_sub = unique(triplets(:,1));unique_verb = unique(triplets(:,2));unique_obj = unique(triplets(:,3));

% unique_sub = unique_sub(frequent_subs(frequent_subs(:,2)>4,1));
% unique_triplets = unique_triplets(find(ismember(unique_triplets(:,1),unique_sub)),:);


% junk_verbs = unique_verb(frequent_verbs(frequent_verbs(:,2)<=3,1));
% unique_verb = unique_verb(frequent_verbs(frequent_verbs(:,2)>3,1));
% unique_triplets = unique_triplets(find(ismember(unique_triplets(:,2),unique_verb)),:);
junk_sub={'''s';'0';'0rd';'a';'ab';'ablaj';'abu';'adl';'afp';'al';
    'an';'ana';'ani';'ata';'atta';'ax';'b';'ba';'d';
    'da';'dah';'dahlan';'do';'go';'h';'i.e.';'ida';
    'ii';'iia';'iii';'ja';'mu';'lrb';'lsb';'ma';
    'myc';'mym';'nay';'no';'no.';'o';'osc';'pa';
    'plo';'qa';'qa';'qom';'qur';'ra';'rrb';'s';
    'sa';'sha';'shu';'so';'t';'u';'u0';'u0t';'ud';'v';'ye'};
index_junk_subs = find(ismember(triplets(:,1),junk_subs));

junk_verb = {'%';'''s';'b';'d';'da';'l';'o';'ye';'~'};
index_junk_verbs = find(ismember(triplets(:,2),junk_verb));

junk_obj = {'''s';'-';'0';'>';'a';'ab';'al';'an';'ax';'b';'ba';'do';'h';'km';'o';'qa';'so';'th';'tn';'u';'u0';'ye'};
index_junk_objs = find(ismember(triplets(:,3),junk_obj));

final_index_junk = unique([index_junk_subs ;index_junk_verbs;index_junk_objs]);
triplets(final_index_junk,:)=[];

new_triplets={};
j=1;
for i=1:length(triplets)
    i
    if(~isequal(triplets(i,1),triplets(i,3)))
        new_triplets(j,:) = triplets(i,:);
        j=j+1;
    end
    
end
triplets=new_triplets;
unique_triplets = uniqueRowsCA(triplets, 'rows');
unique_sub = unique(unique_triplets(:,1));
unique_verb = unique(unique_triplets(:,2));
unique_obj = unique(unique_triplets(:,3));

unique_triplet_annotated = zeros(length(unique_triplets),3);
for i = 1:length(unique_triplets)
    unique_triplet_annotated(i,:) = [find(ismember(unique_sub,unique_triplets(i,1))) 
                                        find(ismember(unique_verb,unique_triplets(i,2)))
                                               find(ismember(unique_obj,unique_triplets(i,3))) ];
end

% [unique_data,junk,ind] = unique(unique_triplets(:,2));
% freq_unique_data = histc(ind,1:numel(unique_data));
% [xsorted is] = sort(freq_unique_data,'descend');
% frequent_verbs = [is,xsorted];
% [unique_data,junk,ind] = unique(unique_triplets(:,1));
% freq_unique_data = histc(ind,1:numel(unique_data));
% [xsorted is] = sort(freq_unique_data,'descend');
% frequent_subs = [is,xsorted];
% [unique_data,junk,ind] = unique(unique_triplets(:,3));
% freq_unique_data = histc(ind,1:numel(unique_data));
% [xsorted is] = sort(freq_unique_data,'descend');
% frequent_objs = [is,xsorted];


% %Tensor
% ns = length(unique_sub);
% nv = length(unique_verb);
% no = length(unique_obj);
% nt = length(unique_triplets);
% nonzeros = zeros(nt,3);
% for i = 1 : nt
%    
%     [~, sloc] = ismember(unique_sub, triplets{i,1});
%     nonzeros(i,1) = find(sloc);
%     
%     [~, vloc] = ismember(unique_verb, triplets{i,2});
%     nonzeros(i,2) = find(vloc);
%     
%     [~, oloc] = ismember(unique_obj, triplets{i,3});
%     nonzeros(i,3) = find(oloc);
% end
% X = sptensor(nonzeros,1);   
% P = cp_als(X,10);
% S = P.U{1};
% V = P.U{2};
% O = P.U{3};
% 
% % save SOV_full.mat
% 
% sub_similarity_tensor = zeros(ns,ns);
% sub_similarity_tensor = pdist(S,'euclidean');
% sub_similarity_tensor = squareform(sub_similarity_tensor);
% verb_similarity_tensor = zeros(nv,nv);
% verb_similarity_tensor = pdist(V,'euclidean');
% verb_similarity_tensor = squareform(verb_similarity_tensor);
% obj_similarity_tensor = zeros(no,no);
% obj_similarity_tensor = pdist(O,'euclidean');
% obj_similarity_tensor = squareform(obj_similarity_tensor);
% 
% index = find(ismember(unique_sub,'vehicle'))
% test = [sub_similarity_tensor(index,:)];
% [xsorted is] = sort(test,'ascend');
% unique_sub(is(1:10))
% 
% index = find(ismember(unique_verb,'attack'))
% test = [verb_similarity_tensor(index,:)];
% [xsorted is] = sort(test,'descend');
% unique_verb(is(1:10))
% 
% index = find(ismember(unique_obj,'vehicle'))
% test = [obj_similarity_tensor(index,:)];
% [xsorted is] = sort(test,'descend');
% unique_obj(is(1:10))

