 function [ALM,C]=find_ALM_v4(vol,maxL,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio)
		%N=floor(size(vol,1)/2);
        dbstop if error
        hatv = fftshift( fftn( ifftshift( vol ) ));
        %Dec 31st testing - Tejal
        %hatv=hatv(11:99,11:99,11:99);
        N=floor(size(hatv,1)/2);
         %dbstop
        data=hatv(jball);
        %coeff=zeros(size(Psilms,2),1);
        %coeff(mod(tablelms(1,:),2)==0) = Psilms(:,mod(tablelms(1,:),2)==0)\real(data);
        %coeff(mod(tablelms(1,:),2)==1) = Psilms(:,mod(tablelms(1,:),2)==1)\imag(data);
        
        %coeff(mod(tablelms(1,:),2)==0) =(Psilms(:,mod(tablelms(1,:),2)==0)'*real(data));
        %coeff(mod(tablelms(1,:),2)==1) =(Psilms(:,mod(tablelms(1,:),2)==1)'*imag(data));
        %coeff(mod(tablelms(1,:),2)==1) = (-1)^0.5*coeff(mod(tablelms(1,:),2)==1) ;
        %Psilms_total = zeros(numel(jball),0);
        for ii=0:maxL
            ii
			Psilms=generate_psilms_cwf(jball,jjorigin,Y,dems_Y,dels_Y,r_cut,N, r_select_ratio, ii, maxL, size(hatv,1));
            if (ii==2)
                for i=1:
                Psilms_cartesian = zeros(2*N+1,2*N+1,2*N+1);
                Psilms_cartesian(jball) = Psilms(:,1);
                Psilms_cartesian = fftshift(ifftn(ifftshift(Psilms_cartesian)));
                if (mod(ii,2)==0)
                    Psilms_cartesian = real(Psilms_cartesian);
                else
                    Psilms_cartesian = imag(Psilms_cartesian);
                end
            %keyboard
                name = strcat('Psilms_20_1_',num2str(ii),'.mrc');
                WriteMRC(Psilms_cartesian,1,name);

            end
%             if (ii<=10)
%             Psilms_total = [Psilms_total Psilms];
%             end
           %keyboard
			if mod(ii,2)==0
				%coeff =(Psilms'*real(data));
				coeff =((Psilms)'*Psilms)\((Psilms)'*real(data));  %Psilms here are real (using real form of spherical harmonics Ylm)
			else
				coeff =((Psilms)'*Psilms)\((Psilms')*imag(data));
				%coeff =(Psilms{ii+1})'*(imag(data));
				coeff=(-1)^0.5*coeff;
            end
            %alm=(coeff(find(tablelms(1,:)==ii)));
            ALM{ii+1}=reshape(coeff,length(coeff)/(2*ii+1),2*ii+1);
            C{ii+1}=ALM{ii+1}*ALM{ii+1}';
           % dbstop
        end
        %dbstop
end
