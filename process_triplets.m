load triplets_full.mat

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
copy_sub = sub;
for i = 1:length(index_pns)
   t = sub_pobj{index_pns(i)};
   C = textscan(t,'%s');
   new_subject = C{1}{length(C{1})};
   sub(index_pns(i)) = cellstr(new_subject);
end
copy_obj = obj;
for i = 1:length(index_pno)
   t = obj_pobj{index_pno(i)};
   C = textscan(t,'%s');
   new_object = C{1}{length(C{1})};
   obj(index_pno(i)) = cellstr(new_object);
end

triplets(:,1) = sub;triplets(:,2) = verb;triplets(:,3) = obj;
%numel(uniqueRowsCA(triplets(:,3)))
wd=triplets;
[~,idx]=unique(  strcat(wd(:,1),wd(:,2),wd(:,3)) , 'rows');
unique_triplets=wd(idx,:);
unique_triplets_bak = unique_triplets;
%Cleaning Triplets for pronouns in sub, obj and 'be','say' in verbs
index_sub_pronouns = find(ismember(unique_triplets(:,1),pronouns));
index_obj_pronouns = find(ismember(unique_triplets(:,3),pronouns));
junk_verbs = {'be';'say';'%';'~'};
index_junk_verbs = find(ismember(unique_triplets(:,2),junk_verbs));
junk_index_sov = union(union(index_sub_pronouns,index_obj_pronouns),index_junk_verbs);
unique_triplets(junk_index_sov,:)=[];
unique_sub = uniqueRowsCA(unique_triplets(:,1));unique_verb = uniqueRowsCA(unique_triplets(:,2));unique_obj = uniqueRowsCA(unique_triplets(:,3));
junk_sub = find(ismember(unique_triplets(:,1),unique_sub(1:12)));
junk_verb = find(ismember(unique_triplets(:,2),unique_verb(1:7)));
junk_obj = find(ismember(unique_triplets(:,3),unique_obj(1:11)));
junk_index_sov = union(union(junk_sub,junk_verb),junk_obj);
unique_triplets(junk_index_sov,:)=[];

unique_sub = uniqueRowsCA(unique_triplets(:,1));unique_verb = uniqueRowsCA(unique_triplets(:,2));unique_obj = uniqueRowsCA(unique_triplets(:,3));




%Verbs
[unique_data,junk,ind] = unique(unique_triplets(:,2));
freq_unique_data = histc(ind,1:numel(unique_data));
[xsorted is] = sort(freq_unique_data,'descend');
frequent_verbs = [is,xsorted];
junk_verbs = unique_verb(frequent_verbs(frequent_verbs(:,2)<=3,1));
unique_verb = unique_verb(frequent_verbs(frequent_verbs(:,2)>3,1));
unique_triplets = unique_triplets(find(ismember(unique_triplets(:,2),unique_verb)),:);

%subjects
unique_sub = uniqueRowsCA(unique_triplets(:,1));
[unique_data,junk,ind] = unique(unique_triplets(:,1));
freq_unique_data = histc(ind,1:numel(unique_data));
[xsorted is] = sort(freq_unique_data,'descend');
frequent_subs = [is,xsorted];
junk_subs = unique_sub(frequent_subs(frequent_subs(:,2)<=4,1));
unique_sub = unique_sub(frequent_subs(frequent_subs(:,2)>4,1));
unique_triplets = unique_triplets(find(ismember(unique_triplets(:,1),unique_sub)),:);

%objects
unique_obj = uniqueRowsCA(unique_triplets(:,3));
[unique_data,junk,ind] = unique(unique_triplets(:,3));
freq_unique_data = histc(ind,1:numel(unique_data));
[xsorted is] = sort(freq_unique_data,'descend');
frequent_objs = [is,xsorted];
junk_objs = unique_obj(frequent_objs(frequent_objs(:,2)<=3,1));
unique_obj = unique_obj(frequent_objs(frequent_objs(:,2)>3,1));
unique_triplets = unique_triplets(find(ismember(unique_triplets(:,3),unique_obj)),:);

unique_sub = uniqueRowsCA(unique_triplets(:,1));unique_verb = uniqueRowsCA(unique_triplets(:,2));unique_obj = uniqueRowsCA(unique_triplets(:,3));

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


%Tensor
ns = length(unique_sub);
nv = length(unique_verb);
no = length(unique_obj);
nt = length(unique_triplets);
nonzeros = zeros(nt,3);
for i = 1 : nt
   
    [~, sloc] = ismember(unique_sub, unique_triplets{i,1});
    nonzeros(i,1) = find(sloc);
    
    [~, vloc] = ismember(unique_verb, unique_triplets{i,2});
    nonzeros(i,2) = find(vloc);
    
    [~, oloc] = ismember(unique_obj, unique_triplets{i,3});
    nonzeros(i,3) = find(oloc);
end
X = sptensor(nonzeros,1);   
P = cp_als(X,10);
S = P.U{1};
V = P.U{2};
O = P.U{3};

% save SOV_full.mat





