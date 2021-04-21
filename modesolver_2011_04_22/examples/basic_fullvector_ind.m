% [x,y]=find(peaks>0.7)
% close all
% subplot(2,1,1);
% plot(x,y,'or')
% subplot(2,1,2);
% plot(x,y,'or');
% % This command will rotate the plot by 180 degree
% set(gca,'xdir','reverse','ydir','reverse')

%% New Code

% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  
close all
clear all
clc
% Refractive indices:
for i  = 1:10
    %refractive indces
    n1 = 3.34;          % Lower cladding
    n2 (i)= 3.44- (i-1)*0.015;          % Core
    n3 = 1.00;          % Upper cladding (air)

    % Layer heights:
    h1 = 2.0;           % Lower cladding
    h2 = 1.3;           % Core thickness
    h3 = 0.5;           % Upper cladding

    % Horizontal dimensions:
    rh = 1.1;           % Ridge height
    rw = 1.0;           % Ridge half-width
    side = 1.5;         % Space on side

    % Grid size:
    dx = 0.0125;        % grid size (horizontal)
    dy = 0.0125;        % grid size (vertical)

    lambda = 1.55;      % vacuum wavelength
    nmodes = 1;         % number of modes to compute

    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(i),n3],[h1,h2,h3], ...
                                                rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neffTE(i)] = wgmodes(lambda,n2(i),nmodes,dx,dy,eps,'000A');

    fprintf(1,'neff(%i) = %.6f\n',i,neffTE(i));

    figure(i);
    subplot(1,2,1);
    contourmode(x,y,Hx(:,:,1));
    title(['Hx (TE mode:' num2str(i) ')']); xlabel('x'); ylabel('y'); 
  % for v = edges, line(v{:}); end

    subplot(1,2,2);
    contourmode(x,y,Hy(:,:,1));
    title(['Hy (TE mode:' num2str(i) ')']); xlabel('x'); ylabel('y'); 
  % for v = edges, line(v{:}); end
     

end

figure 
plot   (neffTE*-1); 
set(gca,'xdir','reverse','ydir','reverse');hold on
xlabel ('mode number')
ylabel ('Neff')
legend ('TE')

%What happens as the ridge get very narrow? Why?
     % the ridge gets taller at first and then narrower in the last few figures.
...In turn, even though the mode does not chnage significantly, the light is being forced out of the waveguide

%Make the mesh 8 times less dense. Change dx and dy. What happens?
%
