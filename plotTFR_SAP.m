function plotTFR_SAP(tfd, t, f, fs)
% plotTFR -- Display an image plot of any TFD from time-frequency analysis.
%
%  Usage
%    plotTFR(tfd, t, f, fsize)
%
%  Inputs
%    tfd     time-frequency distribution
%    t       vector of sampling times (optional)
%    f       vector of frequency values (optional)
%    fsize   font size of axis labels (optional)

% Copyright (C) -- Guerrero-Mosquera Carlos, C. 2003

error(nargchk(1, 4, nargin));

N = size(tfd,1);
if (nargin < 4)
  fsize = 10;
end

if (nargin < 3)
  f = [0 100]; 
end
if (nargin == 3)
  f = [min(f) max(f)];
end
if (nargin < 2)
  t = [1 size(tfd,2)];
end
if (nargin == 2)
  t = [min(t) max(t)];  
end

if isempty(t)
  t = [1 size(tfd,2)];
end
if isempty(f)
  f = [0 100];
end


imagesc(t, f, real(abs(tfd(:,:)))), axis('xy'), xlabel('time','FontSize',10), ylabel('frequency','FontSize',10), set(gca,'FontSize',10);
% with YLIM-([0 Ymax]) we can draw just a part od spectrum t-f