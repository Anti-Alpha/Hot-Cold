//
// Created by fima rubin on 24.03.2021.
//

#include <sstream>
#include <fstream>
#include <iostream>

using namespace std;

#ifndef BACK_END_MATRIX_H
#define BACK_END_MATRIX_H
struct S_Table {
    int lim_number; // number of limitations
    int var_number;  // number of variables
    int strategy; 
    double *delta; // delta array which contains deltas
    double **a; // system itself
    int *sign; // signs of inequalities
    double *b; // right side of inequalities
    double *z; // coefficient in Z function
    double **cb; // Cb 2-dimensional array. 1st column - #  of basis variable, 2nd column - value of # basis variable
    double delta0; // delta0
    double *theta; // Theta meanings;
    int **coor; //coordinates of basis variables in system
    double *y;
    double nu; //price of game
    string way; // Does it tend to max or minimum
    int width; // width of system
    int height; // height of system
    int minimax;
    stringstream out;
    string season;
};

struct Point{
int x, y;
};

Point sPoint(double **a, int length, int width);

void zh_gauss(double **a, double *b, int n, int m, int **coor, int length);

S_Table getdata(ifstream &in);

void simplex(S_Table *t);

void matrixGameSolver();

#endif //BACK_END_MATRIX_H
