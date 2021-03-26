#include "matrix.h"

using namespace std;

int main(){
    ifstream in("/Users/fimarubin/Documents/Documents_fimas_MacBook_Pro/Coding/VisualStudio/Hot-Cold/Back-end/data.txt");
    stringstream s;
    S_Table t = getdata(in);
    in.close();
    s = simplex(t);
    cout<<s.str();
    return 0;
}
