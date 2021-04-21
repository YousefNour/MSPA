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
    n2 = 3.44;          % Core
    n3 = 1.00;          % Upper cladding (air)

    % Layer heights:
    h1 = 2.0;           % Lower cladding
    h2 = 1.3;           % Core thickness
    h3 = 0.5;           % Upper cladding

    % Horizontal dimensions:
    rh = 1.1;           % Ridge height
    rw (i) = 1.0 - (i-1)*0.075;    % Ridge half-width
    side = 1.5;         % Space on side

    % Grid size:
    dx = 0.0125;        % grid size (horizontal)
    dy = 0.0125;        % grid size (vertical)

    lambda = 1.55;      % vacuum wavelength
    nmodes = 1;         % number of modes to compute

    
     %[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
      %                                          rh,rw(i),side,dx,dy); 

    %Make the width 8 times less densw
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3]./8,[h1,h2,h3]./8, ...
                                                rh/8,rw(i)./8,side/8,dx/8,dy/8); 
                                            

    % First consider the fundamental TE mode:

    [Hx,Hy,neffTE(i)] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

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
plot (neffTE*-1); 
set(gca,'xdir','reverse','ydir','reverse');hold on
xlabel ('mode number')
ylabel ('Neff')
legend ('TE')

%What happens as the ridge get very narrow? Why?
     % the ridge gets taller at first and then narrower in the last few figures.
...In turn, even though the mode does not chnage significantly, the light is being forced out of the waveguide

%Make the mesh 8 times less dense. Change dx and dy. What happens?
%There is hardly any change in the light, but more so in the dimensions of the waveguide resulting in an almost linear graph 
