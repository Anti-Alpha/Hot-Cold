#include "matrix.h"
#include <iomanip>
#include <algorithm>
#include <cmath>
#include <cctype>
#include "/usr/local/include/node/node.h"

using namespace std;

S_Table getdata(ifstream &in){
    S_Table t;
    t.out.str(string());
    in >> t.lim_number;
    in >> t.var_number;
    t.width = t.lim_number + t.var_number;
    t.height = t.lim_number;
    t.delta = new double [t.width];
    t.a = new double *[t.height];
    t.sign = new int[t.height];
    t.b = new double[t.height];
    t.z = new double[t.width];
    t.cb = new double *[t.height];
    t.theta = new double[t.height];
    t.coor = new int *[t.height];
    t.delta0 = 0;
    // Scan system
    for(int i = 0; i < t.height; i++){
        t.a[i] = new double[t.width];
        for(int j = 0; j < t.width; j++){
            if(j < t.var_number) {
                in >> t.a[i][j];
            }else
                (j == t.var_number + i) ? t.a[i][j] = 1 : t.a[i][j] = 0;
        }
        t.sign[i] = -1;
        t.b[i] = 1.0;
    }

    // Scan Z-function
    for(int i = 0; i < t.var_number; i++){
        t.z[i] = 1;
    }

    // Initial left of function with zeroes
    for(int i = t.var_number; i < t.width; i++){
        t.z[i] = 0;
    }

    // Initial tendency of Z-function
    t.way = "max";
    t.minimax = 1;

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

    //Initializing Y
    t.y = new double[t.width];

    t.nu = 0;

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
            if(i != row) {
//                cout<<"b["<<i<<"] = "<<b[i]<<" - "<<b[row]<<"*"<<div<<" = "<<b[i] - b[row]*div<<endl;
                b[i] -= b[row] * div;
            }
        }
    }
}

Point sPoint(double **a, int length, int width){
    double *minr = new double[length];
    double *maxc = new double[width];
    Point p;
    double min = 10000000;
    double max = -10000000;
    //min in rows
    for(int i = 0, x = 0; i < length; i++){
        for(int j = 0; j < width; j++){
            if(a[i][j] < min)
                min = a[i][j];
        }
        minr[x++] = min;
        min = 10000000;
    }
    for(int i = 0, x = 0; i < width; i++){
        for(int j = 0; j < length; j++){
            if(a[j][i] > max)
                max = a[j][i];
        }
        maxc[x++] = max;
        max = -10000000;
    }

    sort(minr, minr+length);
    sort(maxc, maxc+width);

    if(minr[length - 1] == maxc[0]){
        double t = minr[length - 1];
        for(int i = 0; i < length; i++){
            for(int j = 0; j < width; j++)
                if(a[i][j] == t){
                    p.x = i+1;
                    p.y = j+1;
                }
        }
    }else{
        p.x = -1;
        p.y = -1;
    }
    return p;
}

void simplex(S_Table *t){

    stringstream out;

    out<<"Initial system: \n";
    for(int i = 0; i < t->height; i++){
        for(int j = 0; j < t->var_number; j++){
            if(t->a[i][j] >= 0 && j != 0){
                out << " + "<<t->a[i][j]<<"*X"<< j+1;
            }else{
                out << t->a[i][j]<< "*X"<<j+1;
            }
        }
        switch(t->sign[i]){
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
        out << t->b[i] << endl;
    }

    // print Z-function
    out << "Z-function: ";
    for (int i = 0; i < t->width; i++) {
        if (t->z[i] >= 0 && i != 0)
            out << "+ " << t->z[i] << "*X" << i + 1 << " ";
        else
            out << t->z[i] << "*X" << i + 1 << " ";
    }
    out << "-> " << t->way << "\n\n";

    out<<"Coordinates of initial basis points:\n";
    for(int i = 0; i < t->height; i++){
        out<<"coor "<<i<<": "<<"("<<t->coor[i][0]<<", "<<t->coor[i][1]<<")\n";
    }

    int x = 1;
    out<<"\nInitial Cb:\n";
    for(int i = 0; i < t->height; i++){
        out<<"basis"<<t->cb[i][0]<<": "<<t->cb[i][1]<<endl;
    }


    int solutions = -1; // 0 - no solutions, 1 - there is one solution, 2 - there are infinitely many solutions
    // Iterations
    while(true) {
        out<<"\n---------------------------Iteration #"<<x<<"---------------------------\n";
        t->delta0 = 0;
        bool f = false;

        zh_gauss(t->a, t->b, t->height, t->width, t->coor, t->height);

        //Counting and printing deltas
        // *delta
        for (int i = 0; i < t->width; i++) {
            t->delta[i] = 0;
            for (int j = 0; j < t->height; j++) {
                t->delta[i] += t->a[j][i] * t->cb[j][1];
            }
            t->delta[i] -= t->z[i];
        }
        // delta0
        for (int i = 0; i < t->height; i++) {
            t->delta0 += t->cb[i][1] * t->b[i];
        }
        // Finding index of maximum element in deltas;
        double max = -10000;
        int maxi = 0; // The column to make basic column
        // Finding the column for the next basic
        for (int i = 0; i < t->width; i++) {
            if (t->delta[i] < 0 && abs(t->delta[i]) >= max) {
                max = abs(t->delta[i]);
                maxi = i;
            }
        }

        // Counting theta
        for (int i = 0; i < t->height; i++) {
            t->theta[i] = t->b[i] / t->a[i][maxi];
        }
        double min = 10000;
        int mini; // The row to make basic row
        // Finding the row fot the next basics
        for (int i = 0; i < t->height; i++) {
            if (t->theta[i] < min) {
                min = t->theta[i];
                mini = i;
            }
        }

        // Changing coordinates of basis points
        t->coor[mini][0] = mini;
        t->coor[mini][1] = maxi;

        // Printing Simplex-table
        for(int i = 0; i < t->height; i++){
            out<<"X"<<t->cb[i][0] + 1<<"|";
            out<<t->cb[i][1]<<"|";
            out<<t->b[i]<<"|";
            for(int j = 0; j < t->width; j++){
                out<<t->a[i][j]<<"|";
            }
            out<<t->theta[i]<<"|\n";
            out<<"------------------------------------------------------\n";
        }
        out<<"\t|"<<t->delta0<<"|";
        for(int i = 0; i < t->width; i++){
            out<<t->delta[i]<<"|";
        }
        out<<"\n";
        for(int i = 0; i < t->height; i++){
            out<<"X"<<t->cb[i][0] + 1<<" = "<<t->cb[i][1]<<endl;
        }

        // checking for infinite solution or 1 solution
        for(int i = 0; i < t->width; i++){
            if(t->delta[i] < 0){
                f = true;
                break;
            }
            if(t->delta[i] == 0){
                bool presents = false;
                for(int j = 0; j < t->height; j++){
                    if(t->cb[j][0] == i) {
                        presents = true;
                        break;
                    }
                }
                if(!presents){
                    solutions = 2;
                    break;
                }
            }
        }
        if(solutions == 2) break;
        if(!f){
            solutions = 1;
            out<<"Completed, no more steps needed\n";
            break;
        }
        // Checking for infinity of Z -> incompatibility of system
        f = false;
        for(int i = 0; i < t->height; i++){
            if(t->a[i][maxi] > 0){
                f = true;
                break;
            }
        }
        if(!f){
            solutions = 0;
            break;
        }
        t->cb[mini][0] = maxi;
        t->cb[mini][1] = t->z[mini];
        x++;
        if(x == 1000) break;
    }

    switch (solutions) {
        case 1:
            out << "\n\n\n---------------------------Task Solved---------------------------\n";
            out << "Zmax = " << t->delta0 << endl;
            out << "Y = (";
            for (int i = 0; i < t->width; i++) {
                bool exists = false;
                int r;
                for (int j = 0; j < t->height; j++) {
                    if (t->cb[j][0] == i) {
                        r = j;
                        exists = true;
                        break;
                    }
                }
                t->y[i] = (exists ? t->b[r] : 0);
                out << t->y[i] << (i == t->width - 1 ? ")\n" : ", ");
            }
            t->nu = 1/t->delta0;
            out << "Nu: " << t->nu << " - the price of game\n";
            out<<"Y*Nu = "<<"(";
            for(int i = 0; i < t->var_number; i++){
                t->y[i]*=t->nu;
                out<<t->y[i]<<((i == t->var_number - 1) ? ")\n": ", ");
            }
            out<<"\n\n\n---------------------------Results---------------------------\n";
            for(int i = 0; i < t->var_number; i++){
                out<<"Strategy "<<i+1<<" company should choose with probability: "<<fixed<<setprecision(3)<<t->y[i]<<"\n";
            }
            break;
        case 0:
            out<<"NO SOLUTIONS\n";
            break;
        case 2:
            out<<"Infinitely many solutions\nZmax = " << t->delta0 <<"\nFor example:\n";
            out << "Y = (";
            for (int i = 0; i < t->width; i++) {
                bool exists = false;
                int r;
                for (int j = 0; j < t->height; j++) {
                    if (t->cb[j][0] == i) {
                        r = j;
                        exists = true;
                        break;
                    }
                }
                t->y[i] = (exists ? t->b[r] : 0);
                out << t->y[i] << (i == t->width - 1 ? ")\n" : ", ");
            }
            t->nu = 1/t->delta0;
            out << "Nu: " << t->nu << " - the price of game\n";
            out<<"Y*Nu = "<<"(";
            for(int i = 0; i < t->var_number; i++){
                t->y[i]*=t->nu;
                out<<t->y[i]<<((i == t->var_number - 1) ? ")\n": ", ");
            }
            out<<"\n\n\n---------------------------Results---------------------------\n";
            for(int i = 0; i < t->var_number; i++){
                out<<"Strategy "<<i+1<<" company should choose with probability: "<<fixed<<setprecision(3)<<t->y[i]<<"\n";
            }
            break;
        default:
            out<<"SOME SHIT, MAN";
            break;

    }

    t->out<<out.str();
}

void matrixGameSolver(const v8::FunctionCallbackInfo<v8::Value>& args){
    v8::Isolate* isolate = args.GetIsolate();

    string season;
    ifstream in("./data.txt");
    in>>season;
    in.close();
    for(int i = 0; i < season.length(); i++){
        tolower(season[i]);
    }
    toupper(season[0]);
    string file_path = "./Seasons/"+season+".txt";
    ifstream maIN(file_path);
    S_Table t = getdata(maIN);
    maIN.close();
    Point p = sPoint(t.a, t.lim_number, t.var_number);
    stringstream out;
    int res = 0;
    if(p.x != -1){
        if(season == "Winter"){
            res = 0 + p.x;
        }else if(season == "Spring"){
            res = 3 + p.x;
        }else if(season == "Summer"){
            res = 6 + p.x;
        }else if(season == "Autumn"){
            res = 9 + p.x;
        }
        out<<"The strategy for company is #"<<res;
    }else{
        res = -1;
        simplex(&t);
        out<<"No Saddle Point!\nSolving with Simplex Method:\n\n"<<t.out.str();
    }
    ofstream outfile("./output.txt");
    outfile<<out.str();

    auto total = v8::Number::New(isolate, res);

    args.GetReturnValue().Set(total);
}

void Initialize(v8::Local<v8::Object> exports){
    NODE_SET_METHOD(exports, "matrixGameSolver", matrixGameSolver);
}

NODE_MODULE(addon, Initialize);
