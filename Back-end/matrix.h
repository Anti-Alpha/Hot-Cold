//
// Created by fima rubin on 24.03.2021.
//

#include <vector>
#include <algorithm>
#include <set>
#include <sstream>
#include <fstream>
#include <math.h>
#include <iostream>


using namespace std;

#ifndef BACK_END_MATRIX_H
#define BACK_END_MATRIX_H

struct S_Table{
    int lim_number; // number of limitations
    int var_number; // number of variables
    double *delta; // delta array which contains deltas
    double **a; // system itself
    int *sign; // signs of inequalities
    double *b; // right side of inequalities
    double *z; // coefficient in Z function
    double **cb; // Cb 2-dimensional array. 1st column - #  of basis variable, 2nd column - value of # basis variable
    double delta0; // delta0
    double *theta; // Theta meanings;
    int **coor; //coordinates of basis variables in system
    string way; // Does it tend to max or minimum
    int width; // width of system
    int height; // height of system
    int minimax;
};

vector <pair <int, int> > Saddle_point(vector < vector<double> > v);

void print_pair(pair <double, double> p);

vector <int> Wald_criterion(vector < vector<double> > v);

vector <int> Hurwitz_criterion(vector < vector<double> > v, double k);

template <class T>
void print_vector(vector <T> v);

vector <int> Savage_criterion(vector < vector<double> > v);

vector < vector <double> > removal(vector < vector < double > > v);

bool cmp(vector<double> v1, vector<double> v2);

void subtraction(vector<double> v1, vector <double> v2);

void multiplication(vector<double> v1, double c);

void zh_gauss(double **a, double *b, int n, int m, int **coor, int length);

S_Table getdata(ifstream &in);

#endif //BACK_END_MATRIX_H
