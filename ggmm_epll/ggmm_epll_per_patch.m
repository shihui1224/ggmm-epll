function zhat = ggmm_epll_per_patch(ztilde, sigma2, prior_model, varargin)
% % Function Name: ggmm_epll_per_patch
%
%
% Inputs:
%   ztilde      : patches extracted from noisy image
%   sigma2      : noise variance
%   prior_model : model generated using get_prior.m
%   varargin    : refer to retrieve arguments for a list
%
% Outputs:
%   zhat        : restored image patches

% Citation:
% If you use this code please cite:
%
% C-A. Deledalle, S. Parameswaran, and T. Q. Nguyen, "Image
% restoration with generalized Gaussian mixture model patch
% priors", arXiv.
%
% S. Parameswaran, C-A. Deledalle, L. Denis and T. Q. Nguyen, "Accelerating
% GMM-based patch priors for image restoration: Three ingredients for a
% 100x speed-up", arXiv.
%
% License details as in license.txt
% ________________________________________


% Retrieve arguments
options      = makeoptions(varargin{:});
verbose      = getoptions(options, 'verbose', true);
modeshrink   = getoptions(options, 'modeshrink', 'trunc');

P2           = size(ztilde, 1);

% Remove DC component
zdc          = mean(ztilde);
ztilde       = bsxfun(@minus, ztilde, zdc);

% Gaussian selection
labels     = gs_match(ztilde, prior_model.GS, sigma2, varargin{:});

% Patch estimation
U          = prior_model.GS.U;
S          = prior_model.GS.S;
nu         = prior_model.GS.nu;
lab_list   = unique(labels(:))';
zhat       = zeros(size(ztilde));
for k = lab_list
    inds = labels == k;
    ctilde        = U{k}' * ztilde(:, inds);
    chat          = gg_shrinkage(ctilde, sqrt(sigma2), ...
                                 sqrt(S{k}), nu{k}, modeshrink);
    zhat(:, inds) = U{k} * chat;
end

% Add back DC component
zhat = bsxfun(@plus, zhat, zdc);
