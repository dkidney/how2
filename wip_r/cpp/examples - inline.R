################################################################################################################
################################################################################################################

# Examples with inline

################################################################################################################
################################################################################################################

require(inline)

code <- "
  SEXP res;
  int nprotect = 0, nx, ny, nz, x, y;
  PROTECT(res = Rf_duplicate(a)); nprotect++;
  nx = INTEGER(GET_DIM(a))[0];
  ny = INTEGER(GET_DIM(a))[1];
  nz = INTEGER(GET_DIM(a))[2];
  double sigma2 = REAL(s)[0] * REAL(s)[0], d2 ;
  double cx = REAL(centre)[0], cy = REAL(centre)[1], *data, *rdata;
  for (int im = 0; im < nz; im++) {
    data = &(REAL(a)[im*nx*ny]); rdata = &(REAL(res)[im*nx*ny]);
    for (x = 0; x < nx; x++)
      for (y = 0; y < ny; y++) {
        d2 = (x-cx)*(x-cx) + (y-cy)*(y-cy);
        rdata[x + y*nx] = data[x + y*nx] * exp(-d2/sigma2);
      }
  }
  UNPROTECT(nprotect);
  return res;
"
funx <- cfunction(signature(a="array", s="numeric", centre="numeric"), code)
x <- array(runif(50*50), c(50,50,1))
res <- funx(a=x, s=10, centre=c(25,15))
res[1:5,1:5,1] ; dim(res)


################################################################################################################

code <- "
    SEXP vecSum;
    int n;
    double *vec;
    n = length(x);
    vec = REAL(x);
    PROTECT(vecSum = allocVector(REALSXP, n)); 
    for (int i = 0; i < n; i++) DOUBLE(vecSum) += vec[i];
    UNPROTECT(1);
    return vecSum;
"
vecSum_cpp <- cfunction(signature(x="numeric"), code)

x <- seq(1,10,length=9) ; x

sum(x)

vecSum_cpp(x)

################################################################################################################

code <- "
    SEXP result;
    int nrows, ncols, nprotect;
    nrows = INTEGER(GET_DIM(x))[0];
    ncols = INTEGER(GET_DIM(x))[1];
    double *data, *prods;
    data = &(REAL(x)[nrows*ncols]);
    for (int col=0; col<ncols; col++) {
        for (int row=0; row<nrows; row++) {
            prods[col] *= data[row + ncols*nrows];
        }
    }
    PROTECT(result = prods);
    return result;
"

colProds_cpp <- cfunction(signature(x="matrix"), code)

x <- matrix(seq(1,10,length=9), 3)

apply(x,2,prod)

colProds_cpp(x)

################################################################################################################
################################################################################################################


