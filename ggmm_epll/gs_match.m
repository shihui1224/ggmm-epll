function labels = gs_match(y, GS, sig2, varargin)
% % Function Name: gs_match
%
%
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

options      = makeoptions(varargin{:});

[d, n] = size(y);

numMix = length(GS.S);
energy = zeros(numMix, n);
for k = 1:numMix
    uy = GS.U{k}' * y;
    ggmet       = gg_discrepancy(uy, sqrt(sig2), sqrt(GS.S{k}), GS.nu{k}, ...
                                 varargin{:});
    energy(k,:) = -log(GS.wts(k)) + sum(ggmet, 1);
end
[~, labels] = min(energy, [], 1);

