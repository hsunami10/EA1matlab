function PSNRs = computePSNRs(imgVec, imageDatabase)

maxImg = max(imgVec);

PSNRs = [];
for ii = 1:size(imageDatabase,2)
    if(maxImg > max(imageDatabase(:,ii)))
        PSNR = calcPSNR(imgVec, imageDatabase(:,ii), maxImg);
    else
        PSNR = calcPSNR(imgVec, imageDatabase(:,ii), max(imageDatabase(:,ii)));
    end
    PSNRs = [PSNRs PSNR];
end