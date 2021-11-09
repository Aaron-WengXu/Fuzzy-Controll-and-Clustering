function [Ra,Classification,Number_Class] = aCutLevel(R,a)
% if xi and xj belong to the same cluster
% the ith and jth colums or rows of Ra will be the same

Ra = R>=a;
[X,Y] = size(Ra);

if X ~= Y
    error("Fuzzy equivalence relation should be square matrix");
end

% The maximum # of clusters is X

Number_Class = 0;

% Index of elements that to be classified
Index_Ra = 1:X;
Cluster_Pattern = [];
while ~isempty(Index_Ra)
    Number_Class = Number_Class+1;
    i = min(Index_Ra);
    if Number_Class > 1 && any(sum(Cluster_Pattern .* Ra(i,:)))
       Classification = [];
       Number_Class = 0; %Clusterring is unsuccessful for the current value of alpha
       break;
    end 
    cluster_temp = Ra(Index_Ra,:) == Ra(i,:);    
    cluster_index = sum(cluster_temp') == X;
    if Number_Class ==1
        Classification = {Index_Ra(cluster_index)};
        Cluster_Pattern = Ra(i,:);
    else
        Classification = [Classification;{Index_Ra(cluster_index)}];
        Cluster_Pattern = [Cluster_Pattern;Ra(i,:)];
    end
    Index_Ra = Index_Ra(~cluster_index);   
    
end


end

