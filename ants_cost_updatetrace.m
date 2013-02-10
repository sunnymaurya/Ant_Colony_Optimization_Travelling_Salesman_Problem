% sunny ants cost update based on pheromone.

function [cost,pheromone]=ants_cost_updatetrace(antsno,n,dist,antstour,evapcoeff,pheromone)
for i=1:antsno
    temp=0;
    for j=1:n
        temp=temp+dist(antstour(i,j),antstour(i,j+1));
    end
    cost(i)=temp;
end

for i=1:antsno
    for j=1:n
        deltat=1/cost(i);
        pheromone(antstour(i,j),antstour(i,j+1))=(1-evapcoeff)*pheromone(antstour(i,j),antstour(i,j+1))+deltat;
    end
end
