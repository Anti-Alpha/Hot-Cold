#ifndef _USER_DATA_H_
#define _USER_DATA_H_

class user_data {
    public:
        void get_data_from_user();
        void user_data_is_valid();
        void stage_passed();
    protected:
        double *function; // size = [1 X num_v] Z-function coefficients
        double *fm;       // size = [1 X num_l] Free terms
        double **system;  // size = [num_l X num_v] Main system
        int *sign;        // size = [1 X num_l] Equality or which inequaliy of every limitation
        int num_v;        // number of variables
        int num_l;        // number of limitations
        bool way;         // Whether the function tend to max or minimum
};

#endif