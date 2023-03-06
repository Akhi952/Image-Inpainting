function [Irestored] = PDE_inpainting(I, mask)

[imX, imY] = size(I);

dx=1; 
dt = 0.4; 
t_max = 600;

ts = 1:dt:t_max;
ts_n = size(ts,2);

lambda = 0.5;

r = lambda*(dt/dx^2);

U0 = zeros(size(I));

L_X=(diag(-2*r*ones(imX,1)) + diag(r*ones(imX-1,1),1) + diag(r*ones(imX-1,1),-1));
L_Y=(diag(-2*r*ones(imY,1)) + diag(r*ones(imY-1,1),1) + diag(r*ones(imY-1,1),-1));

%Neumann conditions
L_X(1,2)=2*r;
L_X(imX,imX-1)=2*r;
L_Y(1,2)=2*r;
L_Y(imY,imY-1)=2*r;

chi = zeros(size(mask));
chi_ind = mask == 1;
chi(chi_ind) = 1;

U_old = U0;
U_new = size(U_old);

for k = 1:ts_n
    
    U_new = U_old+L_X*U_old+U_old*L_Y+dt*(chi.*(I-U_old));
    U_old = U_new;

end

%OUTPUT
Irestored = U_old;

end