clear
clf
%% ????I
I=imread('coin.jpg');
%??????Ig
Ig=rgb2gray(I);
%????0.2??????????Inoise
Inoise=imnoise(Ig,'salt & pepper',0.2);
%???????0.2??????????Inoise
%Inoise=imnoise(Ig,'gaussian',0.2);
%????????Ig?????Inoise
subplot(2,2,1),imshow(Ig);xlabel('a.??????');
subplot(2,2,2),imshow(Inoise);xlabel('b.????????');
%% ????
%??????:Im,In
[Im,In]=size(Inoise);
%??????:nmin*nmin(?????????)
nmin=3;
%??????:nmax*nmax
nmax=9;
%????????Imf
Imf=Inoise;
%??????????????????
%??????????????Inoise???????:I_ex[(Im+(nmax-1))*(In+(nmax-1))]
I_ex=[zeros((nmax-1)/2,In+(nmax-1));zeros(Im,(nmax-1)/2),Inoise,zeros(Im,(nmax-1)/2);zeros((nmax-1)/2,In+(nmax-1))];
%% ???????
%????Inoise?????
for x=1:Im
    for y=1:In
        for n=nmin:2:nmax
                %??Inoise????(x,y)???Sxy????I_ex??(x+[(nmax-1)/2-(n-1)/2]:x+[(nmax-1)/2-(n-1)/2]+(n-1),y+(nmax-1)/2-(n-1)/2:y+[(nmax-1)/2-(n-1)/2]+(n-1)) 
                Sxy=I_ex(x+(nmax-1)/2-(n-1)/2:x+(nmax-1)/2+(n-1)/2,y+(nmax-1)/2-(n-1)/2:y+(nmax-1)/2+(n-1)/2);
                Smax=max(max(Sxy));%???????????
                Smin=min(min(Sxy));%???????????
                Smed=median(median(Sxy));%??????????
                %??????????
                if Smed>Smin && Smed<Smax
                   %???????????????????
                   %??????if??????????????
                   %?????????????????
                   if Imf(x,y)<=Smin || Imf(x,y)>=Smax
                      %?????????????????????? 
                      %??????????????
                      %???????
                      Imf(x,y)=Smed;
                   end
                   break
                   %????????????
                end
        end
        %?n=max??????
        Imf(x,y)=Smed;
    end
end
subplot(2,2,3),imshow(Imf);xlabel('d.?????9??????????????');
%% ???????????
Imf1=medfilt2(Inoise,[3,3]);
Imf2=medfilt2(Imf1,[3,3]);
subplot(2,2,4),imshow(Imf2);xlabel('e.???3??????????????');
