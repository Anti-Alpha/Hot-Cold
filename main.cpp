#include <iostream>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;

vector <pair <int, int> > Saddle_point(vector < vector<int> > v);

void print_pair(pair <int, int> p);

vector <int> Wald_criterion(vector < vector<int> > v);

vector <double> Hurwitz_criterion(vector < vector<int> > v, double k);

template <class T>
void print_vector(vector <T> v);

vector <int> Savage_criterion(vector < vector<int> > v);

vector < vector <int> > removal(vector < vector < int > > v);

bool cmp(vector<int> v1, vector<int> v2);

int main(){
    vector < vector <int> > v;
    int n, m;
    cin>>n>>m;
    int a;
    vector<int> temp;
    for(int i = 0; i < n; i++){
        for(int j = 0; j < m; j++){
            cin>>a;
            temp.push_back(a);
        }
        v.push_back(temp);
        temp.clear();
    }
    // Saddle point
    vector <pair<int, int> > saddle = Saddle_point(v);
    printf("Saddle number: %d\nSaddle points, if there are: ", v[saddle[0].first - 1][saddle[0].second - 1]);
    for(int i = 0; i < saddle.size(); i++){
        printf("(%d, %d); ", saddle[i].first, saddle[i].second);
    }
    cout<<endl;
    // Wald Criterion
    cout<<"Strategies to be chosen accroding to:\n\tWald Criterion: ";
    vector<int> wald;
    wald = Wald_criterion(v);
    print_vector(wald);

    // Hurwitz Criterion
    cout<<"\tHurwitz Criterion: ";
    vector <double> hurwitz;
    hurwitz = Hurwitz_criterion(v, 0.5);
    print_vector(hurwitz);

    // Savage Criterion
    cout<<"\tSavage Criterioin: ";
    vector<int> savage;
    savage = Savage_criterion(v);
    print_vector(savage);
    v = removal(v);
    cout<<"Simplified matrix: \n";
    for(int i = 0; i < v.size(); i++){
        for(int j = 0; j < v[0].size(); j++){
            cout<<v[i][j]<<" ";
        }
        cout<<endl;
    }

}

vector < vector <int> > removal(vector < vector<int> > v){
    set <int> rtbd; //rows to be deleted
    for(int i = 0; i < v.size(); i++){
        for(int j = 0; j < v.size(); j++)
            if( i != j && cmp(v[i], v[j]) ){
                rtbd.insert(i);
            }
    }
    vector < vector<int> > temp;
    for(int i = 0; i < v.size(); i++){
        set<int>::iterator it = rtbd.find(i);
        if(*it == *(rtbd.end())) {
            temp.push_back(v[i]);
        }
    }
    return temp;
}

bool cmp(vector<int> v1, vector<int> v2){
    for(int i = 0; i < v1.size(); i++){
        if(v1[i] > v2[i]){
            return false;
        }
    }
    return true;
}

vector <int> Savage_criterion(vector < vector<int> > v){
    int rows = v.size();
    int columns = v[0].size();
    vector < vector< int> > temp;
    vector < int > t;
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++){
            t.push_back(0);
        }
        temp.push_back(t);
        t.clear();
    }
    int max = -1000;
    vector < int > maxs;
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
    int min = 1000;
    for(int i = 0; i < t.size(); i++)
        if(t[i] < min)
            min = t[i];
    for(int i = 0; i < t.size(); i++)
        if(t[i] == min){
            result.push_back(i+1);
        }
    return result;

}

vector <double> Hurwitz_criterion(vector < vector<int> > v, double k){
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
    vector <double> result;
    for(int i = 0; i < h.size(); i++)
        if(h[i] > max)
            max = h[i];
    for(int i = 0; i < h.size(); i++)
        if(h[i] == max){
            result.push_back(i+1);
        }
    return result;
}

vector <pair <int, int> > Saddle_point(vector < vector<int> > v){
    vector <int> min_rows;
    vector <int> max_columns;
    pair <int, int> point;
    int min = 1000;
    int max = -1000;
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
        int t = min_rows[rows - 1];
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

vector<int> Wald_criterion(vector < vector<int> > v){
    vector <int> min_rows;
    vector <int> result_rows;
    int min = 1000;
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
    int max = -1000;
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