[x y z]=ndgrid(-3:3);
 m=(x.^2+(y*1.5).^2+z.^2)<20^2
WriteMRC(m,1,'maptest2.mrc');