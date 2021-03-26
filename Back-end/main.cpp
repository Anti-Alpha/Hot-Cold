#include "matrix.h"

using namespace std;

int main(){
    ifstream in("/Users/fimarubin/Documents/Documents_fimas_MacBook_Pro/Coding/VisualStudio/Hot-Cold/Back-end/data.txt");
    stringstream out;

    S_Table t = getdata(in);

    // print initial system
    cout<<simplex(t).str();
    return 0;

}
