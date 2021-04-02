#include "matrix.h"

using namespace std;

int main(){

//    ifstream in("/Users/fimarubin/Documents/Documents_fimas_MacBook_Pro/Coding/VisualStudio/Hot-Cold/Back-end/data.txt");
    ifstream csv("/Users/fimarubin/Documents/Documents_fimas_MacBook_Pro/Coding/VisualStudio/Hot-Cold/Back-end/Data_Final_Table.txt");
    S_Table t = getdata(csv);

    csv.close();
    vector<pair<int, int>> points = Saddle_point(AtoV(t.a, t.lim_number, t.var_number));
    if(points[0].first != -1){
        cout<<"There exists a solution at strategy #"<<points[0].first;
    }else{
        simplex(&t);
        cout<<"No Saddle Point!\nSolving with Simplex Method:\n\n"<<t.out.str();
    }

    return 0;
}
