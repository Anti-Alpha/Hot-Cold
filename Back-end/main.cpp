#include <iostream>
#include <vector>
#include <algorithm>
#include <set>
#include <stdio.h>
#include "simplex.h"
#include <fstream>
#include <math.h>

using namespace std;

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

int main(){
    ifstream in("data.txt");
    stringstream out;
    int lim_number, var_number, minimax;
    in>>lim_number;
    in>>var_number;
    double *delta = new double [var_number + lim_number];
    double **a = new double *[lim_number];
    int *sign = new int[lim_number];
    double *b = new double[lim_number];
    double *z = new double[var_number + lim_number];
    double **cb = new double *[lim_number];
    double delta0;
    double *theta = new double[lim_number];
    int **coor = new int *[lim_number];
    string way;
    // Scan system
    for(int i = 0; i < lim_number; i++){
        a[i] = new double[var_number+lim_number];
        for(int j = 0; j < var_number + lim_number; j++){
            if(j < var_number)
                in>>a[i][j];
            else
                (j == var_number + i) ? a[i][j] = 1 : a[i][j] = 0;
        }

        string sn;
        sign[i] = -2;
        while(sign[i] != -1 && sign[i] != 0 && sign[i] != 1) {
            in>>sn;
            if (sn.compare("<=") == 0) sign[i] = -1;
            else if (sn.compare("=") == 0) sign[i] = 0;
            else if (sn.compare(">=") == 0) sign[i] = 1;
            else cout<<"Wrong input. try another one\n";
        }
        in>>b[i];
    }

    // Scan Z-function
    for(int i = 0; i < var_number; i++){
        in>>z[i];
    }

    // Initialize Z-function with extra variables
    for(int i = var_number; i < var_number+lim_number; i++){
        z[i] = 0;
    }

    in>>way;

    if(way == "max")
        minimax = 1;
    else if(way == "min")
        minimax = 0;
    else {
        cout << "Wrong input: "<<way;
    }

    // print initial system
    out<<"Initial system: \n";
    for(int i = 0; i < lim_number; i++){
        for(int j = 0; j < var_number; j++){
            if(a[i][j] >= 0 && j != 0){
                out << " + "<<a[i][j]<<"*X"<< j+1;
            }else{
                out << a[i][j]<< "*X"<<j+1;
            }
        }
        switch(sign[i]){
            case -1:
                out << " <= ";
                break;
            case 0:
                out << " = ";
                break;
            case 1:
                out << " >= ";
                break;
            default:
                break;
        }
        out << b[i] << endl;
    }

    // Initializing basis points and printing them
    for(int i = 0; i < lim_number; i++){
        coor[i] = new int[2];
    }
    out<<"Coordinates of initial basis points:\n";
    for(int i = 0; i < lim_number; i++){
        coor[i][0] = i;
        coor[i][1] = i + var_number;
        out<<"coor "<<i<<": "<<"("<<coor[i][0]<<", "<<coor[i][1]<<")\n";
    }

    // Initializing Delta
    for(int i = 0; i < var_number + lim_number; i++){
        delta[i] = -1;
    }

    bool result = false;

    // Initializing first Cb
    for (int i = 0; i < lim_number; i++) {
        cb[i] = new double[2];
    }
    for (int i = 0; i < lim_number; i++) {
        cb[i][0] = i + var_number;
        cb[i][1] = z[i + var_number];
    }
    int x = 1;

    while(true) {
        out<<"---------------------------Iteration #"<<x<<"---------------------------\n";
        // Check for compatibility of a system
        bool f = false;
        for(int i = 0; i < var_number + lim_number; i++){
            if(delta[i] < 0){
                f = true;
                break;
            }
        }
        if(!f){
            result = true;
            break;
        }

        zh_gauss(a, b, lim_number, var_number + lim_number, coor, lim_number);



        //print system of equations
        out << "System of equations: \n";
        for (int i = 0; i < lim_number; i++) {
            for (int j = 0; j < var_number + lim_number; j++) {
                if (a[i][j] >= 0 && j != 0) {
                    out << " + " << a[i][j] << "*X" << j + 1;
                } else {
                    out << a[i][j] << "*X" << j + 1;
                }
            }
            out << " = ";
            out << b[i] << endl;
        }

        // print Z-function
        out << "Z-function: ";
        for (int i = 0; i < var_number + lim_number; i++) {
            if (z[i] >= 0 && i != 0)
                out << "+ " << z[i] << "*X" << i + 1 << " ";
            else
                out << z[i] << "*X" << i + 1 << " ";
        }
        out << "-> " << way << endl;

        //Counting and printing deltas
        out << "Deltas:\n";

        for (int i = 0; i < var_number + lim_number; i++) {
            delta[i] = 0;
            for (int j = 0; j < lim_number; j++) {
                delta[i] += a[j][i] * cb[j][1];
            }
            delta[i] -= z[i];
            out << "delta" << i + 1 << ": " << delta[i] << endl;
        }

        for (int i = 0; i < var_number; i++) {
            delta0 += cb[i][1] * b[i];
        }

        out << "\nDelta0: " << delta0 << endl;

        // Finding index of maximum element in deltas;

        double max = -10000;
        int maxi = 0; // The column to make basic column

        // Finding the column for the next basic
        for (int i = 0; i < var_number + lim_number; i++) {
            if (abs(delta[i]) >= max) {
                max = abs(delta[i]);
                maxi = i;
            }
        }

        // Checking for infinity of Z -> incompatibility of system
        f = false;
        for(int i = 0; i < lim_number; i++){
            if(a[i][maxi] > 0){
                f = true;
                break;
            }
        }
        if(!f){
            result = false;
            break;
        }

        // counitng and printing Thetas
        out << "Thetas:\n";
        for (int i = 0; i < lim_number; i++) {
            theta[i] = b[i] / a[i][maxi];
            out << "theta" << i + 1 << ": " << theta[i] << "\n";
        }

        double min = 10000;
        int mini; // The row to make basic row

        // Finding the row fot the next basics
        for (int i = 0; i < lim_number; i++) {
            if (theta[i] < min) {
                min = theta[i];
                mini = i;
            }
        }
        out << "minimum of thetas: " << min << "\n";

        out<<"Next basic variable is at position: ("<<maxi<<", "<<mini<<")";
        out<<"\nAnd it is: "<<a[maxi][mini]<<endl;

        // Changing coordinates of basis points and printing them out
        coor[mini][0] = mini;
        coor[mini][1] = maxi;
        out<<"Coordinates of new basis points:\n";
        for(int i = 0; i < lim_number; i++){
            out<<"coor "<<i<<": "<<"("<<coor[i][0]<<", "<<coor[i][1]<<")\n";
        }

        // Changing cb values and printing them out
        cb[mini][0] = maxi;
        cb[mini][1] = z[mini];
        out<<"New Cb:\n";
        for(int i = 0; i < lim_number; i++){
            out<<"basis"<<cb[i][0]<<": "<<cb[i][1]<<endl;
        }
        x++;

        cout << out.str();
        out.str(string());
        if(x == 7) break;
    }

    return 0;
    
}

void zh_gauss(double **a, double *b, int n, int m, int **coor, int length){
    for(int k = 0; k < length; k++){
        int row = coor[k][0];
        int column = coor[k][1];
        double base = a[row][column];
        cout<<base<<" "<<row<<" "<<column<<endl;
        for(int i = 0; i < m; i++){
            a[row][i]/=base;
        }
        b[row]/=base;
        for(int i = 0; i < n; i++){
            double div = a[i][column];
            cout<<div<<endl;
            for(int j = 0; j < m; j++) {
                if (i != row){
                    cout<<"a["<<i<<"]["<<j<<"] = "<<a[i][j]<<" - "<<a[row][j]<<" * "<<div<<" = "<<a[i][j] - a[row][j]*div<<endl;
                    a[i][j] -= a[row][j] * div;
                }else
                    break;
            }
            if(i != row)
                b[i]-=b[row]*div;
        }
    }
}

vector < vector <double> > removal(vector < vector<double> > v){
    set <int> rtbd; //rows to be deleted
    for(int i = 0; i < v.size(); i++){
        for(int j = 0; j < v.size(); j++)
            if( i != j && cmp(v[i], v[j]) ){
                rtbd.insert(i);
            }
    }
    vector < vector<double> > temp;
    for(int i = 0; i < v.size(); i++){
        set<int>::iterator it = rtbd.find(i);
        if(*it == *(rtbd.end())) {
            temp.push_back(v[i]);
        }
    }
    return temp;
}

bool cmp(vector<double> v1, vector<double> v2){
    for(int i = 0; i < v1.size(); i++){
        if(v1[i] > v2[i]){
            return false;
        }
    }
    return true;
}

vector <int> Savage_criterion(vector < vector<double> > v){
    int rows = v.size();
    int columns = v[0].size();
    vector < vector< double> > temp;
    vector < double > t;
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++){
            t.push_back(0);
        }
        temp.push_back(t);
        t.clear();
    }
    double max = -1000;
    vector < double > maxs;
    for(int i = 0; i < columns; i++){
        for(int j = 0; j < rows; j++){
            if(v[j][i] > max) {
                max = v[j][i];
            }
        }
        maxs.push_back(max);
        max = -1000;
    }
    for(int i = 0; i < columns; i++){
        for(int j = 0; j < rows; j++){
            temp[j][i] = maxs[i]-v[j][i];
        }
    }
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++){
            if(temp[i][j] > max)
                max = temp[i][j];
        }
        t.push_back(max);
        max = -1000;
    }

    vector <int> result;
    double min = 1000;
    for(int i = 0; i < t.size(); i++)
        if(t[i] < min)
            min = t[i];
    for(int i = 0; i < t.size(); i++)
        if(t[i] == min){
            result.push_back(i+1);
        }
    return result;

}

vector <int> Hurwitz_criterion(vector < vector<double> > v, double k){
    double min = 1000;
    double max = -1000;
    int rows = v.size();
    int columns = v[0].size();
    vector <double> h;
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++){
            if(v[i][j] > max) max = v[i][j];
            if(v[i][j] < min) min = v[i][j];
        }
        h.push_back(max*1.0*(1-k)+min*1.0*k);
        min = 1000;
        max = -1000;
    }
    vector <int> result;
    for(int i = 0; i < h.size(); i++)
        if(h[i] > max)
            max = h[i];
    for(int i = 0; i < h.size(); i++)
        if(h[i] == max){
            result.push_back(i+1);
        }
    return result;
}

vector <pair <int, int> > Saddle_point(vector < vector<double> > v){
    vector <double> min_rows;
    vector <double> max_columns;
    pair <int, int> point;
    double min = 1000;
    double max = -1000;
    int rows = v.size();
    int columns = v[0].size();
    // min in rows
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++)
            if(v[i][j] < min) 
                min = v[i][j];
        min_rows.push_back(min);
        min = 1000;
    }
    //max in columns
    for(int i = 0; i < columns; i++){
        for(int j = 0; j < rows; j++){
            if(v[j][i] > max) max = v[j][i];
        }
        max_columns.push_back(max);
        max = -1000;
    }
    
    sort(min_rows.begin(), min_rows.end());
    sort(max_columns.begin(), max_columns.end());

    vector <pair <int, int> > result_points;

    if(min_rows[rows - 1] == max_columns[0]){
        double t = min_rows[rows - 1];
        for(int i = 0; i < rows; i++){
            for(int j = 0; j < columns; j++)
                if(v[i][j] == t){
                    point.first = i+1;
                    point.second = j+1;
                    result_points.push_back(point);
                }
        }
    }else{
        point.first = -1;
        point.second = -1;
        result_points.push_back(point);
    }
    return result_points;
    
}

vector<int> Wald_criterion(vector < vector<double> > v){
    vector <double> min_rows;
    vector <int> result_rows;
    double min = 1000;
    int rows = v.size();
    int columns = v[0].size();
    // min in rows
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++)
            if(v[i][j] < min)
                min = v[i][j];
        min_rows.push_back(min);
        min = 1000;
    }
    double max = -1000;
    for(int i = 0; i < min_rows.size(); i++)
        if(min_rows[i] > max)
            max = min_rows[i];
    for(int i = 0; i < min_rows.size(); i++)
        if(min_rows[i] == max)
            result_rows.push_back(i+1);
    return result_rows;
}

void print_pair(pair <int, int> p){
    cout<<p.first<<" "<<p.second<<endl;
}

template <class T>
void print_vector(vector <T> v){
    for(typename vector<T>::iterator it = v.begin(); it < v.end(); ++it)
        cout<<*it<<" ";
    cout<<endl;
}

void subtraction(vector<double> v1, vector <double> v2){
    for(int i = 0; i < v1.size(); i++){
        v2[i]-=v1[i];
    }
}

void multiplication(vector<double> v1, double c){
    for(int i = 0; i < v1.size(); i++){
        v1[i]*=c;
    }
}