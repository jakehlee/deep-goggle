function invert_fc()
% Invert an fc feature vector

experiment_setup;

opts.learningRate = 0.004 * [...
  ones(1,100), ...
  0.1 * ones(1,200), ...
  0.01 * ones(1,100)];
opts.objective = 'l2' ;
opts.beta = 6 ;
opts.lambdaTV = 5e1 ;
opts.lambdaL2 = 8e-10 ;
opts.TVbeta = 2;
opts.numRepeats = 1;
opts.featOverride = 1;

recon_csv = '/recon/file.csv' ;
resid_csv = '/resid/file.csv' ;
select_csv = '/select/file.csv' ;

top_n = 8;

%seed to keep consistent
rng(24);
%16 fc6, 18 fc7, 20 fc8
layer = 16;
ver = 'output_dir_name';

exp_counter = 1;
exp_list = {} ;
for i=1:top_n
    i
    opts1 = opts;
    opts1.featImported = feat_import(select_csv, 0, i);
    exp_list{exp_counter} = experiment_init('caffe-ref', layer, strcat(int2str(i-1), ...
        '-select'), ver, 'cnn', opts1);
    opts1.featImported = feat_import(recon_csv, 0, i);
    exp_list{exp_counter+1} = experiment_init('caffe-ref', layer, strcat(int2str(i-1), ...
        '-recon'), ver, 'cnn', opts1);
    opts1.featImported = feat_import(resid_csv, 0, i);
    exp_list{exp_counter+2} = experiment_init('caffe-ref', layer, strcat(int2str(i-1), ...
        '-resid'), ver, 'cnn', opts1);
    exp_counter = exp_counter+3;
end

experiment_run(exp_list);
end



