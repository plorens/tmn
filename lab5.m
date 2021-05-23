

%% •wygenerowaæ fantom Jaszczaka 2D lub 3D, 

dzlicz=-3;
mzlicz=-11;
%œrednia 10 dla ma³ej i dla duzej 100

E1 = [1, 1, 1, 0, 0, 0;
    mzlicz, 0.058796, 0.058796, 0, 0.65, 0;  
    mzlicz, 0.07361, 0.07361, 0.5, 0.375, 0;
    mzlicz, 0.0884259, 0.0884259, 0.5, -0.375, 0;
    mzlicz, 0.1175926, 0.1175926, 0, -0.65, 0;
    mzlicz, 0.14722222,0.14722222, -0.5, -0.375, 0;
    mzlicz, 0.1759259259,0.1759259259, -0.5, 0.375, 0
     
];

E2 = [1, 1, 1, 0, 0, 0;
    dzlicz, 0.058796, 0.058796, 0, 0.65, 0;  
    dzlicz, 0.07361, 0.07361, 0.5, 0.375, 0;
    dzlicz, 0.0884259, 0.0884259, 0.5, -0.375, 0;
    dzlicz, 0.1175926, 0.1175926, 0, -0.65, 0;
    dzlicz, 0.14722222,0.14722222, -0.5, -0.375, 0;
    dzlicz, 0.1759259259,0.1759259259, -0.5, 0.375, 0
     
];
P1=phantom(E1, 256);
P2=phantom(E2, 256);

%% •zaprezentowaæ fantom, 
figure();
imagesc(P1);
title("Fantom Jaszczka, ma³a liczba zliczeñ");
colorbar;
figure();
imagesc(P2);
title("Fantom Jaszczka, du¿a liczba zliczeñ");
colorbar;
%% •wygenerowaæ projekcje z uwzglêdnieniem rozk³adu Poissona dla ma³ej i du¿ej liczby zliczeñ, 


deg=0:1:179;
R1 = radon(P1, deg);
R2 = radon(P2, deg);

m1=mean(R1(:));
m2=mean(R2(:));

RD1 = poissrnd(R1);
RD2 = poissrnd(R2);

figure();
imagesc(RD1);
title("Sinogram, ma³a liczba zliczeñ");
colorbar;
figure();
imagesc(RD2);
title("Sinogram, du¿a liczba zliczeñ");
colorbar;
%% •zaprezentowaæ sinogramy, 
figure(1);
imagesc(R1);
colorbar;
figure(2);
imagesc(R2);
colorbar;
%% •zrekonstruowaæ obrazy dla ró¿nych statystyk z ró¿nymi filtrami, 
I1 = iradon(R1, deg, 'linear', 'none',1,256);
I2 = iradon(R2, deg, 'linear', 'none',1,256);

I3 = iradon(R1, deg, 'linear', 'Hann',1,256);
I4 = iradon(R2, deg, 'linear', 'Hann',1,256);

I5 = iradon(R1, deg, 'linear', 'Hamming',1,256);
I6 = iradon(R2, deg, 'linear', 'Hamming',1,256);

I7 = iradon(R1, deg, 'linear', 'Cosine',1,256);
I8 = iradon(R2, deg, 'linear', 'Cosine',1,256);

I9 = iradon(R1, deg, 'linear', 'Shepp-Logan',1,256);
I10 = iradon(R2, deg, 'linear', 'Shepp-Logan',1,256);

I11 = iradon(R1, deg, 'linear', 'Ram-Lak',1,256);
I12 = iradon(R2, deg, 'linear', 'Ram-Lak',1,256);

figure();
subplot(2, 2, 1);
imagesc(I1);
title("Brak filtra, ma³o zliczeñ");
colorbar;
subplot(2, 2, 2);
imagesc(I2);
title("Brak filtra, du¿o zliczeñ");
colorbar;
subplot(2, 2, 3);
imagesc(I3);
title("Filtr Hanna, ma³o zliczeñ");
colorbar;
subplot(2, 2, 4);
imagesc(I4);
title("Filtr Hanna, du¿o zliczeñ");
colorbar;
figure(2);
subplot(2, 2, 1);
imagesc(I5);
title("Filtr Hamminga, ma³o zliczeñ");
colorbar;
subplot(2, 2, 2);
imagesc(I6);
title("Filtr Hamminga, du¿o zliczeñ");
colorbar;
subplot(2, 2, 3);
imagesc(I7);
title("Filtr Cosine, ma³o zliczeñ");
colorbar;
subplot(2, 2, 4);
imagesc(I8);
title("Filtr Cosine, du¿o zliczeñ");
colorbar;

figure(3);
subplot(2,2,1);
imagesc(I9);
title("Filtr Sheppa-Logana, ma³o zliczeñ");
colorbar;
subplot(2,2,2);
imagesc(I10);
title("Filtr Sheppa-Logana, du¿o zliczeñ");
colorbar;
subplot(2,2,3);
imagesc(I11);
title("Filtr Rama-Laka, ma³o zliczeñ");
colorbar;
subplot(2,2,4);
imagesc(I12);
title("Filtr Rama-Laka, du¿o zliczeñ");
colorbar;


%% Obliczenie norm kwadratowych oraz b³êzdów wzglêdnych 
normP1=norm(reshape(P1, [1, 256*256]));
normP2=norm(reshape(P2, [1, 256*256]));
V1=norm(reshape(I1, [1, 256*256]));
V2=norm(reshape(I2, [1, 256*256]));
errorP1(1)=abs((V1-normP1)./normP1)*100;
errorP2(1)=abs((V2-normP2)./normP2)*100;

V3=norm(reshape(I3, [1, 256*256]));
V4=norm(reshape(I4, [1, 256*256]));
errorP1(2)=abs((V3-normP1)./normP1)*100;
errorP2(2)=abs((V4-normP2)./normP2)*100;

V5=norm(reshape(I5, [1, 256*256]));
V6=norm(reshape(I6, [1, 256*256]));
errorP1(3)=abs((V5-normP1)./normP1)*100;
errorP2(3)=abs((V6-normP2)./normP2)*100;

V7=norm(reshape(I7, [1, 256*256]));
V8=norm(reshape(I8, [1, 256*256]));
errorP1(4)=abs((V7-normP1)./normP1)*100;
errorP2(4)=abs((V8-normP2)./normP2)*100;

V9=norm(reshape(I9, [1, 256*256]));
V10=norm(reshape(I10, [1, 256*256]));
errorP1(5)=abs((V9-normP1)./normP1)*100;
errorP2(5)=abs((V10-normP2)./normP2)*100;

V11=norm(reshape(I11, [1, 256*256]));
V12=norm(reshape(I12, [1, 256*256]));
errorP1(6)=abs((V11-normP1)./normP1)*100;
errorP2(6)=abs((V12-normP2)./normP2)*100;
















