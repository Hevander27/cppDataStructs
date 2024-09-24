function mutinfo = mutualinfo(img1,img2)
%This funtion takes in two image arrays and outputs their mutual
%information in the format of mutinfo=mutualinfo(img1,img2)
img1=img1(:,:,1);
img2=img2(:,:,1);

img1d=reshape(img1,1,size(img1,1)*size(img1,2));
zero1=zeros(1,256);
zero2=zero1;

for i=1:length(img1d);
    zero1(img1d(i)+1)=zero1(img1d(i)+1)+1;
end

locate1=zero1==0;
zero1(locate1)=[];
prob=zero1./sum(zero1);

entropy1=-sum(prob.*log2(prob))

img2d=reshape(img2,1,size(img2,1)*size(img2,2));
for i=1:length(img2d);
    zero2(img2d(i)+1)=zero2(img2d(i)+1)+1;
end

locate2=zero2==0;
zero2(locate2)=[];
prob2=zero2./sum(zero2);

entropy2=-sum(prob2.*log2(prob))

if size(img1,1)>size(img2,1)
    rows=size(img1,1);
else
    rows=size(img2,1);
end

if size(img1,2)>size(img2,2);
    cols=size(img1,2);
else
    cols=size(img2,2);
end

empty1=zeros(rows,cols);
empty2=empty1;
for i=1:size(img1,1);
    for j=1:size(img1,2);
        empty1(i,j)=img1(i,j);
    end
end

for i=1:size(img2,1);
    for j=1:size(img2,2);
        empty2(i,j)=img2(i,j);
    end
end

histogram=zeros(256,256);
for i=1:size(empty1,1);
    for j=1:size(empty1,2);
        histogram(empty1(i,j)+1,empty2(i,j)+1)=histogram(empty1(i,j)+1,empty2(i,j)+1)+1;
    end
end
imshow(histogram)

histogram1d=reshape(histogram,1,size(histogram,1)*size(histogram,2));
zero3=zeros(1,max(histogram1d+1));
for i=1:length(histogram1d);
    zero3(histogram1d(i)+1)=zero3(histogram1d(i)+1)+1;
end
 locate3=zero3==0;
 zero3(locate3)=[];
 prob3=zero3./sum(zero3);
 
 entropy3=-sum(prob3.*log2(prob3));




mutinfo=entropy1+entropy2-entropy3;
