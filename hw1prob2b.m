clc
clear variables

syms s

b = RR_poly([1,0,-29,0,100]);
a = RR_poly([1,0,-46,0,369,0,-324]);
f= RR_poly([1,20,154,576,1089,972,324]);

i=0
[x_new,y_new] = RR_diophantine(a,b,f)
while length(y_new.poly) > length(x_new.poly)
    i=i+1 
    new_f = RR_poly(sym2poly((s+1)*(s+1)*(s+3)*(s+3)*(s+6)*(s+6)*(s+20)^i))
    [x_new,y_new] = RR_diophantine(a,b,new_f)
    length(y_new.poly)
    length(x_new.poly)
end

x_new
y_new

(x_new*a - b*y_new) - new_f
