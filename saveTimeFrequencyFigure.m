function saveTimeFrequencyFigure(wt, ii, label,imageRoot)
% saveTimeFrequencyRep(wt, ii, label)

im = ind2rgb(im2uint8(rescale(wt)), jet(128));
imgLoc = fullfile(imageRoot);
imFileName = string(label) + "_" + ii + ".jpg";
imwrite(imresize(im, [224 224]), char(fullfile(imgLoc, imFileName)));
end