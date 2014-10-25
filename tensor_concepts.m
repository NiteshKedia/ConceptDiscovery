% ntrp = length(sub);
% triplets = cell(ntrp,3);
% for i = 1 : ntrp
%     triplets{i,1} = sub{i}; 
%     triplets{i,2} = verb{i};
%     triplets{i,3} = obj{i};
% end 
%Git testing
clear all; clc;
load triplets.mat; load subjects.mat; load verbs.mat; load objects.mat;
ns = length(sub);
nv = length(verb);
no = length(obj);
nt = length(triplets);
nonzeros = zeros(nt,3);
for i = 1 : nt
    [~, sloc] = ismember(sub, triplets{i,1});
    nonzeros(i,1) = find(sloc);
    [~, oloc] = ismember(obj, triplets{i,3});
    nonzeros(i,2) = find(oloc);
    [~, vloc] = ismember(verb, triplets{i,2});
    nonzeros(i,3) = find(vloc);
end
X = sptensor(nonzeros,1);   
P = cp_als(X,10);
S = P.U{1};
O = P.U{2};
V = P.U{3};
[~, SSI] = sort(abs(S),1,'descend');
[~, SOI] = sort(abs(O),1,'descend');
[~, SVI] = sort(abs(V),1,'descend');

rankR = 10;
kHighest = 100;
for i = 1 : rankR
    concepttop100(i) = horzcat(unique_sub(SSI(1 : kHighest, i)),unique_verb(SVI(1 : kHighest, i)),unique_obj(SOI(1 : kHighest, i)))
end



% grpSubject = cell(kHighest, rankR);
% grpVerb = cell(kHighest, rankR);
% grpObject = cell(kHighest, rankR);
for i = 1 : rankR
    xlswrite('concepts.xlsx', unique_sub(SSI(1 : kHighest, i)), i, strcat('A1:A',num2str(kHighest)));
    xlswrite('concepts.xlsx', unique_verb(SVI(1 : kHighest, i)), i, strcat('B1:B',num2str(kHighest)));
    xlswrite('concepts.xlsx', unique_obj(SOI(1 : kHighest, i)), i, strcat('C1:C',num2str(kHighest)));
end

% for i = 1 : (nt-1)
%     for j = (i+1) : nt
%         D_TRP = distTRP(triplets{i}, triplets{j}, sub, verb, obj, S, V, O);
%     end
% end

