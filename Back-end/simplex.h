#ifndef _SIMPLEX_H_
#define _SIMPLEX_H_

#include <sstream>
#include "user_data.h"

class simplex : public user_data {
    public:
        void init();
        void gen_plane();
        bool plane_is_valid();
        bool function_is_undefined();
        void print_result_to_file(int it_num);
    private:
        double func;    // Z-function value
        double **bv;    // size = [num_v X 2] basic variables on the left and their numbers on the right
        double **sv;    // size = [num_l X num_v*2] initial matrix on the left and ones on the right at the place of initial free terms
        double *istr;   // size = [1 X num_v*2] Z-function coefficients times (-1) and zeroes on the first iteration
        double *th;     // size = [num_l] theta function
        double alm;     // element at the intersection of i_lrow and i_lcol
        int i_lrow;     // index of current main row
        int i_lcol;     // index of current main column
        std::stringstream table; // contains user's output
};

#endif