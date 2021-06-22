function coordinate_contact = coord_calc(a,b,c,x,y,z,i)
% this function is used for calculating the coordinate for each contact
% a,b,c are the first contact coordinates
% x,y,z are the direction vector, you can pick a out skull point on 
% the same electrode 
% here i stands for the contact number after the first contact, so
% for contact number 2, i = 1 and
% for contact number 3, i = 2 etc.
% 1 unit = 1mm
% diameter of the depth electrode: 0.8mm
% contact length 2mm
% space between 2 contacts 1.5mm
% space btween two contacts center: 3.5mm /3.5 unit
if x>a && y>b && z>c
    m = a + (3.5*i*(x-a))/(((x-a)^2+(y-b)^2+(z-c)^2)^(1/2));
    n = b + (3.5*i*(y-b))/(((x-a)^2+(y-b)^2+(z-c)^2)^(1/2));
    o = c + (3.5*i*(z-c))/(((x-a)^2+(y-b)^2+(z-c)^2)^(1/2));
elseif x>a && y<b && z>c
    m = a + (3.5*i*(x-a))/(((x-a)^2+(b-y)^2+(z-c)^2)^(1/2)); 
    n = b - (3.5*i*(b-y))/(((x-a)^2+(b-y)^2+(z-c)^2)^(1/2));  
    o = c + (3.5*i*(z-c))/(((x-a)^2+(b-y)^2+(z-c)^2)^(1/2));
elseif x>a && y>b && z<c
    m = a + (3.5*i*(x-a))/(((x-a)^2+(y-b)^2+(c-z)^2)^(1/2)); 
    n = b + (3.5*i*(y-b))/(((x-a)^2+(y-b)^2+(c-z)^2)^(1/2));  
    o = c - (3.5*i*(c-z))/(((x-a)^2+(y-b)^2+(c-z)^2)^(1/2)); 
elseif x>a && y<b && z<c
    m = a + (3.5*i*(x-a))/(((x-a)^2+(b-y)^2+(c-z)^2)^(1/2)); 
    n = b - (3.5*i*(b-y))/(((x-a)^2+(b-y)^2+(c-z)^2)^(1/2));  
    o = c - (3.5*i*(c-z))/(((x-a)^2+(b-y)^2+(c-z)^2)^(1/2));
elseif x<a && y>b && z>c
    m = a - (3.5*i*(a-x))/(((a-x)^2+(y-b)^2+(z-c)^2)^(1/2));  
    n = b + (3.5*i*(y-b))/(((a-x)^2+(y-b)^2+(z-c)^2)^(1/2)); 
    o = c + (3.5*i*(z-c))/(((a-x)^2+(y-b)^2+(z-c)^2)^(1/2)); 
elseif x<a && y<b && z>c
    m = a - (3.5*i*(a-x))/(((a-x)^2+(b-y)^2+(z-c)^2)^(1/2));  
    n = b - (3.5*i*(b-y))/(((a-x)^2+(b-y)^2+(z-c)^2)^(1/2));  
    o = c + (3.5*i*(z-c))/(((a-x)^2+(b-y)^2+(z-c)^2)^(1/2));
elseif x<a && y>b && z<c
    m = a - (3.5*i*(a-x))/(((a-x)^2+(y-b)^2+(c-z)^2)^(1/2));  
    n = b + (3.5*i*(y-b))/(((a-x)^2+(y-b)^2+(c-z)^2)^(1/2));  
    o = c - (3.5*i*(c-z))/(((a-x)^2+(y-b)^2+(c-z)^2)^(1/2)); 
elseif x<a && y<b && z<c
    m = a - (3.5*i*(a-x))/(((a-x)^2+(b-y)^2+(c-z)^2)^(1/2));  
    n = b - (3.5*i*(b-y))/(((a-x)^2+(b-y)^2+(c-z)^2)^(1/2)); 
    o = c - (3.5*i*(c-z))/(((a-x)^2+(b-y)^2+(c-z)^2)^(1/2));
end
coordinate_contact = [m n o];
end