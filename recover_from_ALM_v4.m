function recovered_v = recover_from_ALM_v4(ALM,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y,r_select_ratio, maxL, ddim)

if (mod(ddim,2)==1)
recovered_hat_v=zeros(2*N+1,2*N+1,2*N+1);
else
recovered_hat_v=zeros(2*N,2*N,2*N);
end
%sum= 0;
for ii=0:maxL
recovered_coeff=reshape(ALM{ii+1},numel((ALM{ii+1})),1);
Psilms=generate_psilms_cwf(jball,jjorigin,Y,dems_Y,dels_Y,r_cut,N,r_select_ratio, ii, maxL, size(recovered_hat_v,1));
recovered_hat_v(jball)=recovered_hat_v(jball)+Psilms*recovered_coeff;
%keyboard
%sum=sum+numel(Psilms);
end
%sum
%keyboard
recovered_v = fftshift( ifftn( ifftshift( recovered_hat_v) ));
