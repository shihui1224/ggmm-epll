function prior_model = get_prior(name)
% % Function Name: get_prior
%
%
% Citation:
% If you use this code please cite:
%
% C-A. Deledalle, S. Parameswaran, and T. Q. Nguyen, "Image
% restoration with generalized Gaussian mixture model patch
% priors", arXiv.
%
% License details as in license.txt
% ________________________________________



switch name
    case 'gmm'
        load('data/gmm.mat', 'GS');
        for k = 1:GS.nmodels
            GS.nu{k} = 2 * ones(GS.dim, 1);
        end
        GS.nu{k} = double(GS.nu{k});
    case 'EM'
        load('/home/imb/hshi/sketching/prior/my_prior_em.mat', 'GS');
    case 'hlmm_05'
        load('data/hlmm_05.mat', 'GS');
    case 'ggmm'
        load('data/ggmm.mat', 'GS');
    case 'my_prior'
        load('/home/imb/hshi/sketching/prior/my_prior.mat','GS');
    case 'r = 10'
        load('/home/imb/hshi/sketching/prior/my_prior.mat','GS');
    case 'sigma2 = 1e-4'
        load('/home/imb/hshi/sketching/prior/sig1e4.mat','GS');
    case 'sigma2 = 1e-4n2'
        load('/home/imb/hshi/sketching/prior/sig1e4n2.mat','GS');
    case 'k = 20, sigma2 = 1e-4'
        load('/home/imb/hshi/sketching/prior/r10sig1e4.mat','GS');
    case 'sigma2 = 1e-3'
        load('/home/imb/hshi/sketching/prior/sig1e3.mat','GS');
    case 'sigma2 = 1e-5'
        load('/home/imb/hshi/sketching/prior/sig1e5.mat','GS');
    case 'sigma2 = 1e-6'
        load('/home/imb/hshi/sketching/prior/sig1e6.mat','GS');
    case 'r = 10, sigma2 = 1e-5'
        load('/home/imb/hshi/sketching/prior/r10sig1e5.mat','GS');
    case 'k = 50, sigma2 = 1e-4'
        load('/home/imb/hshi/sketching/prior/sig1e4k50.mat','GS');
    case 'k = 40, sigma2 = 1e-4'
        load('/home/imb/hshi/sketching/prior/r10k40sig4n2.mat','GS');
    
end
prior_model.GS     = GS;
prior_model.name   = name;