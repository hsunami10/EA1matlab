function MSE = calcMSE(x1, x2)

v1 = makeVector(x1);
v2 = makeVector(x2);

MSE_init = 0;
for ii = 1:length(v1)
   MSE_init = MSE_init + (v1(ii)-v2(ii))^2;
end

MSE = 1/length(v1) * MSE_init;