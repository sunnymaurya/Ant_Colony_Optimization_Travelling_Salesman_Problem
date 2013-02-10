%sunny kumar maurya

function [x,y,dist,pheromone,invdist,iter,alpha,beta,evapcoeff,antsno,n,initialpos]=ants_initialinfo
iter=100;antsno=10;
evapcoeff=.1;alpha=5;beta=2;
x=[8 0 -1 2 4 6 3 10 2.5 -5 7 9 11 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 12 23 21 9 4 32 21 32 16 17 17 21 29 1 9 10 2 2 2];
y=[2 4 6 -1 -2 0.5 0 3.7 1.8 1 0 4 3 2 3 4 5 6 7 9 1 4 2 3 5 3 8 6 5 8 10 1 5 8 3 4 12 13 14 11 8 10 16 10 1 9 10 8 12 14];
n=length(x);
disp(n)
for i=1:n
    for j=1:n
        dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        if dist(i,j)==0
            invdist(i,j)=0;
        else
            invdist(i,j)=1/dist(i,j);
        end
    end
end
pheromone=0.00001*ones(n);

for i=1:antsno
    initialpos(i,1)=round(1+rand*(n-1));
end