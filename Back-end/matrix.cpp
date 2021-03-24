#include "matrix.h"
#include <iostream>

using namespace std;

S_Table getdata(ifstream &in){
    S_Table t;
    in >> t.lim_number;
    in >> t.var_number;
    t.width = t.lim_number + t.var_number;
    t.height = t.lim_number;
    t.delta = new double [t.width];
    t.a = new double *[t.height];
    t.sign = new int[t.height];
    t.b = new double[t.height];
    t.z = new double[t.width];
    t.cb = new double *[t.lim_number];
    t.theta = new double[t.lim_number];
    t.coor = new int *[t.lim_number];
    t.delta0 = 0;
    // Scan system
    for(int i = 0; i < t.height; i++){
        t.a[i] = new double[t.width];
        for(int j = 0; j < t.width; j++){
            if(j < t.var_number)
                in>>t.a[i][j];
            else
                (j == t.var_number + i) ? t.a[i][j] = 1 : t.a[i][j] = 0;
        }

        string sn;
        t.sign[i] = -2;
        while(t.sign[i] != -1 && t.sign[i] != 0 && t.sign[i] != 1) {
            in>>sn;
            if (sn.compare("<=") == 0) t.sign[i] = -1;
            else if (sn.compare("=") == 0) t.sign[i] = 0;
            else if (sn.compare(">=") == 0) t.sign[i] = 1;
            else cout<<"Wrong input. try another one\n";
        }
        in>>t.b[i];
    }

    // Scan Z-function
    for(int i = 0; i < t.var_number; i++){
        in>>t.z[i];
    }

    // Initial left of function with zeroes
    for(int i = t.var_number; i < t.width; i++){
        t.z[i] = 0;
    }

    // Initial tendency of Z-function
    in>>t.way;
    if(t.way == "max")
        t.minimax = 1;
    else if(t.way == "min")
        t.minimax = 0;
    else {
        cout << "Wrong input: "<<t.way;
    }

    // Coordinates of basis points in A-matrix
    for(int i = 0; i < t.height; i++){
        t.coor[i] = new int[2];
        t.coor[i][0] = i;
        t.coor[i][1] = i + t.var_number;
    }

    for(int i = 0; i < t.width; i++){
        t.delta[i] = -1;
    }

    // Initializing first Cb
    for (int i = 0; i < t.height; i++) {
        t.cb[i] = new double[2];
        t.cb[i][0] = i + t.var_number;
        t.cb[i][1] = t.z[i + t.var_number];
    }

    return t;
}

void zh_gauss(double **a, double *b, int n, int m, int **coor, int length){
    for(int k = 0; k < length; k++){
        int row = coor[k][0];
        int column = coor[k][1];
        double base = a[row][column];
//        cout<<base<<" "<<row<<" "<<column<<endl;
        for(int i = 0; i < m; i++){
            a[row][i]/=base;
        }
        b[row]/=base;
        for(int i = 0; i < n; i++){
            double div = a[i][column];
//            cout<<div<<endl;
            for(int j = 0; j < m; j++) {
                if (i != row){
//                    cout<<"a["<<i<<"]["<<j<<"] = "<<a[i][j]<<" - "<<a[row][j]<<" * "<<div<<" = "<<a[i][j] - a[row][j]*div<<endl;
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
