function vecOut = makeVector(matrixIn)
%MAKEVECTOR This function returns the vectorized version of the input
% Input: matrix
% Output: vectorized version of the input matrix

if(~isnumeric(matrixIn))
   error('Make sure the matrix is numeric.'); 
end
if(ndims(matrixIn) > 2)
   error('Make sure the matrix has no more than two dimensions.'); 
end

vecOut = matrixIn(:);