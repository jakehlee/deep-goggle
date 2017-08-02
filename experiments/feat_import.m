function feat = feat_import( csv_filepath, label_flag, index0 )
%feat = feat_import( csv_file, label_flag, index ) Imports a feature vector
%from an external source.
%   csv_filepath - path to the csv file
%   label_flag - 1 if the first column is a label, 0 if not
%   index0 - which row of the csv to return; starts from 0

if label_flag
    csv_in = csvread(csv_filepath, 0, 1);   % read csv without 1st col
else
    csv_in = csvread(csv_filepath, 0, 0);   % read csv with 1st col
end

feat_in = csv_in(index0+1, :);          % extract specified row
length = size(feat_in);                 % find length of that row
length = length(2);
feat = reshape(feat_in,[1,1,length]);   % reshape into (1,1,length)
feat = single(feat);                    % matconvlib has single, not double

end

