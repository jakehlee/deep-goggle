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

recon_csv = '/home/jakelee/demud_results/recon-cnn-k=500-dim=4096-full-init_item=svd.csv' ;
resid_csv = '/home/jakelee/demud_results/resid-cnn-k=500-dim=4096-full-init_item=svd.csv' ;
select_csv = '/home/jakelee/demud_results/select-cnn-k=500-dim=4096-full-init_item=svd.csv' ;

top_n = 2;

rng(24);
%16 fc6, 18 fc7, 20 fc8
layer = 16;
ver = 'results_8_10_demud_1';

exp_counter = 1;
exp_list = {} ;
for i=1:top_n
    
    opts1 = opts;
    opts1.featImported = feat_import(select_csv, 0, i);
    exp_list{exp_counter} = experiment_init('caffe-ref', layer, strcat(int2str(i), ...
        '-select'), ver, 'cnn', opts1);
    opts1.featImported = feat_import(recon_csv, 0, i);
    exp_list{exp_counter+1} = experiment_init('caffe-ref', layer, strcat(int2str(i), ...
        '-recon'), ver, 'cnn', opts1);
    opts1.featImported = feat_import(resid_csv, 0, i);
    exp_list{exp_counter+2} = experiment_init('caffe-ref', layer, strcat(int2str(i), ...
        '-resid'), ver, 'cnn', opts1);
    exp_counter = exp_counter+3;
end

experiment_run(exp_list);
end



