

function pic = pasteimage(pic, fan, startRow, startCol, mask)
    [fanRows, fanCols, ~] = size(fan);
    target = pic(startRow:(startRow+fanRows-1), startCol:(startCol+fanCols-1), :);
    target(mask) = fan(mask);
    pic(startRow:(startRow+fanRows-1), startCol:(startCol+fanCols-1), :) = target;
end