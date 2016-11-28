function PSNRs = computePSNRs(imgVec, imageDatabase)

PSNRs = [];
for ii = 1:size(imageDatabase,2)
   PSNR = calcPSNR(imgVec, imageDatabase(:,ii));
   PSNRs = [PSNRs PSNR];
end