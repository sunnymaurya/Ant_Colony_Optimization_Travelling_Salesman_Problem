% sunny kumar maurya

clear();
[x,y,dist,pheromone,invdist,iteration,alpha,beta,evapcoeff,antsno,n,initialpos]=ants_initialinfo;
for i=1:iteration
    [initialpos,antstour]=ants_path(initialpos,antsno,n,invdist,pheromone,alpha,beta);
    [cost,pheromone]=ants_cost_updatetrace(antsno,n,dist,antstour,evapcoeff,pheromone);
    
end
[k,l]=min(mincost);
for i=1:n+1
    X(i)=x(besttour(l,i));
    Y(i)=y(besttour(l,i));
end
plot(X,Y,'--go','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',8)
xlabel(['X ','\rightarrow'],'fontsize',12,'fontweight','b');ylabel(['Y ','\rightarrow'],'fontsize',12,'fontweight','b');
for i=1:n
    text(X(i)+.5,Y(i),['\leftarrow node ',num2str(besttour(l,i))]);
end
title({['Total number of nodes:',num2str(n)] ['Optimum path is of length:',num2str(k)]},'fontsize',12);