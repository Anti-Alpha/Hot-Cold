#include "matrix.h"

using namespace std;

int main(){
    ifstream in("/Users/fimarubin/Documents/Documents_fimas_MacBook_Pro/Coding/VisualStudio/Hot-Cold/Back-end/data.txt");
    stringstream out;

    S_Table t = getdata(in);

    // print initial system
    out<<"Initial system: \n";
    for(int i = 0; i < t.height; i++){
        for(int j = 0; j < t.var_number; j++){
            if(t.a[i][j] >= 0 && j != 0){
                out << " + "<<t.a[i][j]<<"*X"<< j+1;
            }else{
                out << t.a[i][j]<< "*X"<<j+1;
            }
        }
        switch(t.sign[i]){
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
        out << t.b[i] << endl;
    }

    out<<"Coordinates of initial basis points:\n";
    for(int i = 0; i < t.height; i++){
        out<<"coor "<<i<<": "<<"("<<t.coor[i][0]<<", "<<t.coor[i][1]<<")\n";
    }

    bool result = false;
    int x = 1;

    while(true) {
        out<<"---------------------------Iteration #"<<x<<"---------------------------\n";
        // Check for compatibility of a system
        bool f = false;
        for(int i = 0; i < t.width; i++){
            if(t.delta[i] < 0){
                f = true;
                break;
            }
        }
        if(!f){
            result = true;
            break;
        }

        zh_gauss(t.a, t.b, t.height, t.width, t.coor, t.height);



        //print system of equations
        out << "System of equations: \n";
        for (int i = 0; i < t.height; i++) {
            for (int j = 0; j < t.width; j++) {
                if (t.a[i][j] >= 0 && j != 0) {
                    out << " + " << t.a[i][j] << "*X" << j + 1;
                } else {
                    out << t.a[i][j] << "*X" << j + 1;
                }
            }
            out << " = ";
            out << t.b[i] << endl;
        }

        // print Z-function
        out << "Z-function: ";
        for (int i = 0; i < t.width; i++) {
            if (t.z[i] >= 0 && i != 0)
                out << "+ " << t.z[i] << "*X" << i + 1 << " ";
            else
                out << t.z[i] << "*X" << i + 1 << " ";
        }
        out << "-> " << t.way << endl;

        //Counting and printing deltas
        out << "Deltas:\n";

        for (int i = 0; i < t.width; i++) {
            t.delta[i] = 0;
            for (int j = 0; j < t.height; j++) {
                t.delta[i] += t.a[j][i] * t.cb[j][1];
            }
            t.delta[i] -= t.z[i];
            out << "delta" << i + 1 << ": " << t.delta[i] << endl;
        }

        for (int i = 0; i < t.var_number; i++) {
            t.delta0 += t.cb[i][1] * t.b[i];
        }

        out << "\nDelta0: " << t.delta0 << endl;

        // Finding index of maximum element in deltas;

        double max = -10000;
        int maxi = 0; // The column to make basic column

        // Finding the column for the next basic
        for (int i = 0; i < t.width; i++) {
            if (abs(t.delta[i]) >= max) {
                max = abs(t.delta[i]);
                maxi = i;
            }
        }

        // Checking for infinity of Z -> incompatibility of system
        f = false;
        for(int i = 0; i < t.height; i++){
            if(t.a[i][maxi] > 0){
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
        for (int i = 0; i < t.height; i++) {
            t.theta[i] = t.b[i] / t.a[i][maxi];
            out << "theta" << i + 1 << ": " << t.theta[i] << "\n";
        }

        double min = 10000;
        int mini; // The row to make basic row

        // Finding the row fot the next basics
        for (int i = 0; i < t.height; i++) {
            if (t.theta[i] < min) {
                min = t.theta[i];
                mini = i;
            }
        }
        out << "minimum of thetas: " << min << "\n";

        out<<"Next basic variable is at position: ("<<maxi<<", "<<mini<<")";
        out<<"\nAnd it is: "<<t.a[maxi][mini]<<endl;

        // Changing coordinates of basis points and printing them out
        t.coor[mini][0] = mini;
        t.coor[mini][1] = maxi;
        out<<"Coordinates of new basis points:\n";
        for(int i = 0; i < t.height; i++){
            out<<"coor "<<i<<": "<<"("<<t.coor[i][0]<<", "<<t.coor[i][1]<<")\n";
        }

        // Changing cb values and printing them out
        t.cb[mini][0] = maxi;
        t.cb[mini][1] = t.z[mini];
        out<<"New Cb:\n";
        for(int i = 0; i < t.height; i++){
            out<<"basis"<<t.cb[i][0]<<": "<<t.cb[i][1]<<endl;
        }
        x++;

        cout << out.str();
        out.str(string());
        if(x == 7) break;
    }

    return 0;

}
