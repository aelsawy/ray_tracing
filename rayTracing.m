function [Xcorrected,Ycorrected,RefDir]=rayTracing(nRays,N1,N2,IncDir,NormDir,GeoD,X,Y)

RefDir=[];
Xcorrected=[];
Ycorrected=[];

N=N1/N2;

for ray=1:nRays

    % Calculate cos(Theta1), cos(Theta2)
    % both cos(Theta1), cos(Theta2) must be positive
    % as angles are acute angles < 90
    
    % I multiplied by -1 to make cos(Theta1) positive
    cosTheta1=dot(IncDir(ray,:),NormDir(ray,:));
    
    % correct normal direction if cosTheta1 < 0
%     if(cosTheta1<0)
%         cosTheta1=cosTheta1*-1;
%         NormDir(ray,:)=NormDir(ray,:)*-1;
%     end
    
    cosTheta2=sqrt(1-N^2*(1-cosTheta1^2));

    % direction of refracted ray
    % nRays X 2 matrix
    refRay=N*IncDir(ray,:)+(cosTheta2-N*cosTheta1)*NormDir(ray,:);
    
    RefDir=[RefDir ; refRay];
    
    % Point Correction
    % row vector of X values
    % row vector of Y values
    % start point + distance * direction        
    Xcorrected=[Xcorrected, X(ray)+GeoD(ray)*refRay(1)];
    Ycorrected=[Ycorrected, Y(ray)+GeoD(ray)*refRay(2)];

end
