function [Xcorrected,Ycorrected,RefDir]=rayTracingVectorized(N1,N2,IncDir,NormDir,GeoD,X,Y)

N=N1/N2;

% Calculate cos(Theta1), cos(Theta2)
cosTheta1=dot(IncDir',NormDir');
cosTheta2=sqrt(1-N^2*(1-cosTheta1.^2));

% direction of refracted ray
% nRays X 2 matrix
RefDir=N*IncDir+bsxfun(@times,NormDir,(cosTheta2-N*cosTheta1)');

% Point Correction
% row vector of X values
% row vector of Y values
% start point + distance * direction        
Xcorrected=X+GeoD.*RefDir(:,1)';
Ycorrected=Y+GeoD.*RefDir(:,2)';
