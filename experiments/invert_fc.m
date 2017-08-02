function invert_fc()
% Invert an fc feature vector

experiment_setup;

opts.learningRate = 0.004 * [...
  ones(1,100), ...
  0.1 * ones(1,200), ...
  0.01 * ones(1,100)];
opts.objective = 'l2' ;
opts.beta = 6 ;
opts.lambdaTV = 1e2 ;
opts.lambdaL2 = 8e-10 ;

opts1 = opts;
opts1.lambdaTV = 1e0 ;
opts1.TVbeta = 2;

opts2 = opts ;
opts2.lambdaTV = 1e1 ;
opts2.TVbeta = 2;

opts3 = opts ;
opts3.lambdaTV = 1e2 ;
opts3.TVbeta = 2;

% without external override; 
opts4 = opts;
opts4.lambdaTV = 1e2;
opts4.TVbeta = 2;
opts4.numRepeats = 1;

% with external override
opts5 = opts;
opts5.lambdaTV = 5e1;
opts5.TVbeta = 2;
opts5.numRepeats = 1;
%
opts5.featOverride = 1;
opts5.featImported =feat_import('/home/jakelee/caffe_6_27_17/fc6.csv', ...
    1, 99);

% If using external, make sure this matches!
layer = 16;
image = 'data/imageset/0/0-0.jpg';
ver = 'results_7_31_beta2_lambda5e1_1_ext';

exp = {};
exp{1} = experiment_init('caffe-ref', 16, image, ver, 'cnn', opts5);
%exp{2} = experiment_init('caffe-ref', 17, image, ver, 'cnn', opts5);
%exp{3} = experiment_init('caffe-ref', 18, image, ver, 'cnn', opts5);
%exp{4} = experiment_init('caffe-ref', 19, image, ver, 'cnn', opts5);
%exp{5} = experiment_init('caffe-ref', 20, image, ver, 'cnn', opts5);

experiment_run(exp);
end



